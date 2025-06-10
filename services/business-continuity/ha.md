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

![](https://learn.microsoft.com/en-us/azure/reliability/media/regions-availability-zones.png)

Many Azure regions provide availability zones. AZs are independent sets of datacenters that contain isolated power, cooling, and network connections. AZs are physically located close enough togther to provide a low-latency network, but far enough apart to provide fault isolation from such things as storms and power outages.

Availability zones are typically separated by several kilometers, and usually are within 100 kilometers. This distance means they're close enough to have low-latency connections to other availability zones through a high-performance network. However, they're far enough apart to reduce the likelihood that more than one will be affected by local outages or weather.

Within each region, availability zones are connected through a high-performance network. Microsoft strives to achieve an inter-zone communication with [round-trip latency of less than approximately 2 milliseconds](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview?tabs=azure-cli#inter-zone-latency). Low latency allows for high-performance communication within a region, and for synchronous replication of data across multiple availability zones.

#### Datacenters

Datacenter locations are selected by using rigorous vulnerability risk assessment criteria. This process identifies all significant datacenter-specific risks and considers shared risks between availability zones.

#### Types of availability zone support

Two types of availability zone support: <i>zone-redundant</i> and <i>zonal</i>.

* **Zone-Redundant deployments**: Zone-redundant resources are automatically replicated across multiple availability zones to ensure data remains accessible even during a zone outage. Microsoft handles the distribution of requests, data replication, and failover between zones.
* **Zonal deployments**: Zonal resources are deployed to a single, self-selected availability zone to meet specific latency or performance needs, but they do not offer built-in resiliency. To enhance resiliency, you must design a multi-zone architecture yourself and handle failover in the event of a zone outage.

#### Availability zones and Azure Updates (Safe Deployment Practice (SPD) Framework

![](https://azure.microsoft.com/en-us/blog/wp-content/uploads/2020/02/bf679ad2-9c14-484f-a30c-6ac44391150e.webp)

[SDP](https://azure.microsoft.com/en-us/blog/advancing-safe-deployment-practices/) aims to ensure that all code and configuration changes go through a lifecycle of specific stages, where health metrics are monitored along the way to trigger automatic actions and alerts in case of any degradation detected.

Updates are coordinated and routed first to the canary regions > Pilot Phase > Early regions > Broad rollout to region pair 1 and then to pair 2.

A change only goes to one Availability Zone within a region


### Paired and Nonpaired regions

Some Azure regions are <i>paried</i> with another Azure region in order to form <i>region pairs</i>. Region pairs are selected by Microsoft and can't be chosen by the customer. These are some Azure services that use region pairs to support geo-replication and geo-redundancy. 

Many newer regions aren't paired, and instead use availability zones as their primary means of redundancy. Many Azure services support geo-redundancy whether the regions are paired or not, and you can design a highly resilient solution whether you use paired regions, nonpaired regions, or a combination of both.

#### [Paired Regions](https://learn.microsoft.com/en-us/azure/reliability/regions-paired#paired-regions)

Some Azure services use paired regions to build their multi-region geo-replication and geo-redundancy strategy. For example, Azure geo-redundant storage (GRS) can automatically replicate data to a paired region. [Here's the list of regions and their paired region](https://learn.microsoft.com/en-us/azure/reliability/regions-list)

**<u>Benefits include</u>**
* **Region recovery sequence**. In the event of a geography wide outage, the recovery of one region is prioritized out of every region pair. Components that are deployed across paired regions have one of the regions prioritized for recovery.
* **Sequential updatin**. Planned Azure system updates are staggered across regions pairs to minimize the impact of bugs or logical failures in the rare event of faulty updates, and to prevent downtime to solutions that have been designed to use paired regions together for resiliency.
* **Data residency**. To meet data residency requirements, almost all regions reside within the same geography as their pair.


### Using multiple Azure regions

It's common to use multiple Azure regions, paired and nonpaired, when you design a solution. By using multiple regions, you can increase workload resilience to many types of failures, and you have many options for disaster recovery. Also, some Azure services are available in specific regions, so by designing a multi-region solution you can take advantage of the global and distributed nature of the cloud.

* **Physical isoliation**: consider whether you should use regions that are geographically distant from each other. The greater the distance, the greater the resiliency n the case of disasters in one of the regions.
* **Latency**: When you select physically isolated regions, the latency of the network connections between those regions increases. Latency can affect how you design a multi-region solution, and it can restrict the types of geo-repolication and geo-redundancy you can use. To learn more about latency between regions, look at this [Azure Network roundtrip latency statistics](https://learn.microsoft.com/en-us/azure/networking/azure-network-latency?tabs=Americas%2CWestUS). Also, here's a great artical to [Test network latency between Azure VMs](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-test-latency?tabs=windows). To help reduce latency, here are a few key items to consider:
  * Use the latest version of Window sor LInux
  * Enable [Accelerated Networking]() for increased performance
  * Deploy VMs within an [Azure proximity placement group](https://learn.microsoft.com/en-us/azure/virtual-machines/co-location).
     * Proximity Placement Group - is a local grouping used to make sure that Azure compute resources are physically located close to each other. As Regions and Availability Zones, the datacenters for AZ's will grow. Using a PPG will ensure your workloads are in the same datacenter.
  * Create larger VMs for better performance.
* **Data Residency**: Ensure that any regions you select are within a data residency boundary that your organization requires.

# Design for non-relational data storage

The first step in your design for Azure Storage is to determine what types of data are required. Data can be classified in three ways: <i>structured, semi-structured, and unstructed</i>.

| Structured | Semi-Structured | Unstructured |
| --- | --- | --- |
| ![](https://learn.microsoft.com/en-us/training/wwl-azure/design-data-storage-solution-for-non-relational-data/media/structured-icon.png) | ![](https://learn.microsoft.com/en-us/training/wwl-azure/design-data-storage-solution-for-non-relational-data/media/semi-structured-icon.png) | ![](https://learn.microsoft.com/en-us/training/wwl-azure/design-data-storage-solution-for-non-relational-data/media/unstructured-icon.png) |
| Structured data is stored in a relational format that has a shared schema. Structure data is ofter contained in a database table with rows, columns, and keys. | Semi-structured data is less organized. The data fields don't fit neatly into tables, rows, and columns. Semi-structured data cotains tags, that clarify how the data is organized. The data is identified buy using a seralized langugage. | Unstructured data is the least organized. This data is a mix of information without a clear relationship. The format of unstructured data is referred to nonrelational. |
| Relational databases, such as medical records, phone books, and financial accounts. Application data for an e-commerce site. | * HTML files, * JSON files, * XML files | * Media files like photos, videos, audio, * Office files, * Text files, PDFs, TXT and RTF|

### Things to consider when choosing data storage

Nonrelational data is Azure can be stored in several different data objects.
![](https://learn.microsoft.com/en-us/training/wwl-azure/design-data-storage-solution-for-non-relational-data/media/storage-decision-tree.png)

* **Consider Azure Blob Storage**. Store vast amounts of unstructured data by using Azure Blob Storage. Blob stands for Binary Large Object. Blob Storage is often used for images and multimedia files.

* **Consider Azure Files**. Provide fully managed file shares in the cloud with Azure Files. This storage data is accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and the Azure Files REST API.

* **Consider Azure managed disks**. Support Azure virtual machines by using Azure managed disks. These disks are block-level storage volumes managed by Azure. Managed disks perform like physical disks in an on-premises server, but in a virtual environment.

* **Consider Azure Queue Storage**. Use Azure Queue Storage to store large numbers of messages. Queue Storage is commonly used to create a backlog of work to process asynchronously.
