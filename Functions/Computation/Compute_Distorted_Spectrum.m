function [geonu_signal_u, spectrum_u, geonu_signal_th, spectrum_th] = Compute_Geonu_Signal(energybin, standard_spectrum_u, last_spectrum_u, standard_spectrum_th, last_spectrum_th, oscillation_array, cross_section , detector, cell, flux_array)
%%%%%%%%%%%%% 计算距离
% 探测器
det_lon = detector(1);
det_lat = detector(2);
det_depth = detector(3); % Unit: m
n_proton = detector(4);
surface = detector(5);
det_radius = surface - det_depth; % Unit: m
det_xyz = Convert_XYZ_Coordinate(det_lon, det_lat, det_radius); % Unit: m
clear det_lon det_lat surface det_depth det_radius;
% Cell
cell_lon = cell{1};
cell_lat = cell{2};
cell_radius = cell{3}; % Unit: m; row vector
cell_radius = cell_radius'; % 转换成列矢量
cell_xyz = Convert_XYZ_Coordinate(cell_lon, cell_lat, cell_radius); % Unit: m; interation * 3
clear cell_lon cell_lat cell_radius;
% 距离
part1 = det_xyz(1) - cell_xyz(:, 1);
part2 = det_xyz(2) - cell_xyz(:, 2);
part3 = det_xyz(3) - cell_xyz(:, 3);
DISTANCE = sqrt(part1 .^2 + part2 .^2 + part3 .^2); % Unit: m
DISTANCE = DISTANCE'; % 转换成行矢量
clear part1 part2 part3

%%%%%%%%%%%%% Geo response
% Oscillation
delta_m21_square = oscillation_array{1};
delta_m31_square = oscillation_array{2};
delta_m32_square = oscillation_array{3};
p1 = oscillation_array{4};
p2 = oscillation_array{5};
p3 = oscillation_array{6};
%%%%%%%%%%%%%%%%% DISTANCE 和Energybin会产生一个二维表格：纵轴energy，横轴DISTANCE
DISTANCE = DISTANCE ./ 1000; % Unit: m
part1 = 1 - p1 .* sin(1.27 .* delta_m21_square .* DISTANCE ./ energybin) .^ 2;
part2 = - p2 .* sin(1.27 .* delta_m31_square .* DISTANCE ./ energybin) .^ 2;
part3 = - p3 .* sin(1.27 .* delta_m32_square .* DISTANCE ./ energybin) .^ 2;
Pee = part1 + part2 + part3;
clear delta_m12_square delta_m13_square delta_m23_square;
clear p1 p2 p3 part1 part2 part3;
% Geonu Response
DISTANCE = DISTANCE .* 1000; % Unit: km
GEONU_RESPONSE_U = 1e-4 * standard_spectrum_u .* cross_section .* Pee ./ (4 * pi .* DISTANCE .^2);
GEONU_RESPONSE_TH = 1e-4 * standard_spectrum_th .* cross_section .* Pee ./ (4 * pi .* DISTANCE .^2);
% Unit: cm^2/(m^2 MeV) = 1e-4 * 1/MeV
%%%%%%%%%%%%% 计算通量
mass = flux_array{1}; % Unit: kg
abund_u = flux_array{2};
flux_per_mass_u = flux_array{3};
abund_th = flux_array{4};
flux_per_mass_th = flux_array{5};
FLUX_U = mass .* abund_u  .* flux_per_mass_u; % Unit: 1/s; Row vector
FLUX_TH = mass .* abund_th .* flux_per_mass_th; % Unit: 1/s; Row vector
% Step 4: compute the measured geonu specture
MEASURED_SPCTRUM_U = GEONU_RESPONSE_U .* FLUX_U .* 1e32 .* 365 .* 86400; % Unit: TNU/MeV
MEASURED_SPCTRUM_TH = GEONU_RESPONSE_TH .* FLUX_TH .* 1e32 .* 365 .* 86400; % Unit: TNU/MeV
spectrum_u = MEASURED_SPCTRUM_U + last_spectrum_u;
spectrum_th = MEASURED_SPCTRUM_TH + last_spectrum_th;
% Step 5: compute the geonu signal from this cell
binwidth = energybin(2,1) - energybin(1,1);
geonu_signal_u = sum(MEASURED_SPCTRUM_U, 1) .* binwidth; % Unit: TNU; 按列求和所有行
geonu_signal_th = sum(MEASURED_SPCTRUM_TH, 1) .* binwidth;  % Unit: TNU; 按列求和所有行

end