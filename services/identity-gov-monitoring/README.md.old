# Identity, Governance and Monitoring README

![](../docs/authN-authZ.png)

Azure Active Directory is at the heart of everything when it comes to Authentication (AuthN) and Authorization(AuthZ).

---

## Azure AD Refresh!

### Azure AD Versions

| Version | Features |
| --- | --- |
| Free | MFA, SSO, Basic Security and Usage reports, User Management |
| Office 365 Apps | Company Branding, SLA, Two-sync between On-premises and Cloud |
| Premium 1 | Hybrid architecture, Advanced Group Access, Conditional Access |
| Premium 2 | Identity protection, Identity Governance |

### Azure AD Tenant

Azure Active Directory (Azure AD) is a cloud-based identity and access management service. Azure AD enables your employees access external resources, such as Microsoft 365, the Azure portal, and thousands of other SaaS applications.

All Azure subscriptions have a trust relationship with an Azure Active Directory (Azure AD) instance. Subscriptions rely on their trusted Azure AD to authenticate and authorize security principals and devices.

When a user signs up for a Microsoft cloud service, a new Azure AD tenant is created and the user is made a member of the Global Administrator role. However, when an owner of a subscription joins their subscription to an existing tenant, the owner isn't assigned to the Global Administrator role.

![](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/media/active-directory-how-subscriptions-associated-directory/trust-relationship-azure-ad.png)

> **Important**: When a subscription is associated with a different directory, users who have roles assigned using Azure role-based access control lose their access. Classic subscription administrators, including Service Administrator and Co-Administrators, also lose access. Moving your Azure Kubernetes Service (AKS) cluster to a different subscription, or moving the cluster-owning subscription to a new tenant, causes the cluster to lose functionality due to lost role assignments and service principal's rights.

Click [here](https://learn.microsoft.com/en-us/training/modules/explore-basic-services-identity-types/3-describe-available-editions) to see the differnet licenses for Azure AD.

### Single Sign-On (SSO)

The main protocols supported in Azure Include:

1. **OpenID connect and OAuth:** OpenID Connect is an identity layer built on top of OAuth 2.0. It allows for authentication and authorization of users in a secure and standardized manner.
1. SAML (Security Assertion Markup Language): SAML is an XML-based protocol used for exchanging authentication and authorization data between an identity provider and a service provider. It is commonly used for federated authentication scenarios.
1. **Password-based authentication**: This refers to the traditional username and password authentication method where users provide their credentials directly to authenticate.
1. **Linked Authentication**: Azure provides the ability to link multiple accounts from different identity providers toa  single user identity. THis allows users to authenticate using any of their linked accounts.
1. **Integrated Windows Authentication (IWA)**: IWA lets users access applications using their Windows domain credentials, utilizing their **current Windows session** for authentication.
1. **Header-based authentication**: In this method, the application accepts an authentication token in the form of a header in each request. The token is validated by the application to authenticate the user.

### Identities

Azure AD manages different types of identities: **users, service principals, managed identities, and devices**.

<u>**User**</u>

A user identity is a representation of something that's managed by Azure AD. Employees and guests are represented as users in Azure AD. If you have several users with the same access needs, you can create a group. You use groups to give access permissions to all members of the group, instead of having to assign access rights individually.

<u>**Service Principals**</u>

A service principal is, essentially, an identity for an application. For an application to delegate its identity and access functions to Azure AD, the application must first be registered with Azure AD to enable its integration. Once registered, a service principal is created in each Azure AD tenant where the application is used. The service principal enables core features such as authentication and authorization of the application to resources that are secured by the Azure AD tenant.

[<u>**Managed Identities**</u>](https://learn.microsoft.com/en-us/training/modules/explore-basic-services-identity-types/4-describe-identity-types)

Managed identities are a type of service principal that are automatically managed in Azure AD and eliminate the need for developers to manage credentials. Managed identities provide an identity for applications to use when connecting to Azure resources that support Azure AD authentication and can be used without any extra cost.

There are 2 types of managed identities: system-assigned and user-assigned.

1. **Syste-Assigned** - When you enable a system-assigned managed identity, an identity is created in Azure AD that's tied to the lifecycle of that service instance. When the resource is deleted, Azure automatically deletes the identity for you
1. **User-Assigned** - You may also create a managed identity as a standalone Azure resource. Once you create a user-assigned managed identity you can assign it to one or more instances of an Azure service.

| Feature | System-Assigned | User-Assigned |
| --- | --- | --- |
| **Creation** | Created as part of an Azure resource | Created as a standalone Azure resource |
| **Lifecycle** | Shared lifecycle with the Azure resource | Independent lifecycle |
| **Deletion** | When resource deletes so does the identity | Must be explicitly deleted |
| **Sharing across Azure resources** | Cannot be shared.<br>Associated with a single Azure resource | Can be shared.<br>Can be associated with more than one Azure resource. |

<u>**Device**</u> - 

A device identity gives administrators information they can use when making access or configuration decisions. Device identities can be set up in different ways in Azure AD.
* **Azure AD registered devices** - The goal of Azure AD registered devices is to provide users with support for bring your own device (BYOD) or mobile device scenarios. In these scenarios, a user can access your organization’s resources using a personal device. 
* **Azure AD Joined** - An Azure AD joined device is a device joined to Azure AD through an organizational account, which is then used to sign in to the device. Azure AD joined devices are generally owned by the organization.
* **Hybrid Azure AD Joined device** - These devices are joined to your on-premises Active Directory and Azure AD requiring organizational account to sign in to the device

### [Groups](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/concept-learn-about-groups)

With Azure AD groups, you can grant access and permissions to a group of users instead of for each individual user.

There are two group types and three group membership types.

**Group Types**
* **Security** - Used to manage user and compute access to shared resources.
* **Microsoft 365** - Provides collaboration opportunities by giving group members access to a shared mailbox, calendar, files, SharePoint sites, and more.

**Membership Types**
* **Assigned** - Lets you add specific users as members of a group and have unique permissions.
* **Dynamic User** - Lets you use dynamic membership rules to automatically add and remove members. Uses the `attributes` keys. If a member's attributes change, the system looks at your dynamic group rules for the directory to see if the member meets the rule requirements (is added), or no longer meets the rules requirements (is removed). *<b>Requires Azure AD Premium 1 licensing</b>*
* **Dynamic Device** - Lets you use dynamic group rules to automatically add and remove devices.
>**Important** - You can create a dynamic create for either device or users, but not both.

---

# Understanding Azure AD Hybrid Identities

![](../docs/hybrid-aad.png)

## Azure AD Connect
* Sychronizing identities facilitates single sign-on for accessing resources.
* Authentication Management - Azure AD connect can alter where authentication occurs.
* Azure AD Connect Methods - Azure AD connect sync and Azure AD Connect cloud sync (newer).

## Azure AD Domain Service

* Azure AD is built for modern authentication and authorization.
* Azure ADDS is for legacy resources that may depend on traditional AD Domain service features.
* Support domain join, group policy, LDAP and Kerberos/NTLM authentication.

---

# Azure AD & External Identities

External identities help provide customers and partners with access to resources.

## [Azure AD B2B](https://learn.microsoft.com/en-us/azure/active-directory/external-identities/what-is-b2b)

![](../docs/b2b-diagram.png)

Azure Active Directory (Azure AD) B2B collaboration is a feature within External Identities that lets you invite guest users to collaborate with your organization.

A simple invitation and redemption process lets partners use their own credentials to access your company's resources.

## [Azure AD B2C](https://learn.microsoft.com/en-us/azure/active-directory-b2c/overview)

![](https://learn.microsoft.com/en-us/azure/active-directory-b2c/media/overview/azureadb2c-overview.png)

Azure AD B2C is a separate service from Azure Active Directory (Azure AD). It is built on the same technology as Azure AD but for a different purpose. It allows businesses to build customer facing applications, and then allow anyone to sign-up and into those applications with no restrictions on user account.

* Create an entirely new AZ AD tenant.
* This tenant is dedicated to the application for authentication.

## [Azure AD External Identities](https://learn.microsoft.com/en-us/azure/active-directory/external-identities/external-identities-overview)

![](https://learn.microsoft.com/en-us/azure/active-directory/external-identities/media/external-identities-overview/external-identities-b2b-overview.png)

Azure AD External Identities refers to all the ways you can securely interact with users outside of your organization. If you want to collaborate with partners, distributors, suppliers, or vendors, you can share your resources and define how your internal users can access external organizations.

With External Identities, external users can "bring their own identities." Whether they have a corporate or government-issued digital identity, or an unmanaged social identity like Google or Facebook, they can use their own credentials to sign in. The external user’s identity provider manages their identity, and you manage access to your apps with Azure AD or Azure AD B2C to keep your resources protected.

* External identities are a progression and combination of **BOTH** Azure AD B2C and B2B!!

---

# Azure Roles and AD Roles

Azure has three types of roles that can serve the same purpose.

1. **Classic subscription administrator role**: This is the original role system.
1. **Azure Roles (RBAC)** - This authorization system is also known as Role-Based Access Controls (RBAC) and is built on top of Azure Resource Manager (ARM).
1. **Azure Active Directory (Azure AD)** - Azure AD roles are used to manage Azure AD resources in a directory.

## Describing RBAC

- Who = Security Principals - could be a single identity, a group, a service principal, or managed identity
- What = Roles Definiation and permissions - Use of built-in roles likes Owner/Contributor and VM Contributor / Custom Role
- Where = Scope - applied at the Management Group, Subscription, RG or Resource.

Principals (Users) are assigned roles which then give them permissions to designated resources.


## Describe Azure Roles

![](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/media/organize-resources/scope-levels.png)

> [!NOTE]
> Remember permissions flow down the hierarchy. 

**Common Roles**
| Built-in "General" Roles | Description |
| --- | --- |
| `Owner` | Grants full access to manage all resources, including the ability to assign roles in Azure RBAC. |
| `Contributor` | Grants full access to manage all resources, but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, or share image galleries. |
| `Reader` | View all resources, but does not allow you to make any changes. |
| `User Access Administrator` | Lets you manage user access to Azure resources. |

Other common roles used:

- `Virtual Machine Contributor` - Create and manage virtual machines, manage disks, install software, reset password of the root VM. Does not grant management access to VNet or storage account. This role does not allow you to assign roles in Azure RBAC.
- `Storage Account Contributor` - Permits management of storage accounts. Provides access to the account key, which can be used to access data via Shared Key authorization.
- `Network Contributor` - Lets you manage networks, but not access to them.
- `Security Reader` - View permissions for Microsoft Defender for Cloud. Can view recommendations, alerts, a security policy, and security states, but cannot make changes.


[Full list of Azure RBAC roles here.](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)

## Describe Azure AD Roles

* By default, the `global administrator` does not have permissions to manage Azure resources.
* `Global Administrator` can gain access to Azure resource if granted the `User Access Administrator` role (an AZ role)

**Common Roles**
| Built-In Roles | Description |
| --- | --- |
| `global administrator` | Can manage ALL Azure AD resources |
| `billing administrator` | Can perform billing tasks |
| `user administrator` | Can manage users and groups |
| `help desk administrator` | Can reset passwords for users |
| `global reader` | Can read everything a global admin can, but not update anything |

[Full list here](https://docs.microsoft.com/en-us/azure/active-directory/roles/permissions-reference)

## Azure Roles vs Azure AD Roles

| Azure AD Roles                                                             | Azure Roles                                                    |
|----------------------------------------------------------------------------|----------------------------------------------------------------|
| Manage access to Azure AD resources                                        | Manage access to Azure Resources                               |
| Scope is at tenant level                                                   | Scope can be at multiple levels                                |
| Supports custom roles                                                      | Supports custom roles                                          |
| Main Roles: - Global Admins - User Admins - Billing Admins - Global Reader | Main Roles: - Owner - Contributor - Reader - User Access Admin |

![](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/281467i6699E54FC52CE4D5/image-size/large?v=v2&px=999)

## BuiltinRole

Refer to the set of predefined roles offered by Microsoft in Azure. Read-only and cannot be altered.

### Role Assignment

Role assignment is when you apply a role to a service principal which can be one of the following:
* User
* Group
* Service Principal
* Managed Identity

Deny assignments block users from performing specific actions even if a role assignemtn grants them access. The only way to apply Deny assignemnts is through Azure Blueprints.


![](https://learn.microsoft.com/en-us/azure/role-based-access-control/media/shared/rg-access-control.png)
(Look at the Role Assignments or Deny Assignemnts tabs)


## Custom Roles

You can create custom roles in Azure and in Azure AD. CustomRole represents user-defined roles in Azure with your own custom logic based on specific requirements.

### Azure Custom Roles

If the Azure built-in roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals at management group (in preview only), subscription, and resource group scopes.

Custom roles can be shared between subscriptions that trust the same Azure AD tenant. There is a limit of 5,000 custom roles per tenant. 

### Azure Active Directory Custom Roles

Granting permission using custom Azure AD roles is a two-step process that involves creating a custom role definition and then assigning it using a role assignment. A custom role definition is a collection of permissions that you add from a preset list.

A role assignment is an Azure AD resource that attaches a role definition to a security principal at a particular scope to grant access to Azure AD resources.

> [!WARNING]
> You'll need to purchase either [Azure AD Premium P1 or P2](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/custom-create#prerequisites) to create custom roles in Azure AD.

#### Example

The following diagram shows an example of a role assignment. In this example, Chris has been assigned the App Registration Administrator custom role at the scope of the Contoso Widget Builder app registration. The assignment grants Chris the permissions of the App Registration Administrator role for only this specific app registration.

![](https://learn.microsoft.com/en-us/azure/active-directory/roles/media/custom-overview/rbac-overview.png)

---

# Identity Security

# Identities with Azure AD Identity Protection

![](https://learn.microsoft.com/en-us/azure/active-directory/identity-protection/media/overview-identity-protection/identity-protection-overview.png)

**Overview**

Identity Protection allows organizations to accomplish three key tasks:

* Automate the detection and remediation of identity-based risks.
* Investigate risks using data in the portal.
* Export risk detection data to other tools.

**Detect Risks**

Identity Protection detects risks of many types, including:

* Anonymous IP address use - Sing in from an anonymous IP address (eg. Tor browser, anonymizer VPNs)
* Atypical travel - Sing in from an atypical location based on the user's recent sign-ins
* Malware linked IP address - Sign in from a malware linked IP address
* Unfamiliar sign-in properties - Sign in with properties that haven't been seen recently for the given user
* Leaked Credentials - Indicates that the user's valid credentials have been leaked
* Password spay - Multiple usernames being attacked using common passwords in a unified, brute-force manner

**Required Roles**

Identity Protection requires users be a Security Reader, Security Operator, Security Administrator, Global Reader, or Global Administrator in order to access.

**License Requirements**

| Capability | Details | Azure AD P1 | Azure AD P2 |
| --- | --- | :-: | :-: |
| Risk Policies | Sign-in and user risk policies | No | Yes |
| Security Reports | Overview | No | Yes |
| Security Reports | Risky Users | Limited Info. Only users with medium and high risk are show. | Full access |
|  Security Reports | Risky sign-ins | Limited. No risk detail or risk level is shown | Full Access |
| Security Reports | Risky detections | Limited | Full access |
| Notifications | Users at risk deted alerts | No | Yes |
| Notifications | Weekly digest | No | Yes |
| MFA registration policy | | No | Yes|

* *Azure AD and Microsoft 365 Apps have no capabilities*

**Sign-in Risk Policy**

- **Real-Time Detection** - Takes affect in real time. These policies can be used to block a sign-in as it occurs.
- **Assignment** - Describes when the policy will trigger. This includes defining the applicable users/groups and the risk level condition.
- **Control** - Describes what to do when the policy triggers. The action can be to block or allow a sign-in, or allow access but require MFA.

**User Risk Policy**

- **Offline detection** - Takes effect offline. These policies can identiy user accounts that are found to be at risk
- **Assignment** - describes when the policy will trigger. THis includes defining the application user/groups and the risk level condition.
- **Control** - Describes what to do when the policy triggers. The action can be to block or allow access, or force a password change.

---

# Protecting Resource with AAD Conditional Access

![](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/media/overview/conditional-access-overview-how-it-works.png)

Conditional Access brings signals together, to make decisions, and enforce organizational policies. Azure AD Conditional Access is at the heart of the new identity-driven control plane.

Conditional Access policies at their simplest are if-then statements, if a user wants to access a resource, then they must complete an action.

<u>Example</u>

A payroll manager wants to access the payroll application and is required to do multifactor authentication to access it.

Administrators are faced with two primary goals:

1. Empower users to be productive wherever and whenever
1. Protect the organization's assets

## [Common Signals](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/overview)

Common signals that Conditional Access can take in to account when making a policy decision include the following signals:

* **User or group Membership**
    * Policies can be targeted to specific users and groups for fine grained control
* **IP Location**
    * Create trusted IP address ranges
    * Admins can specify entire countries/regions IP range to block or allow
* **Device**
    * Users with devices of specific platforms or specific state can be used when enforcing Conditional Access policies.
    * Use filters for devices to target policies to specific devices
* **Real-time and calculated risk detection**
    * Signals integration with AZ AD Identity Protection allows Conditional Access policies to identify risky sign-in behavior.
* **User Risk**
    * For customers with Identity Protection, user risk can be evaluated as part of a Condiational Access policy.
    * User risk represents the probability that a given identity or account is compromised.
* **Cloud apps or actions**
    * Cloud apps or actions can include or exclude cloud applications or user actions that will be subject to the policy.

## Common Decisions

Common decisions define the access controls that device what level of access ased on Signal information

* **Block access**
    * Most restrictive decision
* **Grant access**
    * Least restrictive decision, still require one or more of the following options:
        * Require multi-factor authentication
        * Require device to be marked as compliant
        * Require hybrid Azure AD joined device
        * Require approved client app
        * Require app protection policy (preview)

## License Requirements

* Using this feature requires Azure AD P1 licenses.
* Customers with Microsoft 365 Business Premium also have access
* Risk-based policies require access to Identity Protection, which is an Azure AD P2 feature.

## [Reporting](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/howto-conditional-access-insights-reporting)

Using Conditional Access, there is a chance you can lock your self out of the environment. To help prevent this action, first put the new condtiion in [`report-only`](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/concept-conditional-access-report-only) mode to understand the impact of the Conditional Access policy.

### Example of conditional access

Look at this [video on setting up Conditional Access](https://youtu.be/5DsW1hB3Jqs)

---

# Azure AD Privileged Identity Management (PIM)

Azure AD PIM is a Premium feature that enables you to limit standing admin access to privileged roles.

You can manage just-in-time assignments to all Azure AD roles and all Azure roles using Privileged Identity Management (PIM) in Azure Active Directory (Azure AD).
* Meaning - As a Global Admin, you can timebox certain roles and then assign them to a user. Example would be Uesr1 requires a higher AD role. Instead of granting User1 the role directory, you can 
    * Time box it.
    * Set a start and end date
    * [Limit usage for X minutes/hours/days.](https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-how-to-change-default-settings)
    * Or [request approval](https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/azure-ad-pim-approval-workflow) to use the role and then a Global Admin can approve request.


## License Requirements

* PIM requires Azure AD P2 or EMS E5 licensing

---

# Design Identity Governance (Access Reviews)

![](https://learn.microsoft.com/en-us/azure/active-directory/governance/media/identity-governance-overview/privileged-access-lifecycle.png)

Access reviews in Azure Active Directory (Azure AD), enable organizations to efficiently manage group memberships, access to enterprise applications, and role assignments. User's access can be reviewed regularly to make sure only the right people have continued access.

Access to groups and applications for employees and guests changes over time. To reduce the risk associated with stale access assignments, administrators can use Azure Active Directory (Azure AD) to create access reviews for group members or application access.

Great service to automatically, through repeated schedules, set up reviews for users and their access. Give end users a specific amount of time to respond. Collect the feedback and take action.

[Here a quick example](https://learn.microsoft.com/en-us/azure/active-directory/governance/create-access-review#create-a-single-stage-access-review)


## License Requirements

* PIM requires Azure AD P2

---

# Introduction to Azure Policies

Azure Policies enforce organizational standards and to assess compliance at-scale. Policies do not restrict access; they only observe for compliance.

<u>Policy Make-Up</u>

![](https://learn.microsoft.com/en-us/azure/governance/policy/media/create-and-manage/definition-under-authoring.png)

* **Policy Definitions** - A policy definition is a JSON file used to describe business rules to control access to resources.
* **Policy Assignment** - The scope of a policy can affect. Assigned to a user, a resource group or management group.
* **Policy Parameters** - Values you can pass into your Policy definition, so your Policies are more flexible for re-use.
* **Initiative Definitions** - An initiative definition is a collection of policy definitions, that you can assign. eg, A group of policies to enforce PCI-DSS compliance

### Azure Policy Use-cases

Here are some examples of why to use Azure Policy:

1. **Organization compliance**: Azure Policy enforces standards and assess compliance at-scale, such as enforcing compliance labels on all resources.
1. **Cost Control:** Policies can prevent over-provisioning to save costs, like limiting the creation of high-cost VMs.
1. **Security Enhancements**: Policies can improve security by enforcing configuration like requiring secure transfer for all storage accounts.
1. **Resource consistency**: Policies can enforce consistent configurations like a specific naming convention or tag structure.
1. **Regulatory compliance**: Policies can ensure specific configurations for regulatory compliance, such as data hosting in specific regions for data sovereignty.

### Recommended Azure Policies

Here's a [link](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies) the to Azure Landing zone with recommended policies to enable at different stacks.

As of March 2024 - Here's a link to a local [Excel Doc](../docs/ALZ%20Policy%20Assignments%20v2.xlsx) with all the Policies and at what level.

### Anatomy of an Azure Policy Definition File

Here's a link to the official Microsoft doc for [Azure Policy definition structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure).

```json
{
  "properties": {
    "displayName": "Audit flow logs configuration for every virtual network",
    "description": "Audit for virtual network to verify if flow logs are configured. Enabling flow logs allows to log information about IP traffic flowing through virtual network. It can be used for optimizing network flows, monitoring throughput, verifying compliance, detecting intrusions and more.",
    "policyType": "BuiltIn",
    "mode": "Indexed",
    "metadata": {
      "version": "1.0.1",
      "category": "Network"
    },
    "version": "1.0.1",
    "parameters": {
      "effect": {
        "type": "string",
        "defaultValue": "Audit",
        "allowedValues": [
          "Audit",
          "Disabled"
        ],
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        }
      }
    },
    "policyRule": {
      "if": {
        "allof": [
          {
            "field": "type",
            "equals": "Microsoft.Network/virtualNetworks"
          },
          {
            "count": {
              "field": "Microsoft.Network/virtualNetworks/flowLogs[*]"
            },
            "equals": 0
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
    }
  },
  "id": "/providers/Microsoft.Authorization/policyDefinitions/4c3c6c5f-0d47-4402-99b8-aa543dd8bcee",
  "name": "4c3c6c5f-0d47-4402-99b8-aa543dd8bcee"
}
```

* `displayName` - Identifies the policy (128 character limit)
* `description` - Provides the context of the policy
* `policyType` - Has three options:
    * **BuiltIn** - Microsoft maintained
    * **Custom** - Created and maintained by you, the owner.
    * **Static** - Microsoft Owned, a regulatory compliance
* `mode` - Determines which resource types are evaluated. Changes whether Resource Provider or Azure Resource Manager is used.
    * **Resource Manager**
        * `All` - Resource Groups, subscriptions and all resource types
        * `Indexed` - Only resource types that support tags and location
    * **Resource Provider**
        * Microsoft.ContainerService.Data
        * Microsoft.KeyVault.Data
* `metadata` - Optional field used to store key-value information on the policy
* `parameters` - Are values passed into the policy to improve its flexibility. Has the following properties:
    * `name` the name of the parameter
    * `type` can be String, Array, Object, Boolean, Integar, Float or Datetime
    * `metadata` used by Azure to display friendly information
        * description
        * displaNmae
        * strongType (optional, multi-select list)
        * assignPermissions
    * `defaultValue` (opt)
    * `allowedValue` (opt)
* `policyRule`
    - consists of `if` and `then` blocks. In the `if` block, you define one or more conditions that specify when the policy is enforced.
        * You can apply logical operators to these conditions to precisely define the scenario for a policy.
        ```json
        {
            "if": {
                <condition> | <logical operator>
            },
            "then": {
                "effect": "deny | audit | append | auditIfNotExists | deployIfNotExists | disabled"
            }
        }
        ```

### Configure Azure Policy

When you first setup your Azure tenant, Microsoft will automatically assign a default Azure Policy that is an [initiative compliance](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/initiative-definition-structure) policy. Initiatives enable you to group several related definitions to simplify assignments and management because you work with a group as a single item. For example, you can group related tagging policy definitions into a single initiative. Rather than assigning each policy individually, you apply the initiative.

![](../docs/az-policy-overview.png)
(*Azure Policy Overview - Default assignment*)

![](../docs/az-policy-initiative.png)
(*Azure Policy initiative details*)

![](../docs/az-policy-assignment.png)


---

# [Azure Resource Manager](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview)

![](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/media/overview/consistent-management-layer.png)

Azure Resource Manager is the deployment and management service for Azure. It provides a management layer that enables you to create, update, and delete resources in your Azure account. When you send a request through any of the Azure APIs, tools, or SDKs, Resource Manager receives the request. It authenticates and authorizes the request before forwarding it to the appropriate Azure service.

## Scope

Azure has 4 levels of management scope:

![](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/media/overview/scope-levels.png)

1. Management Groups - a logical grouping of multiple subscriptions
1. Subscriptions - Grants you access to Azure services based on a billing and support agreement
1. Resource Groups - A logical grouping of multiple resources
1. Resources - An Azure resource like VMs, Storage, DBs, APIs, etc.

## [Azure Management Groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview)

Management groups provide a governance scope above subscriptions. You organize subscriptions into management groups; the governance conditions you apply cascade by inheritance to all associated subscriptions.

![](https://learn.microsoft.com/en-us/azure/governance/media/mg-org.png)

You can create a hierarchy that applies a policy, for example, which limits VM locations to the West US region in the management group called "Corp". This policy will inherit all the Enterprise Agreement (EA) subscriptions that are descendants of that management group and will apply to all VMs under those subscriptions. This security policy cannot be altered by the resource or subscription owner, allowing for improved governance.

### Root Management group

Each directory is given a single top-level management group called the root management group. The root management group is built into the hierarchy to have all management groups and subscriptions fold up to it. This root management group allows for global policies and Azure role assignments to be applied at the directory level. 

#### Facts About Root Management Group
* The root management group can't be moved or deleted
* By default, the root management group's display name is Tenant root group and operates itself as a management group. You can change the name if you have correct RBAC.
* All Azure customers can see the root management group, but not all customers have access to manage that root management group.

## Subscriptions

Before you can do anything in your Azure account, you'll need a subscription. An Azure Account can have multiple subscriptions and the most common three are:

* Free Trial
* Pay-as-you-Go
* Azure for Students

At the subscription level you'll have the ability to set:

* Resource Tags
* Access Controls
* Resource Groups
* Cost Management and billing
* More...

## Resource Groups

A resource group is a container that holds related resources for an Azure subscription. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group. Generally, add resources that share the same lifecycle to the same resource group so you can easily deploy, update, and delete them as a group.

### Resource Providers

In order to use Azure resources, you have to register Resource Providers. Many providers are registered by default for you with your Subscription. However, for certain resources you may need to manually register the Resource Provider.

1. Go to your subscription, select Resource Providers
    ![](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/media/resource-providers-and-types/select-resource-providers.png)
1. Find the resource provider you want to register and select **Register**.
    ![](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/media/resource-providers-and-types/register-resource-provider.png)

### Move to another resource group or subscription

You can move the resources in the group to anothre resource group. There is a checklist that must be referenced if you decide to move resources around.

#### [Checklist](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-resource-group-and-subscription#checklist-before-moving-resources)

1. The source and destination subscriptions must exist within the same Microsoft Entra tenant.
1. The resources you want to move must support the move operation.
1. Some services have specific limitations or requirements when moving resources. Check the specific service before moving.
1. The destination subscription must be registered for the resource provider of the resource being moved.

### Lock resource groups

Locking prevents other users in your organization from accidentally deleting or modifying critical resources, such as Azure subscription, resource group, or resource.

---

# [ARM templates](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/overview)

To implement infrastructure as code for your Azure solutions, use Azure Resource Manager templates (ARM templates). The template is a JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your project. The template uses declarative syntax, which lets you state what you intend to deploy without having to write the sequence of programming commands to create it. 

## Why choose ARM templates?

Here are some advantages of using templates:

* **Declarative syntax**: ARM templates allow you to create and deploy an entire Azure infrastructure declaratively. No need to write the sequence of commands, let ARM figure it out.
* **Repeatable results**: Repeatedly deploy your infrastructure throughout the development lifecycle. Templates are idempotent, which means you can deploy the same template many times and get the same resource types in the same state.
* **Orchestration**: Resource Manager orchestrates the deployment of interdependent resources so they're created in the correct order. When possible, Resource Manager deploys resources in parallel so your deployments finish faster than serial deployments.
* **Modular Files**: You can break your templates into smaller, reusable components and link them together at deployment time. You can also nest one template inside another template.
* **Built-in validation**: Resource Manager checks the template before starting the deployment to make sure the deployment will succeed.

## [ARM structure and syntax](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/syntax)

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "languageVersion": "",
  "contentVersion": "",
  "apiProfile": "",
  "definitions": { },
  "parameters": { },
  "variables": { },
  "functions": [ ],
  "resources": [ ], /* or "resources": { } with languageVersion 2.0 */
  "outputs": { }
}
```

| Element | Required | Description |
| --- | --- | --- |
| $schema | Yes | Describes the properties that are available within a template |
| contentVersion | Yes | the version of the template. You can provide any value for this element. |
| apiProfile | No | Use this value to avoid having to specify API versions for each resource in the template. |
| definitions | No |  |
| parameters | No | values you can pass along to your template |
| variables | No | You can transform parameters or resource properties using function expressions |
| functions | No | User-defined functions available within the template. |
| resources | Yes | The Azure resources you'll want to deploy or update |
| outputs | No | VAlues that are returned after deployment |

### Resources

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2019-04-01",
      "name": "{provide-unique-name}",
      "location": "eastus",
      "sku": {
        "name": "Standard_LRS"
      },
      "kind": "StorageV2",
      "properties": {
        "supportHttpsTrafficOnly": true
      }
    }
  ],
}
```

| Element | Required | Description |
| --- | --- | --- |
| type | Yes | Type of resource. Follows the format {ResourceProvider}/ResourceType|
| apiVersion | Yes | Version of the REST API to use for the resource. Each resource provider published has its own API version |
| name | Yes | Name of resource |
| location | Varies | Most resource have a location property. The region where the resource will be deployed |

### Parameters

Allows you to pass variables to your ARM template.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "storageName": {
      "type": "string",
      "minLength": 5,
      "maxLength": 20
    }
  },
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2019-04-01",
      "name": "[parameters('storageName')]",
      "location": "eastus",
      "sku": {
        "name": "Standard_LRS"
      },
      "kind": "StorageV2",
      "properties": {
        "supportHttpsTrafficOnly": true
      }
    }
  ],
}
```

| Element | Required | Description |
| --- | --- | --- |
| Parameter-name | Yes | |
| type | Yes | the expected data type of the inputed value<br> * string, securestring, int, bool, object, secureObject and array |
| defaultValue | No | if no value is provided it will be set to this value |
| allowedValues | No | An array of allowed values |
| minValue | No | minimum possible value |
| maxValue | No | max possible value |
| minLength | No | the min length of characters or array |
| maxLength | No | the max length of characters or array |

### Functions

Allows you to apply transformations to your ARM variables
 * Template Function - built-in functions
 * Used-defined functions - custom functions you create.

 ---

 # Azure Monitor