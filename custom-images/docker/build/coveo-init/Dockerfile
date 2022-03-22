# escape=`

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY cfsc.ps1 C:\cfsc.ps1

# Run Coveo Activation Scripts
ENTRYPOINT . .\cfsc.ps1; Configure-CoveoForSitecorePackage -SitecoreInstanceUrl $env:COVEO_HOST -OrganizationId $env:COVEO_ORG_ID -ConfigApiKey $env:COVEO_API_KEY -SearchApiKey $env:COVEO_SEARCH_API_KEY -CoveoSitecoreUsername $env:COVEO_USER -CoveoSitecorePassword $env:COVEO_PASSWORD -FarmName $env:COVEO_FARMNAME -ScriptSitecoreUsername $env:SITECORE_ADMIN_USER -ScriptSitecorePassword $env:SITECORE_ADMIN_PASSWORD; Activate-CoveoForSitecorePackage -SitecoreInstanceUrl $env:COVEO_HOST -ScriptSitecoreUsername $env:SITECORE_ADMIN_USER -ScriptSitecorePassword $env:SITECORE_ADMIN_PASSWORD
