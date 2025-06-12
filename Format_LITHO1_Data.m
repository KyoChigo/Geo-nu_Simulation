load("./Input_Files/LithosphereModels/LITHO1_Data.mat");
% % ~~~~~~~~~~~~~~~~~~~~ LITHO1 ~~~~~~~~~~~~~~~~~~~~ % %
% --- lonlat --- %
lonlat = Litho1.latlon;
Litho1 = rmfield(Litho1, 'latlon');
Litho1.lonlat = lonlat;
% --- type --- %
type = Litho1.type;
Litho1.type = type(:, 3);
clear lonlat type;
% % ~~~~~~~~~~~~~~~~~~~~ Others ~~~~~~~~~~~~~~~~~~~~ % %
clear astheno;