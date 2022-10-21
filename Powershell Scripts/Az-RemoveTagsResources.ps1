# This script will delete tags on all resources in all subscriptions,
# Before running this script, ensure that tags are deleted at RG level first
# otherwise they'll be re-added via the Inherit policy (if applied)

# To get all subscriptions
# $subs = Get-AzSubscription
# Get only a specific subscription
# $subs = Get-AzSubscription | Where-Object {$_.Name -eq "SUBS NAME"}
# To get all subscriptions except SUBS NAME
$subs = Get-AzSubscription | Where-Object {$_.Name -notlike "SUBS NAME"}

# Specify tag name
$tagname = "ContactEmail"
# Specify tag value
$tagvalue = "person@companyemail.com"

# Through all subscriptions, get resources with specified tag and value,
# remove the tag from the array and update the resource
$subs | ForEach-Object {
    Set-AzContext $_
    $rs = Get-AzResource -TagName $tagname -TagValue $tagvalue
    $rs | ForEach-Object {
        $_.Tags.Remove($tagname)
        $_ | Set-AzResource -Force
    }
}