cd data
set path=..\bin
for /f %%a in ('dir  /B /S *.osrm') do set OSM=%%a


echo Threads = 8 > server.ini
echo IP = 0.0.0.0  >> server.ini
echo Port = 5000  >> server.ini

echo hsgrData=%OSM%.hsgr >> server.ini
echo nodesData=%OSM%.nodes >> server.ini
echo edgesData=%OSM%.edges >> server.ini
echo ramIndex=%OSM%.ramIndex >> server.ini
echo fileIndex=%OSM%.fileIndex >> server.ini
echo namesData=%OSM%.names >> server.ini
rem echo timestamp=%OSM%.timestamp >> server.ini

start ../WebContent/Main.html
osrm-routed.exe
cd ..
