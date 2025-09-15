# Set up easybuild environment for KIR staff builds
# Should be used when as own user for testing and when building as kir-software

#Parse args
sysname=skylake

# Load EB if not already. Ideally load EasyBuild/5.*

export MODULEPATH="/apps/kir/eb/${MODULE_CPU_TYPE}/modules/all:/apps/eb/${MODULE_CPU_TYPE}/modules/all:/apps/eb/dev/${MODULE_CPU_TYPE}/modules/all:/apps/eb/2022b/${MODULE_CPU_TYPE}/modules/all:/apps/eb/2023a/${MODULE_CPU_TYPE}/modules/all:/apps/eb/2020b/${MODULE_CPU_TYPE}/modules/all:/apps/eb/el7/common/modules/all"


if module list 2>&1 | grep -q 'EasyBuild';then
    printf "EasyBuild module already loaded. Continuing with currently loaded modules.\n"
else
    module purge 2> /dev/null
    module load EasyBuild
fi

# General Setting

export export EASYBUILD_CUDA_COMPUTE_CAPABILITIES="8.0.61"
export EASYBUILD_TMPDIR="${TMPDIR:=/tmp}"
export EASYBUILD_ROBOT_PATHS="/apps/kir/eb/skylake/ebfiles_repo" ## Examine our installed software rather than the easyconfig repo. Threfore, it should be pointing to ebfiles_repo directory
export EASYBUILD_SOURCEPATH="/apps/kir/eb/skylake/sources" #this should be shared by all architectures
export EASYBUILD_USE_EXISTING_MODULES=1
export EASYBUILD_ALLOW_LOADED_MODULES="EasyBuild"

# eb job configuration
export EASYBUILD_JOB_BACKEND="Slurm"
export EASYBUILD_MODULE_SYNTAX="Lua"
export EASYBUILD_MODULES_TOOL="Lmod"


#User specific

# Rearranged from eb default, installpath at the base of the tree, prefix inside it
# Note: EASYBUILD_PREFIX implicitly sets EASYBUILD_BUILDPATH,
# EASYBUILD_SOURCEPATH and EASYBUILD_INSTALLPATH unless these are overridden

if [[ ${USER:=$(whoami)} == "kir-software" ]];then
  export EASYBUILD_PREFIX="/apps/kir/eb/${sysname}"
  export EASYBUILD_INSTALLPATH="/apps/kir/eb/${sysname}"
  export EASYBUILD_INSTALLPATH_SOFTWARE="/apps/kir/eb/${sysname}/software"
  export EASYBUILD_INSTALLPATH_MODULES="/apps/kir/eb/${sysname}/modules"
  export EASYBUILD_PACKAGEPATH="${EASYBUILD_PREFIX}/packages"
else
  export EASYBUILD_PREFIX="/well/sansom/users/mat611/devel/easybuild/eb/${sysname}"
  export EASYBUILD_INSTALLPATH_MODULES="/well/sansom/users/mat611/devel/easybuild/eb/${sysname}/modules"
  export EASYBUILD_SOURCEPATH=${EASYBUILD_PREFIX}:${EASYBUILD_SOURCEPATH} #Prepend writable path to srcpath
  mkdir -p "${EASYBUILD_INSTALLPATH_MODULES}"

  if [[ ":${MODULEPATH}:" != *":${EASYBUILD_INSTALLPATH_MODULES}:"* ]];then
    printf "The modulefile destination is not currently on your modulepath. You may want to run 'module use \"%s\"'.\n" "${EASYBUILD_INSTALLPATH_MODULES}/all"
  fi
fi
