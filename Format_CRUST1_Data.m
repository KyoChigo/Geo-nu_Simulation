load("./Input_Files/LithosphereModels/CRUST1_Data.mat");
% % ~~~~~~~~~~~~~~~~~~~~ Crust1 ~~~~~~~~~~~~~~~~~~~~ % %
% --- lonlat --- %
Crust1.lonlat = Crust1.latlon;
Crust1 = rmfield(Crust1, 'latlon');
lonlat = Crust1.lonlat;
% --- type --- %
type = Crust1.type;
Crust1.type = type(:, 3);
% --- thick --- %
thick = Crust1.thick;
Crust1.thick = [lonlat, thick];
clear lonlat type thick;
% % ~~~~~~~~~~~~~~~~~~~~ Others ~~~~~~~~~~~~~~~~~~~~ % %
clear latlon;
clear latlon_crust1;
clear ans;
clear x;