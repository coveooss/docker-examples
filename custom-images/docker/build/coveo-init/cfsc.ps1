function Configure-CoveoForSitecorePackage([Parameter(Mandatory=$true)]
                                           [string] $SitecoreInstanceUrl,
                                           [string] $CoveoForSitecoreApiVersion = "v1",
                                           [string] $OrganizationId,
                                           [string] $ConfigApiKey,
                                           [string] $SearchApiKey,
                                           [boolean] $DisableSourceCreation = $false,
                                           [string] $CoveoSitecoreUsername,
                                           [string] $CoveoSitecorePassword,
                                           [string] $DocumentOptionsBodyIndexing = "Rich",
                                           [boolean] $DocumentOptionsIndexPermissions = $true,
                                           [string] $FarmName,
                                           [boolean] $BypassCoveoForSitecoreProxy = $false,
                                           [Parameter(Mandatory=$true)]
                                           [string] $ScriptSitecoreUsername,
                                           [Parameter(Mandatory=$true)]
                                           [string] $ScriptSitecorePassword)
{
    $ConfigureCoveoForSitecoreUrl = $SitecoreInstanceUrl + "/coveo/api/config/" + $CoveoForSitecoreApiVersion + "/configure"

    $Body = @{ }

    if (![string]::IsNullOrEmpty($OrganizationId)) {
        $Body.Organization = @{
            "OrganizationId" = $OrganizationId
            "ApiKey" = $ConfigApiKey
            "SearchApiKey" = $SearchApiKey
            "DisableSourceCreation" = $DisableSourceCreation
        }
        $Body.SitecoreCredentials = @{
            "Username" = $CoveoSitecoreUsername
            "Password" = $CoveoSitecorePassword
        }
        $Body.DocumentOptions = @{
            "BodyIndexing" = $DocumentOptionsBodyIndexing
            "IndexPermissions" = $DocumentOptionsIndexPermissions
        }
        $Body.Proxy = @{
            "BypassCoveoForSitecoreProxy" = $BypassCoveoForSitecoreProxy
        }
    }
    if (![string]::IsNullOrEmpty($FarmName)) {
        $Body.Farm = @{
            "Name" = $FarmName
        }
    }

    $BodyJson = $Body | ConvertTo-Json

    $m_Headers = @{
        "x-scUsername" = $ScriptSitecoreUsername
        "x-scPassword" = $ScriptSitecorePassword
    }

    Write-Host "Configuring the Coveo for Sitecore package... "
    Try {
        Invoke-RestMethod -Uri $ConfigureCoveoForSitecoreUrl -Method PUT -Body $BodyJson -Headers $m_Headers -ContentType "application/json"
        Write-Host "The Coveo for Sitecore package is now configured."
    }
    Catch {
        Write-Host "There was an error during your Coveo for Sitecore package configuration:"
        Write-Host $PSItem
    }
}
function Activate-CoveoForSitecorePackage([Parameter(Mandatory=$true)]
                                          [string] $SitecoreInstanceUrl,
                                          [string] $CoveoForSitecoreApiVersion = "v1",
                                          [Parameter(Mandatory=$true)]
                                          [string] $ScriptSitecoreUsername,
                                          [Parameter(Mandatory=$true)]
                                          [string] $ScriptSitecorePassword)
{
    $ActivateCoveoForSitecoreUrl = $SitecoreInstanceUrl + "/coveo/api/config/" + $CoveoForSitecoreApiVersion + "/activate"

    $m_Headers = @{
        "x-scUsername" = $ScriptSitecoreUsername
        "x-scPassword" = $ScriptSitecorePassword
    }

    Write-Host "Activating the Coveo for Sitecore package... "

    Try {
        Invoke-RestMethod -Uri $ActivateCoveoForSitecoreUrl -Method POST -Headers $m_Headers -ContentType "application/json"
        Write-Host "The Coveo for Sitecore package is now activated."
        
    }
    Catch {
        Write-Host "There was an error during your Coveo for Sitecore package activation:"
        Write-Host $PSItem
    }
}