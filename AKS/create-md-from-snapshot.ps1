#az login --use-device-code


#Provide the subscription Id
$subscriptionId = '6b80f5aa-b6d1-430e-8772-759a8f1511f1'



#Provide the storage type for Managed Disk. PremiumLRS or StandardLRS.
$storageType = 'Premium_LRS'

$location = 'westus'

#Set the context to the subscription Id where Managed Disk will be created
az account set --subscription $SubscriptionId

# create snapshot
#Provide the name of your resource group
$resourceGroupName ="MC_experimental-rg_ts-aks-experimental_westus"
$snapshotName = "snapshot-pvc-d8f33-1"
#$snapshotFrom = "kubernetes-dynamic-pvc-d8f33bd3-5ffb-4ae5-8238-3d7217458abc"
# both works
$snapshotFrom = "/subscriptions/6b80f5aa-b6d1-430e-8772-759a8f1511f1/resourceGroups/mc_experimental-rg_ts-aks-experimental_westus/providers/Microsoft.Compute/disks/kubernetes-dynamic-pvc-d8f33bd3-5ffb-4ae5-8238-3d7217458abc"

#create snapshot from disk
# az snapshot create -g $resourceGroupName -n $snapshotName --source $snapshotFrom

#Provide the name of the Managed Disk
$diskName = 'disk-from-snapshot'
$diskSize = '6'
$snapshotSource = "/subscriptions/6b80f5aa-b6d1-430e-8772-759a8f1511f1/resourceGroups/MC_experimental-rg_ts-aks-experimental_westus/providers/Microsoft.Compute/snapshots/snapshot-pvc-d8f33-1"
# or both works
#$snapshotSource = "snapshot-pvc-d8f33-1"

# create disk from snapshot
# az disk create -g $resourceGroupName -n $diskName --source $snapshotSource

#create disk from another disk without snapshot
$snapshotSource = "/subscriptions/6b80f5aa-b6d1-430e-8772-759a8f1511f1/resourceGroups/mc_experimental-rg_ts-aks-experimental_westus/providers/Microsoft.Compute/disks/kubernetes-dynamic-pvc-d8f33bd3-5ffb-4ae5-8238-3d7217458abc"
az disk create -g $resourceGroupName -n $diskName --source $snapshotSource
