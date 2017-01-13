# Usage

First, connect to the ChurchCRM API:

``` PowerShell
Connect-CCRMService -URL "https://churchcrm.yourorg.org" -UserName "yourname" -Password "yourPW!"
```

Then,  Get a list of users 

``` PowerShell
Get-CCRMPeople -searchTerm "<personSearchTerm>"
```