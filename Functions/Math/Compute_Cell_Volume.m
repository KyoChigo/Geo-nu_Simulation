function output_array = Compute_Cell_Volume(lon_left_array, lon_right_array, lat_bot_array, lat_top_array, radius_min_array, radius_max_array)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Cell_Volume.m
% Description     : Compute the volume of the cell
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - lon_left_array     : Longitudes that are smaller than the center's
%   - lon_right_array    : Longitudes that are larger than the center's
%   - lat_bot_array      : Latitudes that are smaller than the center's
%   - lat_top_array      : Latitudes that are bigger than the center's
%   - radius_min_array   : Radius that are smaller than the center's
%   - radius_max_array   : Radius that are bigger than the center's
%
% Output Parameters:
%   - output_array (m^3) : Volume
%
% Physical Units:
%   - longitude          : degree
%   - latitude           : degree
%   - radius             : m
%   - area               : m^2
%   - volume             : m^3
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

area_array = Compute_Cell_Area(lon_left_array, lon_right_array, lat_bot_array, lat_top_array, 1);

output_array = 1/3 .* (radius_max_array .^3 - radius_min_array .^ 3) .* area_array;

end