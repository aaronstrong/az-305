# Design for High Availability

* Identify the availability requirements of Azure resources
* [Recommend a high availability solution for compute](#High-availability-for-compute)
* [Recommend a high availability solution for non-relational data storage](#Design-for-non-relational-data-storage)
* [Recommend a high availability solution for relational data storage](#Design-for-relational-data)

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

# [Design for non-relational data storage](https://learn.microsoft.com/en-us/training/modules/design-data-storage-solution-for-non-relational-data/)

The first step in your design for Azure Storage is to determine what types of data are required. Data can be classified in three ways: <i>structured, semi-structured, and unstructed</i>.

| Structured | Semi-Structured | Unstructured |
| --- | --- | --- |
| ![](https://learn.microsoft.com/en-us/training/wwl-azure/design-data-storage-solution-for-non-relational-data/media/structured-icon.png) | ![](https://learn.microsoft.com/en-us/training/wwl-azure/design-data-storage-solution-for-non-relational-data/media/semi-structured-icon.png) | ![](https://learn.microsoft.com/en-us/training/wwl-azure/design-data-storage-solution-for-non-relational-data/media/unstructured-icon.png) |
| Structured data is stored in a relational format that has a shared schema. Structure data is ofter contained in a database table with rows, columns, and keys. | Semi-structured data is less organized. The data fields don't fit neatly into tables, rows, and columns. Semi-structured data cotains tags, that clarify how the data is organized. The data is identified buy using a seralized langugage. | Unstructured data is the least organized. This data is a mix of information without a clear relationship. The format of unstructured data is referred to nonrelational. |
| Relational databases, such as medical records, phone books, and financial accounts. Application data for an e-commerce site. | * HTML files<br>* JSON files<br>* XML files<br>* CSS files | * Media files like photos, videos, audio<br>* Office files<br>* Text files, PDFs, TXT and RTF<br>* Log and audit files|

### Things to consider when choosing data storage

Nonrelational data is Azure can be stored in several different data objects.
![](https://learn.microsoft.com/en-us/training/wwl-azure/design-data-storage-solution-for-non-relational-data/media/storage-decision-tree.png)

* **Consider Azure Blob Storage**. Store vast amounts of unstructured data by using Azure Blob Storage. Blob stands for Binary Large Object. Blob Storage is often used for images and multimedia files.

* **Consider Azure Files**. Provide fully managed file shares in the cloud with Azure Files. This storage data is accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and the Azure Files REST API.

* **Consider Azure managed disks**. Support Azure virtual machines by using Azure managed disks. These disks are block-level storage volumes managed by Azure. Managed disks perform like physical disks in an on-premises server, but in a virtual environment.

* **Consider Azure Queue Storage**. Use Azure Queue Storage to store large numbers of messages. Queue Storage is commonly used to create a backlog of work to process asynchronously.

### Things to know about a storage account

| Storage Account | Supported Services | Recommended Usage |
| --- | --- | --- |
| [Standard genaral usage v2]() | Blob Storage (including Data Lake Storage), Queue Storage, Table Storage, and Azure Files | Standard storage account for most scenarios, including blobs, file shares, queues, tables, and disks (page blobs). |
| (Premium Block Storage)[] | Blob Storage (including Data Lake Storage) | Recommended for applications with high transaction rates. Use Premium block blobs if you work with smaller objects or require consistently low storage latency |
| [Premium File Shares]() | Azure Files | Recommended for enterprise or high-performance scale applications. SMB and NFS |
| [Premium page blobs]() | Page blobs only | Page blobs are ideal for storing index-based and sparse data structures, such as operating systems, data disks for virtual machines, and databases. |

### Things to consider with storage

* **Location** - Store data in a location that most frequently used.
* **Compliance Requirements** - Any guidelines for keeping data in a specific location? Does company have auditing requirements? 
* **Data Storage costs** - Geo-redundant vs local, Premium performance and the hot tier, lifecycle management and versioning
* **Replication**
* **Data Sensitivity**
* **Data Isolation**

### [Data Redundancy](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)

Azure Storage always stores multiple copies of your data to protect it from planned and unplanned events. When deciding which redundancy option is best for your scenario, consider the tradeoffs between lower costs and higher availability.

The services that comprise Azure Storage are managed through a common Azure resource called a storage account. The redundancy setting for a storage account is shared for all storage services exposed by that account. All storage resources deployed in the same storage account have the same redundancy setting. Consider isolating different types of resources in separate storage accounts if they have different redundancy requirements.

#### Redundancy in the Primary Location

Azure Storage offers two options for how your data is replicated in the primary region:

![](https://learn.microsoft.com/en-us/azure/storage/common/media/storage-redundancy/locally-redundant-storage.png)

* **Locally Redundant storage (LRS)** - Replicates data three times in a single data center. Does NOT replicate across Availability Zones.
  * 11 9's of availability
  * Lowest cost redundant option
  * Least durable option
  * Write requests to a storage account are done synchronously. The write operations returns successful only after the write is written to all 3 replicas.
    
![](https://learn.microsoft.com/en-us/azure/storage/common/media/storage-redundancy/zone-redundant-storage.png)

* **Zone Redundant Storage (ZRS)** - copies your data syncrhonously across three AZs in the primary region.
> [!NOTE]
> Microsoft recommends using ZRS in the primary region for Azure Data Lake Storage workloads.
 * 12 9's of availability
 * Data remains available for both read and write if a zone become unavailable.
 * Write requests to a storage account are done synchrounously. The write operation returns successfully only after the data is written to all replicas across the three availability zones.


##### Redundancy in secondary region

Azure Storage offers two options for copying your data to a secondary region:

![](https://learn.microsoft.com/en-us/azure/storage/common/media/storage-redundancy/geo-redundant-storage.png)

* **Geo-Redundant storage (GRS)**
 * 16 9's of availability
 * Write operation committed to the primary location. Data is copied synchronously three times to one or more availability zone using LRS. It the copies your data asynchrounsly to a single physical location in a secondary region.

![](https://learn.microsoft.com/en-us/azure/storage/common/media/storage-redundancy/geo-zone-redundant-storage.png)

* **Geo-zone redundant storage (GZRS)**
  * 16 9's of availability
  * Data in GZRS is copied across three different AZs in the primary location. It also replicates to a secondary geo-graphical location.

#### Azure Blob Storage

| Comparison | Hot Access Tier | Cool Access Tier | Cold Access Tier | Archive Access Tier | 
| --- | --- | --- | --- | --- |
| Availability | 99.9% |  99% | 99% | 99% |
| Availability (RA-GRS) | 99.99% | 99.9% |  99.9% |  99.9% |
| Latency (time to first byte) | milliseconds | milliseconds | milliseconds | hours |
| Minimum storage duration | NA | 30 days | 90 days | 180 days |




# [Design for relational data](https://learn.microsoft.com/en-us/training/modules/design-data-storage-solution-for-relational-data/)

| SQL Virtual Machines                                                                                        	| Managed Instances                                                                                   	|                                                                                                                                                    	| Databases                                                                      	|                                                                                                                                                    	|
|-------------------------------------------------------------------------------------------------------------	|-----------------------------------------------------------------------------------------------------	|----------------------------------------------------------------------------------------------------------------------------------------------------	|--------------------------------------------------------------------------------	|----------------------------------------------------------------------------------------------------------------------------------------------------	|
| Best for migrations and apps requiring OS-level Access                                                      	| Best for most lift and shift migrations to the cloud                                                	|                                                                                                                                                    	| Best for modern cloud applications                                             	|                                                                                                                                                    	|
| ![](https://joshthecoder.com/assets/2020-03-23-azure-sql-options-vm.png) | ![](https://www.azureperiodictable.com/azure/icons/Data/SQL%20Managed%20Instance.png)| ![](https://data-mozart.com/wp-content/uploads/2022/09/ded-1-1024x576.png) | ![](https://miro.medium.com/v2/resize:fit:640/format:webp/1*wxixRXAnrv9Ag0qwRhR6NA.png)	| ![](https://symbols.getvecta.com/stencil_28/77_elastic-database-pools.d182d9c83a.svg)                                                                                                                                              	|
| SQL Virtual Machine 	| Single instance  | Instance pool 	| Single database 	| Elastic Pool	|
| * SQL SErver and OS Server Acces<br>* Exapnsiave SQL and OS Version Support<br>* Automated manageability features 	| * SQL Server surface areas (vast majority)<br>* Native virtual network support<br>* Fully managed service 	| *Resource sharing between multiple instances to price optimize<br>* Simplified performance management for multiple databases<br>* Fully managed service 	| * Hypterscale storage up to 100TB<br>* Serverless compute<br>* Fully managed service 	| * Resource sharing between multiple databases to price optimize<br>* Simplified performance management for multiple databases<br>* Fully managed service 	|



# [High availability for Compute](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-high-availability)

### Availability and durability of managed disks

Managed disks are designed for 99.999% availability and provide at least 99.999999999% (11 9's) of durability. With managed disks your data is replicated three times. Managed disks have two redundancy models, locally redundant storage (LRS) disks, and zone-redundant storage (ZRS) disks.

| Locally Redundant Storage (LRS) Disks | Zone Redundant storage (ZRS) disks) |
| --- | --- |
| ![](https://learn.microsoft.com/en-us/azure/virtual-machines/media/disks-high-availability/disks-lrs-zrs-diagram.png) | ![](https://learn.microsoft.com/en-us/azure/virtual-machines/media/disks-high-availability/disks-lrs-zrs-diagram.png) |
| 11 9's of durability | 12 9's of durability|

### Recommendations for apps running on a single VM

Apps running on a single VM can't benefit from replication across multiple VM's, but the data on the disks is still replicated three times. Here are steps to further increase availability:

#### Use Ultra Disks, Premium SSD v2, or Premium SSD

Using these disks provide the greatest performance and highest single VM uptime SLA.

#### Use Zone-redundant storage disks

Zone-redundant storage (ZRS) disks synchronously replicate data across three availability zones, which are separated groups of data centers in a region. ZRS disks your data is accessible eeven in the event of zonal outage.

### Recommendations for applications running on multiple VMs

Quorum-based applications, clustered databases (SQL, MongoDB), enterprise-grade web apps, are examples of apps running on multiple VMs. Multiple VMs can designate a primary VM and multiple secondary Vms and replicate data across these VMs. This setup enables failover to a secondary VM if primary goes down.

#### Distribute VMs and disks across AZs

VMs distributed across multiple AZs may have higher network latency than VMs distributed in a single availability zone, which could be a concern for workloads that require ultra-low latency. 
