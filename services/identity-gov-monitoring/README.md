# Identity, Governance and Monitoring README

![](../docs/authN-authZ.png)

Azure Active Directory is at the heart of everything when it comes to Authentication (AuthN) and Authorization(AuthZ).

---

## Azure AD Refresh!

### Azure AD Tenant

Azure Active Directory (Azure AD) is a cloud-based identity and access management service. Azure AD enables your employees access external resources, such as Microsoft 365, the Azure portal, and thousands of other SaaS applications.

All Azure subscriptions have a trust relationship with an Azure Active Directory (Azure AD) instance. Subscriptions rely on their trusted Azure AD to authenticate and authorize security principals and devices.

When a user signs up for a Microsoft cloud service, a new Azure AD tenant is created and the user is made a member of the Global Administrator role. However, when an owner of a subscription joins their subscription to an existing tenant, the owner isn't assigned to the Global Administrator role.

![](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/media/active-directory-how-subscriptions-associated-directory/trust-relationship-azure-ad.png)

> **Important**: When a subscription is associated with a different directory, users who have roles assigned using Azure role-based access control lose their access. Classic subscription administrators, including Service Administrator and Co-Administrators, also lose access. Moving your Azure Kubernetes Service (AKS) cluster to a different subscription, or moving the cluster-owning subscription to a new tenant, causes the cluster to lose functionality due to lost role assignments and service principal's rights.

Click [here](https://learn.microsoft.com/en-us/training/modules/explore-basic-services-identity-types/3-describe-available-editions) to see the differnet licenses for Azure AD.

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

