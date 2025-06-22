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
clear moho;
% --- rho --- %
rho = [lonlat, water.rho, ice.rho, s1.rho, s2.rho, s3.rho, UC.rho, MC.rho, LC.rho, LM.rho];
ECM1.rho = rho;
clear rho;
% --- Vp --- %
Vp = [lonlat, water.Vp, ice.Vp, s1.Vp, s2.Vp, s3.Vp, UC.Vp, MC.Vp, LC.Vp, LM.Vp];
ECM1.Vp = Vp;
clear Vp;
clear lonlat;
% % ~~~~~~~~~~~~~~~~~~~~ Others ~~~~~~~~~~~~~~~~~~~~ % %
clear astheno;
