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