GeoPhys = Geology.Lithosphere.Model.GeoPhys;
LAB = GeoPhys.LAB;
lonlat = GeoPhys.latlon; % 64800 * 2; log : lat
surface_radius = GeoPhys.r;
PREM = Geology.Mantle.PREM;
detector = Physics.Detector;
detector.Radius = GeoPhys.r(1) - detector.Depth;
clear GeoPhys;
Geo_Res_U238 = Physics.Elements.Geonu_Response.U238;
Geo_Res_Th232 = Physics.Elements.Geonu_Response.Th232;
energy = Physics.Cross_Section.Energy;
p1 = Physics.Oscillation.Coefficients.p1;
p2 = Physics.Oscillation.Coefficients.p2;
p3 = Physics.Oscillation.Coefficients.p3;
m21 = Physics.Oscillation.Parameters.delta_m21_square;
m31 = Physics.Oscillation.Parameters.delta_m31_square;
m32 = Physics.Oscillation.Parameters.delta_m32_square;
%%%%%%%%%%% Test %%%%%%%%%%%%
% m32_n = Physics.Oscillation.Parameters.delta_m32_n_square;
% m32_i = Physics.Oscillation.Parameters.delta_m32_i_square;
% array_for_signal = {Geo_Res_U238, Geo_Res_Th232, energy, p1, p2, p3, m21, m32_n, m32_i};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Abundance = Geology.Mantle.Abundance;
array_for_abundance = {Abundance.Depleted.U, Abundance.Depleted.Th, Abundance.Enriched.U, Abundance.Enriched.Th};
array_for_signal = {Geo_Res_U238, Geo_Res_Th232, energy, p1, p2, p3, m21, m31, m32};
clear Abundance;