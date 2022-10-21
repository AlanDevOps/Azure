$rule = Get-NetFirewallRule -Name 'FirewallRuleName'; $rule.Group = 'NewGroupName'; $rule | Set-NetFirewallRule;
$rule | Set-NetFirewallRule;