# EasyBuild at KRI 

## Overview
- KIR Research Computing uses Easybuild built environment modules. 
    - [EasyBuild](https://easybuild.io/)  is a software build and installation framework that allows you to manage (scientific) software on High Performance Computing (HPC) systems in an efficient way.
- Researchers can load multiple versions of any software via Environment modules (LMOD)
- All software is built to offer high reproducibility

## Build process

* Please make sure to do a test build as "you" and run a sanity check prior to push the .eb to production repo and build it as `kir-software` user 

```mermaid
flowchart TD
    A["git clone https://github.com/kir-rescomp/kir-easybuild.git"] --> B["cd kir-easybuild && module load EasyBuild"]
    B --> C["source eb_init.sh"]
    C --> D["eb kir-easybuild/easyconfigs/NAME.eb"]
    
    classDef navyStyle fill:#000080,stroke:#000080,color:#fff
    class A,B,C,D navyStyle

    class A monospaceClass
    class B monospaceClass
    class C monospaceClass
    classDef monospaceClass font-family: monospace, monospace;
```


* Once the build and tests were done as "you", 
    - commit the .eb file to the repo
    - login as admin `sudo -u kir-software -s`
    - Change path to `/users/kir-software/kir-software/kir-easybuild`, make sure to `pull` any changes
    - `source eb_init.sh`  - This will set the correct path for admin account ( similar to your accuont but on admin side of the file system)