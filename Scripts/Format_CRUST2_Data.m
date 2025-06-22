load("./Input_Files/LithosphereModels/CRUST2_Data.mat");
% % ~~~~~~~~~~~~~~~~~~~~ Others ~~~~~~~~~~~~~~~~~~~~ % %
% --- s3 --- %
s3.depth = s3.depth';
% --- s1->s3 & s3->s1 --- %
% s1_temp = s1;
% s1 = s3;
% s3 = s1_temp;
% clear s1_temp;
clear ans idx oceanic;
% % ~~~~~~~~~~~~~~~~~~~~ Crust2 ~~~~~~~~~~~~~~~~~~~~ % %
% --- lonlat --- %
Crust2.lonlat = Crust2.latlon;
Crust2 = rmfield(Crust2, 'latlon');
lonlat = Crust2.lonlat;
% --- rho --- %
rho = [lonlat, water.rho, ice.rho, s1.rho, s2.rho, s3.rho, UC.rho, MC.rho, LC.rho, LM.rho];
Crust2.rho = rho;
clear rho;
% --- Vp --- %
Vp = [lonlat, water.Vp, ice.Vp, s1.Vp, s2.Vp, s3.Vp, UC.Vp, MC.Vp, LC.Vp, LM.Vp];
Crust2.Vp = Vp;
clear lonlat Vp;

