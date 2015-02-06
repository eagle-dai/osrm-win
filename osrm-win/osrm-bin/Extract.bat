cd data
set path=..
for /f %%a in ('dir /B /S *.osm.pbf') do osrm-extract.exe %%a
for /f %%a in ('dir /B /S *.osm') do osrm-extract.exe %%a
echo %TIME%
for /f %%a in ('dir /B /S *.osrm') do osrm-prepare %%a
echo %TIME%

cd ..
