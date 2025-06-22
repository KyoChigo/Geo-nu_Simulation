load("./Input_Files/LithosphereModels/LITHO1_Data.mat");
% % ~~~~~~~~~~~~~~~~~~~~ Others ~~~~~~~~~~~~~~~~~~~~ % %
% --- water.vp & ice.vp --- %
temp = s1.Vp .* 0;
water.Vp = temp;
ice.Vp = temp;
clear temp;
clear astheno;
% % ~~~~~~~~~~~~~~~~~~~~ LITHO1 ~~~~~~~~~~~~~~~~~~~~ % %
% --- lonlat --- %
lonlat = Litho1.latlon;
Litho1 = rmfield(Litho1, 'latlon');
Litho1.lonlat = lonlat;
% --- type --- %
type = Litho1.type;
Litho1.type = type(:, 3);
clear type;
% --- rho --- %
rho = [lonlat, water.rho, ice.rho, s1.rho, s2.rho, s3.rho, UC.rho, MC.rho, LC.rho, LM.rho];
Litho1.rho = rho;
clear rho;
% --- Vp --- %
Vp = [lonlat, water.Vp, ice.Vp, s1.Vp, s2.Vp, s3.Vp, UC.Vp, MC.Vp, LC.Vp, LM.Vp];
Litho1.Vp = Vp;
clear Vp;
clear lonlat;