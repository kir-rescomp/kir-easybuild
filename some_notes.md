```bash
$ module show EasyBuild
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   /agr/persist/apps/eri_rocky8/modules/all/EasyBuild/4.9.2.lua:
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
help([[
Description
===========
EasyBuild is a software build and installation framework
 written in Python that allows you to install software in a structured,
 repeatable and robust way.


More information
================
 - Homepage: https://easybuilders.github.io/easybuild
]])
whatis("Description: EasyBuild is a software build and installation framework
 written in Python that allows you to install software in a structured,
 repeatable and robust way.")
whatis("Homepage: https://easybuilders.github.io/easybuild")
whatis("URL: https://easybuilders.github.io/easybuild")
conflict("EasyBuild")
prepend_path("CMAKE_PREFIX_PATH","/agr/persist/apps/eri_rocky8/software/EasyBuild/4.9.2")
prepend_path("PATH","/agr/persist/apps/eri_rocky8/software/EasyBuild/4.9.2/bin")
setenv("EBROOTEASYBUILD","/agr/persist/apps/eri_rocky8/software/EasyBuild/4.9.2")
setenv("EBVERSIONEASYBUILD","4.9.2")
setenv("EBDEVELEASYBUILD","/agr/persist/apps/eri_rocky8/software/EasyBuild/4.9.2/easybuild/EasyBuild-4.9.2-easybuild-devel")
prepend_path("PYTHONPATH","/agr/persist/apps/eri_rocky8/software/EasyBuild/4.9.2/lib/python3.6/site-packages")
setenv("EB_INSTALLPYTHON","/bin/python3")
```

```bash
$ cat /agr/persist/apps/eri_rocky8/modules/all/EasyBuild/4.9.2.lua
help([==[

Description
===========
EasyBuild is a software build and installation framework
 written in Python that allows you to install software in a structured,
 repeatable and robust way.


More information
================
 - Homepage: https://easybuilders.github.io/easybuild
]==])

whatis([==[Description: EasyBuild is a software build and installation framework
 written in Python that allows you to install software in a structured,
 repeatable and robust way.]==])
whatis([==[Homepage: https://easybuilders.github.io/easybuild]==])
whatis([==[URL: https://easybuilders.github.io/easybuild]==])

local root = "/agr/persist/apps/eri_rocky8/software/EasyBuild/4.9.2"

conflict("EasyBuild")

prepend_path("CMAKE_PREFIX_PATH", root)
prepend_path("PATH", pathJoin(root, "bin"))
setenv("EBROOTEASYBUILD", root)
setenv("EBVERSIONEASYBUILD", "4.9.2")
setenv("EBDEVELEASYBUILD", pathJoin(root, "easybuild/EasyBuild-4.9.2-easybuild-devel"))

prepend_path("PYTHONPATH", pathJoin(root, "lib/python3.6/site-packages"))
setenv("EB_INSTALLPYTHON", "/bin/python3")
-- Built with EasyBuild version 4.8.1
```