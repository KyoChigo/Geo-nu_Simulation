load("./Input_Files/LithosphereModels/CRUST2_Data.mat");
% % ~~~~~~~~~~~~~~~~~~~~ Crust2 ~~~~~~~~~~~~~~~~~~~~ % %
% --- lonlat --- %
Crust2.lonlat = Crust2.latlon;
Crust2 = rmfield(Crust2, 'latlon');
lonlat = Crust2.lonlat;
% --- rho --- %
rho = Crust2.rho;
rho(:, 3:end) = rho(:, 3:end) * 1e-3;
Crust2.rho = rho;
clear lonlat rho;
% % ~~~~~~~~~~~~~~~~~~~~ Others ~~~~~~~~~~~~~~~~~~~~ % %
s3.depth = s3.depth';

