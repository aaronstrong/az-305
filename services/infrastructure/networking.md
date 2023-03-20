# Networking

## Recap Virtual Networking

### [Routing](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview)

Azure automatically creates a route table for each subnet within an Azure virtual network and adds system default routes to the table.

**System Routes**

* Routes that are created automatically
* System routes are assigned to each subnet in a VNet.
* Can't create nor delete system routes, BUT can override some with custom routes.


**Default Routes**

Each route contains an address prefix and next hop type. When traffic leaving a subnet is sent to an IP address within the address prefix of a route, the route that contains the prefix is the route Azure uses.

Whenever a virtual network is created, Azure automatically creates the following default system routes for each subnet within the virtual network:

| Source | Address prefixes | Next hop type |
| --- | --- | --- |
| Default | Unique to the virtual network | Virtual Network |
| Default | 0.0.0.0/0 | Internet |
| Default | 10.0.0.0/8 | None |
| Default | 172.16.0.0/12 | None |
| Default | 192.168.0.0/16 | None |
| Default | 100.64.0.0/10 | None |

* **Virtual Network**: Routes traffic between address ranges within the addres space of a Virtual network.
* **Internet:** Routes traffic specified by the address prefix to the internet. If the destination address is for one of Azure's services, Azure routes the traffic directly to the service over Azure's backbone network, rather than routing the traffic to the Internet.
* **None** : Traffice routed to **None** next hop type is dropped, rather than routed outside the subnet.


**Custom Routes**:

You create custom routes by either creating user-defined routes (static), or by exchanging border gateway protocol (BGP) routes between your on-premises network gateway and an Azure virtual network gateway.

*User-Defined*

* Used to override Azure's default system routes.
* A route table can be associated to multiple subnets, BUT a subnet can have zero to 1 associated route table.
* When a route table is associated with a subnet, the table's routes are combined with the subnet's default routes.
* If there are conflicting route assignments, user-defined routes will override the default routes.
* A max of 200 route tables with a max of 400 routes per table
* You can't specify VNet Peering or VirtualNetworkServiceEndpoint as the next hop type in UDR. Routes with VNet Peering or VirtualNetworkServiceEndpoint next hop types are only created by Azure; when you configure virtual network peering or service endpoint.

*Border Gateway Protocol*

An on-premises network gateway can exchange routes with an Azure virtual network gateway using the border gateway protocol (BGP), dependent on the type you selected when you created the gateway. If the type you selected were:
* **ExporessRoute**:  You must use BGP to advertise on-premises routes to the Microsoft Edge router. You can't create user-defined routes to force traffic to the ExpressRoute virtual network gateway if you deploy a virtual network gateway deployed as type: ExpressRoute. You can use user-defined routes for forcing traffic from the Express Route to, for example, a Network Virtual Appliance.
* **VPN**: You can, optionally use BGP.

ER and VPN Gateway route propagation can be disabled on a subnet using a property on a route table. When route propagation is disabled, routes aren't added to the route table of all subnets with Virtual network gateway route propagation disabled (both static routes and BGP routes).

**How Azure Selects a Route**

When outbound traffic is sent from a subnet, Azure selects a route based on the destination IP address, using the longest prefix match algorithm. Example: If the table has 2 routes: 10.0.0.0/24 and 10.0.0.0/16. Azure routes traffic destined for 10.0.0.5, to the next hop type to 10.0.0./24 because it's longer than 10.0.0.0/16, even though 10.0.0.5 is whtin both addresses prefixes.

If multiple routes contain the same address prefix, Azure select the route type based on the following priority:
1. User-Defined Route
2. BGP Route
3. System Route

For example, a route table contains the following routes:
| Source | Address Prefix | Next hop type |
| --- | --- | --- |
| Default | 0.0.0.0/0 | Internet |
| User | 0.0.0.0/0 | Virtual Network Gateway |

* Azure selects the route with the **User** source, because it's higher priority than system default routes.

**0.0.0.0/0 address prefix**

A route with the 0.0.0.0/0 address prefix instructs Azure how to route traffic destined for an IP address that isn't within the address prefix of any other route in a subnet's route table. When a subnet is created, Azure creates a default route to the 0.0.0.0/0 address prefix, with the Internet next hop type, Azure routes all non-local destined traffic to the internet. Exception is that traffic to the public IP addresses of Azure services reamins on the Azure backbone network, and isn't routed to the Internet. A custom route will override this route.

When you override 0.0.0.0/0 the following changes occur to Azure's default routing:

* Azure sends all traffic to the next hop type specified in the route, including traffic destined for public IP addresses of Azure services. When you create a user-defined route (UDR) or BGP route all traffic, including traffic sent to public IP addresses of Azure services you haven't enabled service endpoints for, is sent to the next hop type specified in the route. If you've enabled a service endpoint for a service, traffic to the service isn't routed to the next hop type in a route with the 0.0.0.0/0 address prefix, because when the endpoint for the service is enabled Azure creates a route to the service.
* You're no longer able to directly access resources in the subnet from the Internet. You can indirectly access resources in the subnet from the Internet, if inbound traffic passes through the device specified by the next hop type for a route with the 0.0.0.0/0 address prefix before reaching the resource in the virtual network.

If your virtual network is connected to an Azure VPN gateway, don't associate a route table to the gateway subnet that includes a route with a destination of 0.0.0.0/0. Doing so can prevent the gateway from functioning properly.

See [DMZ between Azure and your on-premises](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/dmz/secure-vnet-hybrid?toc=%2fazure%2fvirtual-network%2ftoc.json) datacenter for implementation details when using virtual network gateways between the Internet and Azure.


### [NSG](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)

A network security group (NSG) in Azure is the way to activate a rule or access control list (ACL), which will allow or deny network traffic to your virtual machine instances in a virtual network. NSGs can be associated with subnets or individual virtual machine instances within that subnet.

* Standard Public IP Address block access by default.
* Basic Public IPs do not.
* Can assign NSG to subnet or NIC. Best to apply to Subnet.
* NSG rules are stateful. Automaticallya llow reply traffic.
* VMs provide outbound internet traffic access even without a public IP.


### [Virtual Network NAT](https://learn.microsoft.com/en-us/azure/virtual-network/nat-gateway/nat-overview)

![](https://learn.microsoft.com/en-us/azure/virtual-network/nat-gateway/media/nat-overview/flow-map.png)

Virtual Network NAT is a fully managed and highly resilient Network Address Translation (NAT) service. Virtual Network NAT simplifies outbound Internet connectivity for virtual networks. When configured on a subnet, all outbound connectivity uses the Virtual Network NAT's static public IP addresses.

With a NAT gateway, individual VMs or other compute resources, don't need public IP addresses and can remain private. Resources without a public IP address can still reach external sources outside the virtual network with NAT gateway's static public IP addresses or prefixes. You can associate a public IP prefix to ensure that a contiguous set of IPs will be used for outbound. Destination firewall rules can be configured based on this predictable IP list.

* NAT gateway is the recommended method for outbound connectivity. Doesn't have same limits as SNAT.
* Return traffic from the internet is only allowed in response to an active flow.
* NAT gateway takes precedence over other outbound scenarios (including Load balancer and instance-level public ip addr.) and replsace the default internet destination of a subnet.
* The order of operations for outbound connectivity follows this order of precedence: Virtual appliance UDR / ExpressRoute >> NAT gateway >> Instance-level public IP addresses on virtual machines >> Load balancer outbound rules >> default system
* TCP an UDP are supported. ICMP isn't.
* One NAT Gateway can be associated with one or more subnets within a Vnet.

## VNet Peering

![](https://learn.microsoft.com/en-us/azure/virtual-network/media/virtual-networks-peering-overview/local-or-remote-gateway-in-peered-virual-network.png)

Virtual network peering enables you to seamlessly connect two or more Virtual Networks in Azure. The virtual networks appear as one for connectivity purposes. The traffic between virtual machines in peered virtual networks uses the Microsoft backbone infrastructure.

Azure supports the following types of peering:
* **Virtual network peering**: Connecting virtual networks within the same Azure region.
* **Global virtual network peering**: Connecting virtual networks across Azure regions.

Network traffic between peered virtual networks is private. Traffic between the virtual networks is kept on the Microsoft backbone network. No public Internet, gateways, or encryption is required in the communication between the virtual networks.

The network latency between virtual machines in peered virtual networks in the same region is the same as the latency within a single virtual network. The network throughput is based on the bandwidth that's allowed for the virtual machine, proportionate to its size. There isn't any extra restriction on bandwidth within the peering.

The traffic between virtual machines in peered virtual networks is routed directly through the Microsoft backbone infrastructure, not through a gateway or over the public Internet.

:heavy_check_mark: Fast, low-latency private IP connectivity with no bandwidth limits
:heavy_check_mark: supports cross-subscrption and cross-region connectivity (global peering)
:heavy_check_mark: Peer up to 500 VNeet peers
:heavy_check_mark: Routed through Azure backbone
:heavy_check_mark: Peer across Azure AD tenants and sbuscriptions
:x: IP address spacing cannot overlap
:x: Does not support transitive routing

## [Service Endpoints](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview)

![](https://learn.microsoft.com/en-us/azure/virtual-network/media/virtual-network-service-endpoints-overview/vnet_service_endpoints_overview.png)

Virtual Network (VNet) service endpoint provides secure and direct connectivity to Azure services over an optimized route over the Azure backbone network. Endpoints allow you to secure your critical Azure service resources to only your virtual networks. Service Endpoints enables private IP addresses in the VNet to reach the endpoint of an Azure service without needing a public IP address on the VNet.

This functionality is not available for all services. But there's a few of them and here's the [full GA list](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview).

* Azure Storage (Microsoft.Storage)
* Azure SQL Database (Microsoft.Sql)
* Azure Cosmos DB (Microsoft.AzureCosmosDB)
* Azure Key Vault (Microsoft.KeyVault)
* Azure App Service (Microsoft.Web)

### Benefits

* **Improve Security**: VNet private address spaces can overlap. Service endpoints enable securing of Azure service resources to your virtual network by extending VNet identity to the service. Once you enable service endpoints in your virtual network, you can add a virtual network rule to secure the Azure service resources to your virtual network. The rule addition provides improved security by fully removing public internet access to resources and allowing traffic only from your virtual network.

* **Optimal routing for Azure service traffic from your virtual network:** Today, traffic destined to a an Azure service are routed over the internet. Endpoints always take service traffic directly from your network to the service on the azure backbone.

:heavy_check_mark: Configured per resource provider, per subnet, for secure connectivity
:heavy_check_mark: Optimal routes are added so that all resources within a subnet use the Azure backbone.
:heavy_check_mark: Resource firewall rules can be configured to allow/deny traffic.
:x: The service keeps the public IP, but a new route is added with higher priority

## Private Link

![](https://www.fugue.co/hs-fs/hubfs/azure-private-link-diagram-2%5B1%5D.png?width=624&height=255&name=azure-private-link-diagram-2%5B1%5D.png)

Azure Private Link is a secure and scalable way for Azure customers to consume Azure Services like Azure Storage or SQL, Microsoft Partner Services or their own services privately from their Azure Virtual Network (VNet). There is no need for gateways, network address translation (NAT) devices, or public IP addresses to communicate with the service.

Azure Private Link brings Azure services inside the customer’s private VNet. The service resources can be accessed using the private IP address just like any other resource in the VNet. This significantly simplifies the network configuration by keeping access rules private.

The private endpoint is a network interface that provides private IP address to a service that would normally only be accessible to a VNet with a public ip address.

> **Note** : you can also limit what PaaS offering vs allowing the entire service catalog.

![](https://azurecomcdn.azureedge.net/mediahandler/acomblog/media/Default/blog/6c3f6938-64c1-4b33-8827-632d368275e0.png)

You can also use Private Link to publish your own SaaS offering. In the diagram above, create a private endpoint that points to a load balancer in a different subscritpion or tenant.

---

# Hybrid Networking

## VPN

![](https://learn.microsoft.com/en-us/azure/vpn-gateway/media/point-to-site-about/p2s.png)
By default, traffic cannot be routed between two virtual networks. However, it's possible to connect virtual networks, either within a single region or across two regions, so that traffic can be routed between them.

* **Virtual Network Peering** - Virtual network peering connects two Azure virtual networks. Once peered, the virtual networks appear as one for connectivity purposes. Traffic between virtual machines in the peered virtual networks is routed through the Microsoft backbone infrastructure, through private IP addresses only. No public internet is involved.

* **VPN Gateway** - A VPN gateway is a specific type of virtual network gateway that is used to send traffic between an Azure virtual network and an on-premises location over the public internet. You can also use a VPN gateway to send traffic between Azure virtual networks. Each virtual network can have at most one VPN gateway. Should enable Azure DDoS Protection on any perimeter virtual network.

## Gateway Transit

Virtual network peering and VPN Gateways can also coexist via gateway transit.

Gateway transit enables you to use a peered virtual network's gateway for connecting to on-premises, instead of creating a new gateway for connectivity. Gateway transit allows you to share an ExpressRoute or VPN gateway with all peered virtual networks and lets you manage the connectivity in one place. 

## Comparison of Peering and VPN Gateway

| Item | Peering | VPN Gateway |
| --- | --- | --- |
| Limits | Up to 500 VNet peers per virtual network | One VPN Gateway per VNet. Max # of tunnels depends on gateway SKU. |
| Pricing | Ingress/Egress | Hourly + Egress |
| Encryption | Software-level encryption is recommended | Custom IPsec/IKE policy can be applied to new or existing connections. |
| Bandwidth limits | No BW limits | Varies based on SKU. From 100 Mbps to 1.25 Gbps |
| Private | Yes. Routed through Azure backbone | Public IP involved |
| Transitive | Peering connections are non-transitive. If VNet A is peereed to VNet B, and VNet B is peered to VNet C, VNet A and VNet C cannot communicate. Transitive networking can be achieved through NVAs or gateways in hub virtual network. [See hub-spoke example](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke) | If virtual networks are connected via VPN gateways and BGP is enabled in the Vnet, transitivity works. |
| Initial setup time | Fast | ~30 minutes |
| Typical Scenarios | Data replication, database failover. | Encryption-specific scenarios that are not latency sensitive and do not need high throughput. |
| Cross-region support? | Yes, via Global VNet peering | Yes |
| Cross-Azure Active Directory tenant support? | Yes | Yes |
| Cross subscription support | Yes | Yes |

## [VPN Gateways](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways)

![](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/dmz/images/dmz-private.png)

### About

A VPN gateway is a type of virtual network gateway. A virtual network gateway is composed of two or more Azure-managed VMs that are automatically configured and deployed to a specific subnet you create called the *GatewaySubnet*. The gateway VMs contain routing tables and run specific gateway services.

When you create a VPN gateway, gateway VMs are deployed to the gateway subnet and configured with the settings that you specified. This process can take 45 minutes or more to complete, depending on the gateway SKU that you selected.

## ExpressRoute

![](https://learn.microsoft.com/en-us/azure/expressroute/media/expressroute-introduction/expressroute-connection-overview.png)

ExpressRoute is an Azure service that lets you create private connections between Microsoft datacenters and infrastructure that's on your premises or in a colocation facility. ExpressRoute connections don't go over the public Internet, and offer higher security, reliability, and speeds with lower latencies than typical connections over the Internet.

:heavy_check_mark: Layer 3 connectivity between on-prem and Azure.
:heavy_check_mark: Dynamic routing between your network and Azure via BGP
:heavy_check_mark: Built-in redundancy in every peering location for higher reliability
:heavy_check_mark: Supports up to 10 Gbps, 100 Gbps with ExpressRoute Direct
:x: Does not leverage IPsec by default. Must be enabled.

---

## Virtual WAN

![](https://camo.githubusercontent.com/24344a6ae9c1c6d4bc072fc537a22a5372b5461887756013ae5922ab35bb34ec/68747470733a2f2f6c6561726e2e6d6963726f736f66742e636f6d2f656e2d75732f617a7572652f7669727475616c2d77616e2f6d656469612f7669727475616c2d77616e2d61626f75742f7669727475616c2d77616e2d6469616772616d2e706e67)

Virtual WAN provides an integrated approach to connectivity – bringing many features to a single area within Azure, and providing additional levels of automation and control. Use cases like branch and remote user connectivity are obvious, but also there are options that Virtual WAN enables – creating new Resource Deployments rapidly in new Regions for example, by virtue of the easily expanded connectivity. Technologies like Citrix and other third party solutions can benefit from Virtual WAN too. In many cases it is simply about getting a connectivity baseline into your Cloud estate – and in the case of Virtual WAN, a solution that offers easily expanded and branch site connectivity with ease.

## Virtual WAN Types

| VWAN Type | Hub Type | Available configs |
| --- | --- | --- |
| Basic | Basic | Site-to-site VPN only<br>Transitive peering **NOT** supported.<br>Upgrade to Standard supported |
| Standard | Standard | Express Route<br>Use VPN (P2S)<br>VPN(site-to-site)<br>Inter-hub and VNet-to-VNet transiting through te virtual hu<br>Azure Firewall<br>NVA in a virtual WAN |
>**Note**: You can upgrade from Basic to Standard, but can't revert.

---

# VNet-Native services

