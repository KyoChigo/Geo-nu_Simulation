addpath("Functions\Math\");
%%%%%%%%%% Test-Single %%%%%%%%%%%%%%%%%%%%%%
% radius = [5];
% lat_bot = [1];
% lat_top = [2];
% lon_left = [1];
% lon_right = [2];
% res = Compute_Cell_Area(lon_left, lon_right, lat_bot, lat_top, radius);
% res
% arc = pi/180;
% 5^2 * 1 * arc * (sin(2 * arc) - sin(1 * arc))
%%%%%%%%%% Test-Array %%%%%%%%%%%%%%%%%%%%%%%
radius = [1; 2];
lat_bot = [1; 2];
lat_top = [2; 3];
lon_left = [1; 2];
lon_right = [2; 3];
res = Compute_Cell_Area(lon_left, lon_right, lat_bot, lat_top, 1);
res