# Simple Azure Network




## Code
Establish your envrionment variables.

```bash
sandbox=1-7b0ecea8-playground-sandbox
region=westus
vnet=myVnet
username=azureadmin
export MY_PUBLIC_IP=$(curl -s https://api.ipify.org)
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
