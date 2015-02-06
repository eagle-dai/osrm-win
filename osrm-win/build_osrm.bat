set VARIANT=Release
call "%VS120COMNTOOLS%\..\..\VC\vcvarsall.bat" x86_amd64
set PREFIX=%CD%/libs
set BOOST_ROOT=%CD%/boost_min
set TBB_INSTALL_DIR=%CD%/tbb
set TBB_ARCH_PLATFORM=intel64/vc12

set OSRM_BIN=%CD%\osrm-bin
if not exist osrm-bin (mkdir osrm-bin)
rem if not exist osrm-backend (git clone -b develop https://github.com/Project-OSRM/osrm-backend osrm-backend)
cd ..\osrm-backend

if not exist build (mkdir build)
cd build
cmake .. -G "Visual Studio 12 Win64" -DBoost_ADDITIONAL_VERSIONS=1.57 -DCMAKE_BUILD_TYPE=%VARIANT% -DCMAKE_INSTALL_PREFIX=%PREFIX% -DBOOST_ROOT=%BOOST_ROOT% -DBoost_USE_STATIC_LIBS=ON -T CTP_Nov2013
msbuild /p:Configuration=%Variant% /clp:Verbosity=normal /nologo OSRM.sln /flp1:logfile=build_errors.txt;errorsonly /flp2:logfile=build_warnings.txt;warningsonly
copy /y %VARIANT%\*.pdb .
copy /y %VARIANT%\*.exe .

copy *.exe %OSRM_BIN%
if "%VARIANT%"=="Debug" (copy *.pdb %OSRM_BIN%)
cd ..\profiles
echo disk=c:\temp\stxxl,10000,wincall > .stxxl.txt
copy *.* %OSRM_BIN%
copy car.lua %OSRM_BIN%\profile.lua
xcopy /y lib %OSRM_BIN%\lib\ 
copy %PREFIX:/=\%\bin\*.dll %OSRM_BIN%

cd %OSRM_BIN%
pause

