#!/bin/bash
# Set up EasyBuild environment for KIR staff builds
# Should be used when as own user for testing and when building as kir-software

# Parse args
sysname=${1:-skylake}  # Default to skylake if not specified

# Set up module path to include existing cluster modules and KIR modules
export MODULEPATH="/apps/kir/eb/${sysname}/modules/all:\
/apps/eb/${sysname}/modules/all:\
/apps/eb/dev/${sysname}/modules/all:\
/apps/eb/2022b/${sysname}/modules/all:\
/apps/eb/2023a/${sysname}/modules/all:\
/apps/eb/2020b/${sysname}/modules/all:\
/apps/eb/el7/common/modules/all:\
/etc/modulefiles:\
/usr/share/modulefiles:\
/apps/eb/el8/2023a/skylake/modules/all:\
/apps/eb/el8/common/modules/all:\
/apps/kir/eb/skylake/modules/all:\
/apps/eb/skylake/modules/all:\
/apps/eb/dev/skylake/modules/all:\
/apps/eb/2022b/skylake/modules/all:\
/apps/eb/2020b/skylake/modules/all"

# Load EasyBuild if not already loaded
if module list 2>&1 | grep -q 'EasyBuild'; then
    printf "EasyBuild module already loaded. Continuing with currently loaded modules.\n"
else
    module purge 2> /dev/null
    module load EasyBuild
fi

# General Settings (applies to both test and production)
export EASYBUILD_CUDA_COMPUTE_CAPABILITIES="8.0,6.1"  # Fixed typo: was "8.0.61"
export EASYBUILD_TMPDIR="${TMPDIR:-/tmp}"
export EASYBUILD_USE_EXISTING_MODULES=1
export EASYBUILD_ALLOW_LOADED_MODULES="EasyBuild"

# Job configuration
export EASYBUILD_JOB_BACKEND="Slurm"
export EASYBUILD_MODULE_SYNTAX="Lua"  # or "Tcl" to match your config file
export EASYBUILD_MODULES_TOOL="Lmod"

# Shared source path (read by all, written to by both test and production)
export EASYBUILD_SOURCEPATH="/apps/kir/eb/${sysname}/sources"

# User-specific paths
USER=${USER:-$(whoami)}

if [[ "${USER}" == "kir-software" ]]; then
    # Production environment (admin account)
    echo "Setting up PRODUCTION environment for ${USER}"
    
    export EASYBUILD_PREFIX="/apps/kir/eb/${sysname}"
    export EASYBUILD_INSTALLPATH="/apps/kir/eb/${sysname}"
    export EASYBUILD_INSTALLPATH_SOFTWARE="/apps/kir/eb/${sysname}/software"
    export EASYBUILD_INSTALLPATH_MODULES="/apps/kir/eb/${sysname}/modules"
    export EASYBUILD_REPOSITORYPATH="/apps/kir/eb/${sysname}/ebfiles_repo"
    export EASYBUILD_PACKAGEPATH="${EASYBUILD_PREFIX}/packages"
    
    # Robot paths: check local customizations first, then defaults, then installed
    export EASYBUILD_ROBOT_PATHS="/apps/kir/eb/${sysname}/local:${EASYBUILD_REPOSITORYPATH}"
    
    # Build path (temporary, can be in /tmp or scratch)
    export EASYBUILD_BUILDPATH="${EASYBUILD_TMPDIR}/${USER}/easybuild/build"
    
else
    # Testing environment (regular user)
    echo "Setting up TESTING environment for ${USER}"
    
    export EASYBUILD_PREFIX="${HOME}/easybuild/kir-test/${sysname}"
    export EASYBUILD_INSTALLPATH="${EASYBUILD_PREFIX}"
    export EASYBUILD_INSTALLPATH_SOFTWARE="${EASYBUILD_PREFIX}/software"
    export EASYBUILD_INSTALLPATH_MODULES="${EASYBUILD_PREFIX}/modules"
    export EASYBUILD_REPOSITORYPATH="${EASYBUILD_PREFIX}/ebfiles_repo"
    export EASYBUILD_PACKAGEPATH="${EASYBUILD_PREFIX}/packages"
    
    # Prepend user's writable path to source path
    export EASYBUILD_SOURCEPATH="${EASYBUILD_PREFIX}/sources:${EASYBUILD_SOURCEPATH}"
    
    # Robot paths: check user's local first, then production installs, then defaults
    export EASYBUILD_ROBOT_PATHS="${EASYBUILD_PREFIX}/local:/apps/kir/eb/${sysname}/ebfiles_repo"
    
    # Build path in user's temp space
    export EASYBUILD_BUILDPATH="${EASYBUILD_TMPDIR}/${USER}/easybuild/build"
    
    # Create necessary directories
    mkdir -p "${EASYBUILD_INSTALLPATH_MODULES}/all"
    mkdir -p "${EASYBUILD_PREFIX}/sources"
    mkdir -p "${EASYBUILD_PREFIX}/local"
    mkdir -p "${EASYBUILD_BUILDPATH}"
    
    # Add user's modules to MODULEPATH if not already there
    if [[ ":${MODULEPATH}:" != *":${EASYBUILD_INSTALLPATH_MODULES}/all:"* ]]; then
        export MODULEPATH="${EASYBUILD_INSTALLPATH_MODULES}/all:${MODULEPATH}"
        printf "Added your test modules to MODULEPATH: %s/all\n" "${EASYBUILD_INSTALLPATH_MODULES}"
    fi
fi

# Display configuration
echo "================================"
echo "EasyBuild Environment Configured"
echo "================================"
echo "User: ${USER}"
echo "Architecture: ${sysname}"
echo "Install path: ${EASYBUILD_INSTALLPATH}"
echo "Module path: ${EASYBUILD_INSTALLPATH_MODULES}/all"
echo "Source path: ${EASYBUILD_SOURCEPATH}"
echo "Build path: ${EASYBUILD_BUILDPATH}"
echo "Repository: ${EASYBUILD_REPOSITORYPATH}"
echo "================================"

# Optional: verify configuration
# eb --show-config
