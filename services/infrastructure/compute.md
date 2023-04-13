# Compute

### Sharing Responsibility

![](https://learn.microsoft.com/en-us/azure/security/fundamentals/media/shared-responsibility/shared-responsibility.svg)

* **IaaS** | Infrastructure > **OS** > **Runtime** > **Apps** > **Functions**
* **PaaS** | Infrastructure > OS > Runtime > **Apps** > **Functions**
* **FaaS** | Infrastructure > OS > Runtime > Apps > **Functions**

## Virtual Machines

Why build solutions ontop of VMs:
1. A VM is versitile. You have full control over the VM type, OS, runtimes, etc. Great for new solutions or lift and shift.
1. You have full control over the VM, from size, OS type.
1. dYou are in charge of the maintenance of the VM. OS patching, application patching, security.

[Makeup of a Virtual Machine](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/n-tier/linux-vm)
![](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/n-tier/images/single-vm-diagram.png)
* Name of the instance
* Region/Zone to deploy to which will impact the underlying hardware
* NIC:
    * Region/Zone must match the VM
    * NIC resource: provides connectivity to the vNET.
* Operating System
    * Image supports OSes from marketplace and custom
    * Disks requires at least an OS.

[VM Families](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/series/)

| Series | Purpose | Workloads | 
| :-: | --- | --- |
| A-Series | Entry-level VMs for dev/test. Non-hyperthreaded. | Dev & test servers, low traffic web servers, code repos. Not for production. |
| Bs-Series | Economical burstable VMs. | Dev & Test servers, low-traffic web servers, small DBs, build servers. |
| D-Series | General purpose compute. | Enterprise-grade apps, e-commerce, web front ends, desktop VMs, gaming servers, media servers |
| E-Series | Optimized for in-memory apps | SAP HANA |
| F-Series | Compute optimized | Batch processing, web servers, analytics, gaming |
| G-Series | Memory and storage optimized | Large SQL, NoSQL database, data warehousing solutions |
| H-Series | High performance compute | Fluid dynamics, finite elemente analysis, seismic processing, weather modeling |
| Ls-Series | Storage optimized | NoSQL database like Cassandra, MongoDB, Cloudera |
| M-series | Memory Optimized | SAP HANA |
| Mv2-Series | Largest memory optimized | SAP HANA |
| N-Series | GPU enabled | deep learing, graphics rendering |

### [VM Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-design-overview)

![](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/n-tier/images/n-tier-cassandra.png)

* VM based. So scale sets have the pros & cons of VMs.
* Provides high availability
* Provides auto-scaling. To scale in & out based on metrics. For example CPU %.
* [Example Scale Set](https://techcommunity.microsoft.com/t5/azure-compute-blog/automatic-scaling-with-azure-virtual-machine-scale-sets-flexible/ba-p/2730065)


## Container Solutions




## Application Hosting


## Large-Scale Compute