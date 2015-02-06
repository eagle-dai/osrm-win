setlocal
set PATH=%CD%\libs\bin;%CD%\ruby\bin;%CD%\osrm-backend\build;%PATH%
echo disk=%CD%\stxxl,1000,wincall > test/stxxl.txt
set OSRM_TIMEOUT=200
set STXXLCFG=stxxl.txt
cd osrm-backend 
cucumber
cd ..


