# Design for High Availability

* Identify the availability requirements of Azure resources
* Recommend a high availability solution for compute
* Recommend a high availability solution for non-relational data storage
* Recommend a high availability solution for relational data storage

---
# [What is reliability?](https://learn.microsoft.com/en-us/azure/reliability/overview)

Reliability is a key concept in cloud computing. In Azure, reliability is achieved through a combination of factors, including the design of the platform itself, its services, the architecture of your applications, and the implementation of best practices. A key approach to achieve reliability in a workload is resiliency, which is a workload's ability to withstand and recover from faults and outages.

## Azure reliability guides by service

Each Azure service has its own unique reliability characteristics. Azure provides a set of service-specific reliability guides that can help you design and implement a reliable workload, and the guidance can help you understand how to best use the service to meet your business needs. For more information and a list of reliability service guides, see [Reliability guides by service](https://learn.microsoft.com/en-us/azure/reliability/overview-reliability-guidance).

> [! TIP]
> Reliability also incorporates other elements of your solution design too, including how you deploy changes safely, how you manage your performance to avoid downtime due to high load, and how you test and validate each part of your solution. Look at the [Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/).

## Azure Regions

Azure providers over 60 regions globally. Regions are located across many different geographies. Each geography represents a data residency boundary, for example the US and the EU, and my contain one or more regions. Each region is set of physical facilities that include datacenters and networking infrastructure.

Regions provide certain types of resiliency options. Many regions provide availability zones, and shome have a paired region while other regions are nonparied. When you choose a region for your services, it's important to pay attention to the resiliency options that are available in that region.

An Azure region consists of one or more datacenters, connected by a high-capacity, fault-tolerant, low-latency network connection. Azure datacenters are typically located within a large metropolitan area.

![](https://learn.microsoft.com/en-us/azure/reliability/media/cross-region-replication.png)

### List of Regions

For a list of Azure regions, see [List of Azure Regions](https://azure.microsoft.com/en-us/explore/global-infrastructure/geographies#new-regions). If you want more details on regions, including data residency and regulatory compliance see the [Microsoft Datacenter Map](https://datacenters.microsoft.com/globe/explore/).

### Availability Zones

Many Azure regions provide availability zones. AZs are independent sets of datacenters taht contain isolated power, cooling, and network connections. AZs are physically located close enough togther to provide a low-latency network, but far enough apart to provide fault isolation from such things as storms and power outages.

### Paired and Nonpaired regions

Some Azure regions are <i>paried</i> with another Azure region in order to form <i>region pairs</i>. Region pairs are selected by Microsoft and can't be chosen by the customer. These are some Azure services that use region pairs to support geo-replication and geo-redundancy. 

Many newer regions aren't paired, and instead use availability zones as their primary means of redundancy. Many Azure services support geo-redundancy whether the regions are paired or not, and you can design a highly resilient solution whether you use paired regions, nonpaired regions, or a combination of both.

### Using multiple Azure regions

It's common to use multiple Azure regions, paired and nonpaired, when you design a solution. By using multiple regions, you can increase workload resilience to many types of failures, and you have many options for disaster recovery. Also, some Azure services are available in specific regions, so by designing a multi-region solution you can take advantage of the global and distributed nature of the cloud.

* **PHysical isoliation**: consider whether you should use regions that are geographically distant from each other. The greater the distance, the greater the resiliency n the case of disasters in one of the regions.
* **Latency**: When you select physically isolated regions, the latency of the network connections between those regions increases. Latency can affect how you design a multi-region solution, and it can restrict the types of geo-repolication and geo-redundancy you can use. To learn more about latency between regions, look at this [Azure Network roundtrip latency statistics](https://learn.microsoft.com/en-us/azure/networking/azure-network-latency?tabs=Americas%2CWestUS). Also, here's a great artical to [Test network latency between Azure VMs](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-test-latency?tabs=windows). The article goes over using
