# Design identity, governance, and monitoring solutions (25–30%)

## Design a solution for logging and monitoring
* Design a log routing solution
* Recommend an appropriate level of logging
* Recommend monitoring tools for a solution

## Design authentication and authorization solutions
* Recommend a solution for securing resources with role-based access control
* Recommend an identity management solution
* Recommend a solution for securing identities

## [Design governance](#design-governance)
* Recommend an organizational and hierarchical structure for Azure resources
* Recommend a solution for enforcing and auditing compliance

## Design identities and access for applications
* Recommend solutions to allow applications to access Azure resources
* Recommend a solution that securely stores passwords and secrets
* Recommend a solution for integrating applications into Microsoft Azure Active Directory (Azure AD), part of Microsoft Entra
* Recommend a user consent solution for applications

---

# Design a solution for logging and monitoring
## [Design a log routing solution](https://learn.microsoft.com/en-us/training/modules/design-solution-to-log-monitor-azure-resources/)

[Video](https://www.youtube.com/watch?v=nEn-MWFrWB0)

### High-level architecture
![](https://learn.microsoft.com/en-us/training/wwl-azure/design-solution-to-log-monitor-azure-resources/media/azure-monitor-source.png)

Azure monitor can monitor these types of resources in Azure, other clouds, and on-premises:

* Applications
* VMs
* Guest Operatin Systems
* Containers
* Databases

### Custom Sources

* Take metrics and logs from other sources and make them visible through Azure Monitor.
  * Sources can range from on-premises resources and other cloud providers.
  * Goal is to have "one-pane-of-glass" to look for logs and metrics

### Azure Tenant

* Get billing and resource consumption

### Operating System

* Azure will know what level of OS and things, but will not know what's installed on the app. At this level, will need to get the information from the OS out of the VM and placed somewhere else.
* To help get this information out of the VM, there are agents that can be installed.

### Application Monitoring

* At the application level, we need to install agents hooked into `Application Insights` to pull logs and metrics specifically for that app, running on the VM.
  * The type of metrics can be seen are for example, how many clicks on a particular link, what public IP is the person coming from, etc.

### Data Stores

* By default, the data held in the metrics and logs is for 90 days.
* There are other ways to export the data, if you need to hold onto the data for longer than 90 days.+

### What is Log Analytics?

Log analytics is a service in that helps you collect and analyze data.

* Azure Monitor stores log data in the workspace
* Data in a workspace is organized into tables with properties you can query

A log analytics workspace provides:

* A geographic location for data storage.
* Data isolation by granting different users access rights following one of for recommended design strategies.
* Scope for configuration of settings like pricing tier, retention, and data capping

### Considerations for workspace access control

Workspace deployment models include centralized, decentralized (aka distributed) and hybrid.

* **Centralized**: A single workspace is created in the service provider's subscription. All the data is aggregated in a single workspace. As time goes by, more services are added and the workspace will grow. Use [retention periods](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/cost-logs#change-the-data-retention-period?WT.mc_id=AZ-MVP-5002880) and/or daily cap to help.
* **Decentralized**: A workspace is created in each tenant, or in multiple subscriptions.
  * normal usage is for data sovereignty, when you need data in EU and US.
* **Hybrid**: using a combination of both.



## Recommend an appropriate level of logging
## Recommend monitoring tools for a solution

### Azure Monitor

# Design authentication and authorization solutions
## Recommend a solution for securing resources with role-based access control
## Recommend an identity management solution
## Recommend a solution for securing identities

## [Design governance](https://www.youtube.com/watch?v=3MJBEwEbAMU&list=PLahhVEj9XNTejs0fgXT6HXaj_a_qsUoKa&index=1)

Governance within the Azure Well-Architected Framework isn't specifically tied to a single pillar but rather cuts across multiple pillars, particularly:
* **Operational Excellence**
* **Security**
* **Cost Optimization**
  
## Recommend an organizational and hierarchical structure for Azure resources

<img src="https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/media/azure-rbac-roles.png" width=500px>

### Identities

### Resource governance scopes

### Management Groups

### Subscriptions

### Resource Groups

<img src="https://learn.microsoft.com/en-us/training/wwl-azure/design-governance/media/resource-groups.png" width=500>

Decide how to organize the resource groups

#### Group by type

Group resources by type for on-demand services that aren't associated with an app. Have a resource group for SQL database and a separate resource group for the web services.

<img src="https://learn.microsoft.com/en-us/training/wwl-azure/design-governance/media/group-type.png" width=400>

#### Group by app

Group resources by app when all resources have the same polices and life cycle. This method can also be applied to test or prototype environments. Have separate resources groups. Each group can have all the resources for the specific application.

<img src="https://learn.microsoft.com/en-us/training/wwl-azure/design-governance/media/group-app.png" width=400>

* Consider group by department, group by location (region) or by billing
* Consider a combination of organizational strategies
* Consider resource life cycle
* Consider administration overhead
* Consider resource access control
* Consider compliance requirements

### Azure Policy

<img src = "https://learn.microsoft.com/en-us/training/wwl-azure/design-governance/media/azure-policy-choices.png" width=500>

### Tags

<img src="https://learn.microsoft.com/en-us/training/wwl-azure/design-governance/media/resource-tags.png" width=500>

### RBAC

## Recommend a solution for enforcing and auditing compliance

## Design identities and access for applications
## Recommend solutions to allow applications to access Azure resources
## Recommend a solution that securely stores passwords and secrets
## Recommend a solution for integrating applications into Microsoft Azure Active Directory (Azure AD), part of Microsoft Entra
## Recommend a user consent solution for applications