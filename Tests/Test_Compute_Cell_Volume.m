addpath("Functions\Math\")

%%%%%%%%%% Test-Single %%%%%%%%%%%%%%%%%%%%%%
% radius_min = [1];
% radius_max = [2];
% lat_bot = [1];
% lat_top = [2];
% lon_left = [1];
% lon_right = [2];
% res = Compute_Cell_Volume(lon_left, lon_right, lat_bot, lat_top, radius_min, radius_max);
% res
% arc = pi/180;
% 1/3 * 7 * 1 * arc * (sin(2 * arc) - sin(1 * arc))
%%%%%%%%%% Test-Array %%%%%%%%%%%%%%%%%%%%%%
% radius_min = [1; 2];
% radius_max = [2; 3];
% lat_bot = [1; 2];
% lat_top = [2; 3];
% lon_left = [1; 2];
% lon_right = [2; 3];
% res = Compute_Cell_Volume(lon_left, lon_right, lat_bot, lat_top, radius_min, radius_max);
% res
% arc = pi/180;
% 1/3 * (2^3 - 1^3) * 1 * arc * (sin(2 * arc) - sin(1 * arc))
% 1/3 * (3^3 - 2^3) * 1 * arc * (sin(3 * arc) - sin(2 * arc))