%%%%%%%%%%%%%%%%%% 定义临时变量 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
len = length(Geology.Lithosphere.Model.GeoPhys.latlon);
iteration = Geology.Iteration;
GeoPhys = Geology.Lithosphere.Model.GeoPhys;
detector = Physics.Detector;
detector.Radius = GeoPhys.r(1) - detector.Depth;
Geo_Res_U238 = Physics.Elements.Geonu_Response.U238;
Geo_Res_Th232 = Physics.Elements.Geonu_Response.Th232;
energy = Physics.Cross_Section.Energy;
p1 = Physics.Oscillation.Coefficients.p1;
p2 = Physics.Oscillation.Coefficients.p2;
p3 = Physics.Oscillation.Coefficients.p3;
m21 = Physics.Oscillation.Parameters.delta_m21_square;
% m31 = Physics.Oscillation.Parameters.delta_m31_square;
% m32 = Physics.Oscillation.Parameters.delta_m32_square;
% array_for_signal = {Geo_Res_U238, Geo_Res_Th232, energy, p1, p2, p3, m21, m31, m32};
%%%%%%%%%%% Test %%%%%%%%%%%%
m32_n = Physics.Oscillation.Parameters.delta_m32_n_square;
m32_i = Physics.Oscillation.Parameters.delta_m32_i_square;
array_for_signal = {Geo_Res_U238, Geo_Res_Th232, energy, p1, p2, p3, m21, m32_n, m32_i};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lonlat = GeoPhys.latlon; % 64800 * 2; log : lat
surface_radius = GeoPhys.r; % 64800 * 1
OC = Geology.Lithosphere.Model.Logical.OC; % 用于MC、LC、LM的丰度计算
name_model = Geology.Lithosphere.Model.Name;
name_deepcrust = Geology.Lithosphere.Model.Method.Deep_Crust;
temp_pressure = zeros(len, iteration);
total_mass = zeros(len, iteration);
mass_u = zeros(len, iteration);
mass_th = zeros(len, iteration);
signal_u = zeros(len, iteration);
signal_th = zeros(len, iteration);