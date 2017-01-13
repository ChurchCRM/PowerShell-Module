Function Connect-CCRMService
{
     <#
    .SYNOPSIS
        Connects to the ChurchCRM API.

    .PARAMETER URL  
        The URL of the ChurchCRM instance

    .PARAMETER user 
        The User Name

    .PARAMETER encodedPassword
        The password

    #>
    Param(
        $URL,
        $UserName,
        $Password
    )

    Set-Variable -Scope Global -Name "CRMURL" -Value $URL
    Set-Variable -Scope Global -Name "CRMUsername" -Value $UserName
    Set-Variable -Scope Global -Name "CRMPassword" -Value $Password

    Invoke-WebRequest -Uri "$URL/Login.php" -Method "POST" -Body "User=$UserName&Password=$Password" -SessionVariable CRMSession

    Set-Variable -Scope Global -Name "CRMSession" -Value $CRMSession

}

Function Invoke-CRMRESTMethod
{
    param(
        $EndpointURL,
        $Method = "GET",
        $Page=1,
        [System.Collections.Hashtable]
        $Parameters=@{}
    )
    if ( (test-path variable:global:"CRMURL") -and  (test-path variable:global:"CRMSession") )
    {
        $URI = "$($(Get-Variable -Name "CRMURL").Value)/api/$($EndpointURL)"
        if ($parameterString)
        {
            $URI +="?$($parameterString)"
        }
        Invoke-RestMethod -uri $URI -Method $Method -WebSession $($(Get-Variable -Name "CRMSession").value)
    }
    else 
    {
        throw "CRMURL and CRMSession Required"
    }

}



Function Get-CCRMPeople
{
    param(
        $searchTerm
    )
    $a = Invoke-CRMRESTMethod -EndpointURL "persons/search/$searchTerm" |
        ConvertFrom-Json
        
    $a |  Select-Object -ExpandProperty persons

}