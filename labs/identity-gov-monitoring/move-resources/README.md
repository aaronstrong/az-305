# Lab to move resources between Resource Groups

In this lab we'll be creating two resource groups, deploying a Managed Disk in a source Resource Group and then moving it to a new destination Resource Group.

## Creation of Resources

The terraform code will create all the necessary resources, but YOU'LL need to move the disk from the source RG to the destination RG. The destination RG does have a Read-only and DoNotDelete lock at the RG level.

Experiment with moving the disk between resource groups with different locks.

> [!NOTE]
> To do the initial move, you will need to remove one of the locks from the destination Resource Group. But which one?