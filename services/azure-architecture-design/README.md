# AZ-305 Azure Architecture Design Prerequisites

## [Describe the core architectural components of Azure](https://learn.microsoft.com/en-us/training/modules/describe-core-architectural-components-of-azure/)

## [Describe Azure compute and networking services](https://learn.microsoft.com/en-us/training/modules/describe-azure-compute-networking-services/)

## [Describe Azure Storage services](https://learn.microsoft.com/en-us/training/modules/describe-azure-storage-services/)

## [Describe Azure identity, access, and security](https://learn.microsoft.com/en-us/training/modules/describe-azure-identity-access-security/)

## [Intro to Microsoft Cloud Adoption Framework](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/)

The [Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/overview) is a collection of docs, technical guidance, best practices, and tools to use to align business and technology strategies.

The Cloud Adoption Framework includes eight technologies:

* Strategy
* Plan
* Ready
* Migrate
* Innovate
* Govern
* Manage
* Secure

### Strategy

Use the [Strategy methodology](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/) to create a comprehensive plan that outlines your org's approach when you adopt and integrate cloud technologies. The Strategy methodology consists of 5 steps.

<img src="https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/media/strategy-overview.svg" width=700px>

#### Assess your strategy

What's the organization's current cloud maturity, identify gaps in your strategy, and take action to improve. There are tools to help assess like the Microsoft [Cloud Adoption Strategy Evaluator](https://learn.microsoft.com/en-us/assessments/8fefc6d5-97ac-42b3-8e97-d82701e55bab/).

<img src="https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/media/cloud-adoption-strategy-evaluator-assessment.png" width=600px>

#### Define your motivation

Understand the [motivations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/motivations) for going to the cloud. Cost savings, agility, scalability and innovation are motivators. Align your cloud adoption strategies with these motivations to achieve your business goals effectively.

Clearly define a [mission and objectives](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/mission-objectives) to provide direction and purpose during your cloud adoption. A missions is only valuable if you can take action on it, achieve objectives effectively and measure the results.

Define clear steps that you can take to achieve your mission. These steps become your objectives. Define specific key performance indicators (KPIs) that indicate the success of your objectives. Assign accountability for each key result, and review key results and the associated KPIs regularly.

#### Define your team

The [cloud strategy team](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/define-your-team) helps facilitate alignment between the business and adoption initiatives. Assign each member of your team to a valuable function that benefits your cloud adoption. Like a lead architect who can translate business objectives into technical architectures.

The cloud strategy should always seek input from other areas of yours business, like HR or Marketing. Form a small core strategy team, including IT, finance, and security, and involve other functions as you expand. Regularly review to maintain diverse representation and uncover opportunities and risks.

#### Prepare your organization

[Organizational alignment](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/prepare-organizational-alignment) helps ensure that leadership collectively supports the strategies that you plan to implement. Establish alignment with stakeholders early on, and expand [leadership buy-in](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/prepare-organizational-alignment#leadership-and-executive-buy-in), as you iterate on your strategy implementation.

To effectively take advantage  of cloud benefits, you need to assess [your organization's current capabilities across people](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/prepare-organizational-alignment#understand-your-operating-models-readiness-for-cloud), processes, technology, and partners. Understand the operating model, and identify any gaps in support, culture, roles, and skills.

Your organization might need to transition from a [project delivery model to a product delivery model](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/prepare-organizational-alignment#shift-from-a-project-model-to-product-model) to achieve broad scalability and speed. This change involves shifting from task-driven projects that hve defined scopes and timelines to a continuous, outcome-driven approach that has cross-functional teams that manage development, operations, and governance end-to-end.

#### Inform your strategy

After you complete the first four steps, you can factor in the following considerations to inform your cloud adoption strategy:

* **Financial efficiency**
* **AI**
* **Resiliency**
* **Security**
* **Sustainability**

### [Plan](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/3-plan)

#### Prepare your organization for the cloud

1. **Map your cloud adoption journey based on your organization type.**
2. **Choose the management model that fits your organizational structure**
3. **Plan cloud responsibilities across governance, security, and management functions.**
4. **Dcoument cloud responsibilities with clear ownership assignments.**

#### Prepare your people for the cloud

1. **Assess required skills for Azure adoption**
2. **Close the gap through structured training and expert support**
3. **Sustain cloud skills through contiuous learning programs**

#### Discover existing workload inventory

1. **Discover workload inventory through systematic documentation**
2. **Prioritize workloads based on business value and migration feasibility.**
3. **Gather business details for each workload to guide migration decisions**

#### Select Migration strategies

1. **Identify your business drivers to establish migration priorities.**
2. **Match business drivers to appropriate migration strategies**
3. **Apply strategy-specific selection criteria to validate decisions**
4. **Make modernization timing decisions based on resource availability**
5. **Execute stakeholder communication plan to ensure alignment**

#### Assess your workloads for migration

1. **Assess workload architecture to understand system structure and dependencies**
2. **Assess application code to identify capabilities and modernization opportunities.**
3. **Assess databases to understand data architecture and migration requirements**
4. **Create and maintain a risk register to track and mitigate migration risks**

#### Estimate total cost of ownership

1. **Plan your Azure architecture based on business and technical requirements**
2. **Estimate costs based on planned architecture and usage patterns**


## [Ready](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/4-ready)

### Define a Cloud Operating Model

A [cloud operating model](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/plan/prepare-organization-for-cloud#choose-how-to-manage-the-cloud) defines how you want to operate technology in the cloud. 


### Implement Landing Zones

[Landing Zones](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/) provide scalable and modular environments to help manage cloud environments. They provide a foundation for security, governance, and resource management. Use automation tools like Arm, Bicep and Terraform to deploy. After a landing zone is deployed, you must optimize your landing zone operations as you scale. Items to think about:

* Identify and eliminate expenses
* Enhance the performance of applications and services.
* Identify and mitigate security vulnerabilities.
* Ensure that the landing zone can scale efficiently to meet new demands
* Maintain compliance with industry standards
* Create reliable and resilient systems


### Develop Necessary Skills

Make sure your team has the appropriate skills to take on the cloud. You must align [your teams with cloud adoption functions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/suggested-skills#organizational-readiness-learning-paths) which might require that you establish a new organization structure or assign new roles.

### Avoid Antipatterns

Common [antipatterns](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/antipatterns/ready-antipatterns) during the readiness phase can hinder your cloud adoption efforts. Things like:

* Inadequete preperation
* Misconception about cloud services
* Lack of knowledge about cloud provider operations

## [Migrate](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/5-migrate)

### Plan Migration

1. **Assess migration readiness and skills** - Evaluate your team's Azure capabilities across infrastructure, security, and application domains.
2. **Choose your data migration skills** - Select ExpressRoute or high-bandwidth transfers, VPN gateways for encrypted connections, Azure Data Box for offline migrations. 
3. **Determine the migration sequence** - Map application dependencies using Azure Migrate, prioritize workloads by business criticality, and create migration schedules that avoid peak business periods.
4. **Choose the migration method for each workload** - Select near-zero downtime migration for mission-critical workloads or planned downtime migration for applications that accommodate maintenance windows.
5. **Define rollback plan** - Develop backup strategies with automated recovery scripts, establish rollback timeframes, and test recovery prcedures in non-prod environments.
6. **Engage stakeholders on migration plan** - Document migration approaches with business justification, present tested rollback procedures, validate schedules against business constratins and establish clear success criteria.

### Prepare workloads for the cloud

1. **Fix compatibility issues in Azure** - Deploy workload resources in test subscriptions, identify compatibility problems, replace hardware configuration with Azure Key vault, and eliminate local dependecies through Azure native services.
2. **Create reusable infrastructure** - Develop ARM templates or Bicep files for infrastructure components, create automation scripts for configuration management, and establish version control worklows.
3. **Create deployment documentation** - Document deployment procedures, record configuration requirements, create operational runbooks, and establish troubleshooting guides.

### Execute Migration

1. **Prepare stakeholders for migration** - Distribute migration schedules with responsibilities, confirm technical support availability, and conduct pre-migration readiness reviews.
2. **Implement a change freeze**
3. **Finalize the production environment** - Deploy infrastructure using tested templates, apply security policies, verify Azure services are operational, and confirm network connectivity.
4. **Execute Cutover** - or near-zero downtime: configure database replication, migrate static files, pause writes for synchronization, and redirect traffic. For planned downtime: stop operations, migrate data with validation, test functionality, and redirect traffic.
5. **Maintain fallback option** - Retain source infrastructure, maintain network connectivity, document fallback procedures, and establish monitoring for issues.
6. **Validate migration success** - Test performance against success criteria, conduct functional validation, verify data integrity, and obtain formal stakeholder acceptance.
7. **Support workload during stabilization** - Establish dedicated support teams, update configuration databases, maintain enhanced monitoring, and document lessons learned.

### Optimize workloads after migration

1. Fine-tune workload configuration - Apply Azure Advisor recommendations.
2. Validate critical configurations - Verify monitoring captures telemetry, confirm cost tracking aligns with baselines, test backup procedures, and validate security configurations.
3. Collect and act on user feedback - Gather feedback from surveys and interviews, document issues in a tracking log, assign ownership.
4. Schedule regular workload reviews
5. Optimize hybrid and multicloud dependencies
6. Share migration outcomes - Track costs with Azure Cost Management, measure performance improvements, document operational benefits, and present to stakeholders.


### Decommission source workloads

1. Obtain stakeholder approval before decommissioning
2. Reclaim and optimize software licenses
3. Preserve data for compliance and recovery needs
4. Update documentation and procedures

## [Modernize](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/6-modernize)

### Prepare organization for cloud modernization

1. Define modernization for your organization - Improve existing workloads through replatforming, refactoring, and rearchitecting, excluding net-new features or rewrites. 
2. Assess modernization readiness for skills - Evaluate your team's capabiltiies in cloud services knowledge, DevOps CI/CD maturity, modern architecture patterns and monitoring/automation tools.
3. Prioritize what workloads to modernize - Evaluate workloads based on business criticality and examining technical debt, outdated technology and develop a priority matrix.
4. Understand how to modernize - Use the azure well-architected framework to conduct reviews that identify gaps and generate modernization roadmaps across five pillars.

### Plan your cloud modernization

1. Choose your modernization strategy - Select from three primary approaches based on your specific needs: replatform for quick wins with minimal code changes (IaaS to PaaS), refractor to modify existing code for improved structure and cloud optimization while maintaining functionality, or rearchitect to redisgn application architecture using cloud native patterns like microservices and serverless. 
2. Plan modernizations in phases - Break complex workloads into logical phases to deliver incremental value and reduce risk by tackling manageable chunks. 
3. Plan for modernization governance
4. Define your deployment strategy
5. Plan to mitigate modernization risks
6. Secure stakeholder approval
   
### Execute modernizations in the cloud

1. Prepare stakeholders for modernization
2. Develop modernizations in nonproduction environment
3. Validate modernization changes with testing
4. Create reusable infrastructure
5. create deployment docs
6. Deploy modernization
7. Validate modernization success
8. Support workload during stabilization


### Optimize workloads after cloud modernization

1. Optimize configurations for the cloud
2. Validate operational readiness
3. Collect user feedback and measure outcomes
4. Establish continuous modernization practices

## [Cloud-native](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/7-cloud-native)


### Planning Cloud-native solutions on Azure

1. Define business objectives for cloud-native solutions
2. Define requirements for cloud-native solutions
3. Plan the cloud-native architectures
4. Plan the cloud-native deployment strategy
5. Define rollback plan for cloud-native solutions

### Build cloud-native solutions

1. Develop new cloud-native solutions
2. Create reusable infrastructure
3. Create deployment documentation

### Deploy cloud native solutions

1. Prepare stakeholders for cloud-native deployments
2. Execute the cloud-native deployments
3. Validate deployment success
4. Support workloads during stabilization

### Optimize the cloud-native solutions after deployment

1. Fine-tune service configurations
2. Validate operational readiness
3. Establish cost monitoring and optimize costs
4. Test backup and recovery procedures
5. Collect user feedback and measure outcomes
6. Continue to evolve and improve

## [Govern](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/8-govern)

Use the [govern methodology](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/govern/) to help maintain consistent control of your environment and address tangible risks. The Govern methodology provides a structure approach that you can use to establish and optimize governance in Azure.

![](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/media/govern.svg)

### Build a Team

Select a small, diverse team for quick deicison and diverse perspectives.

### Asses cloud risks

Before creating new policies, assess cloud risks to help define the new policy. To effectively assess risks in the cloud:

* Identify Risks and catalog them.
* Analyze risks and assign quantitative value to each risk.
* Determine the impact of a risk.
* Document risks
* Review risks

### Document Policies

Cloud governance policies establish the requirements, standards, and goals that your IT staff and automated systems must align with. Individual policy statements are guidelines that you can use to address specific risks that you identify during your risk analysis. Add policies to a centralized repository to inform everyone who needs to adhere to the policies.

### Enforce Policies

Use cloud governance tools to automate compliance on a small set of policies and then add more policies over time.

### Monitor cloud governance

Use cloud governance tools to automate compliance on a small set of policies and then add more policies over time. Use alerts to notify teams or individuals about deviations from your governance policies. Develop a remediation plan to quickly address violations, and prioritize high-risk problems. 

## [Manage](https://learn.microsoft.com/en-us/training/modules/cloud-adoption-framework/9-manage)

### Ready your Azure cloud operations

1. Identify management responsibilties. Cloud management spans compliance, security, resource management, deployment, monitoring, cost, reliability. Distinguish between central responsibilities for your entire Azure estate and workload-specific responsibilities for individual applications.
2. Establish operations teams. - Choose centralized management for smaller organizations and shared management for diverse workloads. Form dedicated teams for platform tasks and specialized workload teams, then assign owners for each responsibility area.
3. Document operational procedures.
4. Manage daily operations.
5. Improve continuously.


### Administer your Azure cloud estate

1. Define administrative scope
2. Control Changes - Formal change requests through ticket tools, assess risk levels. Prevent unauthorized changes using Change Analysis, Azure Policy, and Bicep deployment stacks.
3. Secure your environment - Use Entra ID, implement RBAC, and enforce secure configurations with IaC. Enable MFA and conditional access.
4. Maintain compliance - Map governance policies to operational processes using Azure Policy definitions defined with standards like ISO 27001 and NIST 800-53.
5. Govern data - Classify data using Microsoft Purview.
6. control costs. - Use MSFT Cost Management to monitor spending centrally per workload. Provide billing access to teams.
7. manage code and runtime - Look at the Well Architected Framework Operational Excellence checklist for code management, testing, and deployment.
8. Manage resources - Limit portal deployments to nonproduction, use IaC and implement CI/CD. Limit sprawl through governance.
9. Handle relocations - 
10. Maintain operation systems - Automate VM maintenance, implement updates through azure update management, and monitor using Change Tracking and Machine Configuration Services.

### Monitor your Azure cloud estate

1. Define monitoring scope. - 
2. Planning monitoring strategy.
3. Design monitoring solution. - Use azure monitor as the central hub with Azure Arc for multi-environments collection. Centralized data storage, automate through Azure Policy and optimize costs regularly.
4. Configure comprehensive monitoring - Monitor service health through Microsoft Entra and Defender, complaince via Azure Policy, costs through Cost Management, and application performance with Application Insights.
5. Set up alerting. - Define thresholds using Azure Monitor alerts with dynamic capabilities. Categorize severity, route notifications, and use email, SMS and ITSM integrations.
6. Create vizuals. Build dashboards using Azure Monitor workbooks for analysis and portal dashboards for overviews

### Protect your cloud estate

1. Ensure reliability. - Implement redundancy and recovery strategies based on workload priority. Use uptime SLOs and recovery objectives.
2. Protect data. - Configure replication and backup support RTO and RPO requirements. Use synchronous replication across zones and cross-region replication for critical workloads.
3. Build resilient applications. - Design self-healing applications that handle failures gracefully
4. Deploy redundant infrastructure - Use multiple availability zones and regions based on priority.
5. Plan business continuity - Create tested recovery procedures, detect failures within one minute, respond with appropriate procedures, and analyze incidents for improvement.
6. Operate Security - 
7. Handle security incidents


## [Intro to Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/en-us/training/modules/azure-well-architected-introduction/)

### Pillars of Azure Well-Architected Framework

Well-Architected framework is a set of guiding tenets to build high-quality solutions on Azure. There's no one-size fits all, but there are concepts that apply regardless of the architecture, technology or cloud provider. Azure Well-Architected Framework consists of five pillars.

<img src="https://learn.microsoft.com/en-us/training/modules/azure-well-architected-introduction/media/pillars.png" width = 400px>

1. Reliability
   * Anticipate failure at all levels.
   * Create a system that's resilient to failure and can self-heal. If an outage occurs, it should recover within the time that your stakeholders and customers expect.
   * This principle can help achieve business goals. A reliable workload must continue to function even when things go wrong.
   * It should be resilient enough to detect, manage, and quickly recover from failures.
2. Security
   * Security pillar helps make your workloads resilient to security concerns. Security incidents can hurt your reputation, operation, and finances.
   * A secure workload is resilient to attacks.
   * A key part is building with **Zero Trust** approach and following the [CIA triad](https://www.nccoe.nist.gov/publication/1800-26/VolA/index.html): confidentiality, integrity, and availability.
3. Cost Optimization
   * Cost optimization is about making sure the money that your organization spends is put to good use.
   * Cost optimization pillar can help you figure out how to allocate your budget, define spending patterns and priority areas, and get the most out of resources.
4. Operational Excellence
   * Operational Excellence pillar helps keep everything on track to ensure high-quality performance. A workload that operations smoothly has DevOps practices and procedures impelmented such as development, observability, and release management procedures.
5. Performance Efficiency
   * When there's an increase in load, your workload needs to manage it without affecting user experience. And when the load decreases, it's imported to conserve resources.
   * It's vital that you monitor and manage the amount of capacity that your system has so that your applications run smoothly and efficiently.

### Key Principles for creating solid architectural foundation