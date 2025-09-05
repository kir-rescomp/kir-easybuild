# EasyBuild at KRI 

## Overview
- KIR Research Computing uses Easybuild to provide  SS packages to our researchers
    - [EasyBuild](https://easybuild.io/)  is a software build and installation framework that allows you to manage (scientific) software on High Performance Computing (HPC) systems in an efficient way.
- Researchers can load multiple versions of any software via Environment modules (LMOD)
- All software is built to offer high reproducibilit


## Current setup

```bash

sudo -u kir-software -s 
module purge 
module load EasyBuild

#ebskl alias is set up in ~/.bashrc with the right configuration to build software for Skylake compatible nodes. 


# Load the latest easyconfigs from Github: 

cd ~/src/easybuild-easyconfigs && git pull 

# To Search for available easyconfigs:

ebskl -S <search_term>

# To build software and modules

ebskl -r --parallel=4 easyconfig.eb
```