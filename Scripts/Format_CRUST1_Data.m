load("./Input_Files/LithosphereModels/CRUST1_Data.mat");
% % ~~~~~~~~~~~~~~~~~~~~ Crust1 ~~~~~~~~~~~~~~~~~~~~ % %
% --- lonlat --- %
Crust1.lonlat = Crust1.latlon;
Crust1 = rmfield(Crust1, 'latlon');
lonlat = Crust1.lonlat;
% --- type --- %
type = Crust1.type;
Crust1.type = type(:, 3);
% --- rho --- %
rho = Crust1.rho;
rho(:, 3:end) = rho(:, 3:end) * 1e3;
Crust1.rho = rho;
% --- thick --- %
Crust1 = rmfield(Crust1, 'thick');
clear lonlat type rho;
% % ~~~~~~~~~~~~~~~~~~~~ Others ~~~~~~~~~~~~~~~~~~~~ % %
% --- s1 -> s3, s3->s1 --- %
s1_temp = s1;
s1 = s3;
s3 = s1_temp;
clear s1_temp;
clear latlon;
clear latlon_crust1;
clear ans;
clear x;
clear vp;