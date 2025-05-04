# Audit-LocalUsers.ps1
# Lists all local users and their group memberships

Get-LocalUser | ForEach-Object {
    $user = $_.Name
    $groups = (Get-LocalGroup | Where-Object {
        (Get-LocalGroupMember $_.Name -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq $user })
    }).Name
    [PSCustomObject]@{
        User = $user
        Groups = $groups -join ", "
    }
} | Format-Table -AutoSize

Write-Host "Review the list for unauthorized or suspicious accounts."
