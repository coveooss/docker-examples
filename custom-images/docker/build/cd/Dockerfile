# escape=`

ARG BASE_IMAGE
ARG SXA_IMAGE
ARG TOOLING_IMAGE
ARG SOLUTION_IMAGE
ARG COVEO_ASSET
ARG COVEO_SXA_ASSET

FROM ${SOLUTION_IMAGE} as solution
FROM ${TOOLING_IMAGE} as tooling
FROM ${SXA_IMAGE} as sxa
FROM ${COVEO_ASSET} as coveo
FROM ${COVEO_SXA_ASSET} as coveosxa
FROM ${BASE_IMAGE}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Copy development tools and entrypoint
COPY --from=tooling \tools\ \tools\

WORKDIR C:\inetpub\wwwroot

# Add Coveo module
COPY --from=coveo \module\cm\content .\

# Add Coveo SXA module
COPY --from=coveosxa \module\cm\content .\
RUN cmd /C icacls .\App_Config\Include\Coveo /grant 'IIS AppPool\DefaultAppPool:(OI)(CI)M';
RUN cmd /C icacls .\App_Config\Modules\Coveo /grant 'IIS AppPool\DefaultAppPool:(OI)(CI)M';


# Add SXA module
COPY --from=sxa \module\cd\content .\
COPY --from=sxa \module\tools \module\tools

RUN C:\module\tools\Initialize-Content.ps1 -TargetPath .\; `
    Remove-Item -Path C:\module -Recurse -Force;
 
# Copy solution website files
COPY --from=solution \artifacts\website\ .\

# Copy solution transforms
COPY --from=solution \artifacts\transforms\ \transforms\solution\

# Perform solution transforms
RUN C:\tools\scripts\Invoke-XdtTransform.ps1 -Path .\ -XdtPath C:\transforms\solution\DockerExamples.Website