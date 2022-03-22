# escape=`

ARG BASE_IMAGE
ARG SPE_IMAGE
ARG COVEO_ASSET
ARG COVEO_SXA_ASSET

FROM ${SPE_IMAGE} as spe
FROM ${COVEO_ASSET} as coveo
FROM ${COVEO_SXA_ASSET} as coveosxa
FROM ${BASE_IMAGE}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Add SPE module
COPY --from=spe \module\db \spe_data
RUN C:\DeployDatabases.ps1 -ResourcesDirectory C:\spe_data; `
    Remove-Item -Path C:\spe_data -Recurse -Force;

# Add Coveo module
COPY --from=coveo \module\db \coveo_data
RUN C:\DeployDatabases.ps1 -ResourcesDirectory C:\coveo_data; `
    Remove-Item -Path C:\coveo_data -Recurse -Force;

# Add Coveo SXA module
COPY --from=coveosxa \module\db \coveo_data
RUN C:\DeployDatabases.ps1 -ResourcesDirectory C:\coveo_data; `
    Remove-Item -Path C:\coveo_data -Recurse -Force;
