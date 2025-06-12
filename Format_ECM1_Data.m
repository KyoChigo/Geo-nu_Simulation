load("./Input_Files/LithosphereModels/ECM1_Data.mat");
% % ~~~~~~~~~~~~~~~~~~~~ ECM1 ~~~~~~~~~~~~~~~~~~~~ % %
% --- lonlat --- %
lon = s1.lon;
lat = s1.lat;
lonlat = [lon, lat];
clear lon lat;
ECM1.lonlat = lonlat;
ECM1 = rmfield(ECM1, 'latlon');
% --- moho --- %
moho = ECM1.moho;
ECM1.moho = moho * 1e3;
clear lonlat moho;
% % ~~~~~~~~~~~~~~~~~~~~ Others ~~~~~~~~~~~~~~~~~~~~ % %
clear astheno;
