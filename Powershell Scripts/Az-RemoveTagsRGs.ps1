# This script will delete specified tag on all resource groups

# Update this variable with tag name to be deleted. No tag value required.
$DeleteTag = "ContactEmail"

# To get all subscriptions
# $subs = Get-AzSubscription
# Get only a specific subscription
# $subs = Get-AzSubscription | Where-Object {$_.Name -eq "SUBS NAME"}
# To get all subscriptions except subscription named: SUBS NAME
# Replace -notlike with -eq to get a specific subscription
$subscriptions = Get-AzSubscription | Where-Object {$_.Name -notlike "SUBS NAME"}

# Traverse through all subscriptions
Foreach ($subscription in $subscriptions ) {

# Select a subscription
Select-AzSubscription -subscriptionid $subscription

# Get list of resource groups in subscription
$rg = Get-AzResourceGroup
# For each resource group, get the associated tags and put into a variable
Foreach ($i in $rg.ResourceGroupName)
{
 $Tags = (Get-AzResourceGroup -Name $i).Tags
 # Remove the tag with the Name specified
 $Tags.Remove($DeleteTag)
 # Set the tags on the resource group
 Set-AzResourceGroup -Name $i -Tag $Tags
}

}