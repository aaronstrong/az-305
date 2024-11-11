# Simple Azure Network




## Code
Establish your envrionment variables.

```bash
export sandbox=$(az group list --query "[0].name" -o tsv)
export region=$(az group show --name $sandbox --query "location" -o tsv)
export MY_PUBLIC_IP=$(curl -s https://api.ipify.org)
vnet=myVnet
username=azureadmin
local_addr=192.168.0.0/16
sharedkey=mySecret
```

Create the VNet and Subnets

```bash
az network vnet create --resource-group $sandbox  --name $vnet --address-prefix 10.0.0.0/16 --subnet-name GatewaySubnet --subnet-prefix 10.0.4.0/27
az network vnet subnet create --name sn-webfrontend --resource-group $sandbox --vnet-name $vnet --address-prefix 10.0.5.0/26
az network vnet subnet create --name sn-database --resource-group $sandbox --vnet-name $vnet --address-prefix 10.0.5.64/28
az network vnet subnet create --name sn-endpoints --resource-group $sandbox --vnet-name $vnet --address-prefix 10.0.5.128/26
az network vnet subnet create --name AppGatewaySubnet --resource-group $sandbox --vnet-name $vnet --address-prefix 10.0.7.0/24
az network vnet subnet create --name sn-backend --resource-group $sandbox --vnet-name $vnet --address-prefix 10.0.6.0/27
```

Create the Network Security Groups and assign to Subnets

```bash
# Create NSG
az network nsg create --resource-group $sandbox --name myNetworkSecurityGroup

# Assign NSG to Subnets
az network vnet subnet update --resource-group $sandbox --vnet-name $vnet --name sn-webfrontend --network-security-group myNetworkSecurityGroup
az network vnet subnet update --resource-group $sandbox --vnet-name $vnet --name sn-database --network-security-group myNetworkSecurityGroup
az network vnet subnet update --resource-group $sandbox --vnet-name $vnet --name sn-endpoints --network-security-group myNetworkSecurityGroup
az network vnet subnet update --resource-group $sandbox --vnet-name $vnet --name sn-backend --network-security-group myNetworkSecurityGroup
```

Create the NSG ruleset

```bash
# CREATE NSG RULEs
# Allow RDP (TCP 3389)
az network nsg rule create \
  --resource-group $sandbox  \
  --nsg-name myNetworkSecurityGroup \
  --name allow-rdp \
  --protocol tcp \
  --priority 1000 \
  --destination-port-range 3389 \
  --access allow \
  --direction inbound

# Allow SSH (TCP 22)
az network nsg rule create \
  --resource-group $sandbox \
  --nsg-name myNetworkSecurityGroup \
  --name allow-ssh \
  --protocol tcp \
  --priority 2000 \
  --destination-port-range 22 \
  --access allow \
  --direction inbound

# Allow PSQL (TCP 5432)
az network nsg rule create \
  --resource-group $sandbox \
  --nsg-name myNetworkSecurityGroup \
  --name allow-psql \
  --protocol tcp \
  --priority 2020 \
  --destination-port-range 5432 \
  --access allow \
  --direction inbound
```

Create Private DNS

```bash
# Create PRIVAT DNS
az network private-dns zone create -g $sandbox -n private.contoso.com
az network private-dns link vnet create -g $sandbox -n MyDNSLink -z private.contoso.com -v $vnet -e true

# Create an additional DNS record
az network private-dns record-set a add-record -g $sandbox -z private.contoso.com -n azfiles -a 10.0.5.132
```

Create Site-to-Site with Route Base Policy

```bash
## Request a public IP address

az network public-ip create -n VNet1GWIP -g $sandbox

## View the public IP address

az network public-ip show --name VNet1GWIP --resource-group $sandbox

## Create the VPN Gateway

az network vnet-gateway create -n VNet1GW -l $region --public-ip-address VNet1GWIP -g $sandbox --vnet $vnet --gateway-type Vpn --sku VpnGw2 --vpn-gateway-generation Generation2 --no-wait

## Create the local network gateway

az network local-gateway create --gateway-ip-address $MY_PUBLIC_IP --name Site1 --resource-group $sandbox --local-address-prefixes $local_addr

## Configure your VPN Device

az network public-ip list --resource-group $sandbox --output table

## Create the VPN Connection

az network vpn-connection create --name VNet1toSite2 --resource-group $sandbox --vnet-gateway1 VNet1GW -l $region --shared-key $sharedkey --local-gateway2 Site1
```

Create a linux boxes and put into the Web frontend subnet

```bash
VM_IMAGE="Canonical:UbuntuServer:18.04-LTS:latest"
VM_NAME="ubuntu-web-vm"
VM_SIZE="Standard_B1s"  # Small, cost-effective size


az network public-ip create \
    --resource-group $sandbox \
    --name "${VM_NAME}-ip" \
    --sku Basic \
    --allocation-method Dynamic

# Create a network interface with the public IP
az network nic create \
    --resource-group $sandbox \
    --name "${VM_NAME}-nic" \
    --vnet-name $vnet \
    --subnet sn-webfrontend \
    --public-ip-address "${VM_NAME}-ip"

# Create the VM
az vm create \
    --resource-group $sandbox \
    --name $VM_NAME \
    --image $VM_IMAGE \
    --size $VM_SIZE \
    --admin-username azureuser \
    --generate-ssh-keys \
    --nics "${VM_NAME}-nic"

# Install NGINX
az vm extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --resource-group $sandbox --vm-name $VM_NAME --settings '{ "fileUris": ["https://raw.githubusercontent.com/Azure/azure-docs-powershell-samples/master/application-gateway/iis/install_nginx.sh"], "commandToExecute": "./install_nginx.sh" }'

---

# Create Multiple VMs
for i in `seq 1 2`; do
  az network nic create \
    --resource-group $sandbox \
    --name myNic$i \
    --vnet-name $vnet \
    --subnet sn-webfrontend
  az vm create \
    --resource-group $sandbox \
    --name $VM_NAME-$i \
    --nics myNic$i \
    --image $VM_IMAGE \
    --size $VM_SIZE \
    --admin-username azureuser \
    --generate-ssh-keys 
done

# Install NGINX
for i in `seq 1 2`; do
  az vm extension set --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group $sandbox \
  --vm-name $VM_NAME-$i \
  --settings '{ "fileUris": ["https://raw.githubusercontent.com/Azure/azure-docs-powershell-samples/master/application-gateway/iis/install_nginx.sh"], "commandToExecute": "./install_nginx.sh" }'
done




```

Create an Application Gateway
```bash
PUBLIC_IP_NAME="${APPGW_NAME}-ip"
APPGW_NAME="myAppGateway"

# Create a public IP address for the Application Gateway
az network public-ip create \
    --resource-group $sandbox \
    --name $PUBLIC_IP_NAME \
    --sku Standard \
    --allocation-method Static \
    --zone 1 2 3  # For zone redundancy

# Create Application Gateway
az network application-gateway create \
 --name myAppGateway \
 --location $region \
 --resource-group $sandbox \
 --vnet-name $vnet \
 --subnet AppGatewaySubnet \
 --capacity 2 \
 --sku Standard_v2 \
 --http-settings-cookie-based-affinity Disabled \
 --frontend-port 80 \
 --http-settings-port 80 \
 --http-settings-protocol Http \
 --public-ip-address $PUBLIC_IP_NAME \
 --priority 100

---

address1=$(az network nic show --name myNic1 --resource-group $sandbox | grep "\"privateIPAddress\":" | grep -oE '[^ ]+$' | tr -d '",')
address2=$(az network nic show --name myNic2 --resource-group $sandbox | grep "\"privateIPAddress\":" | grep -oE '[^ ]+$' | tr -d '",')
az network application-gateway create --name $APPGW_NAME \
  --location $region \
  --resource-group $sandbox \
  --capacity 2 \
  --sku Standard_v2 \
  --public-ip-address myAGPublicIPAddress \
  --vnet-name $vnet \
  --subnet AppGatewaySubnet \
  --servers "$address1" "$address2" \
  --priority 100



```


