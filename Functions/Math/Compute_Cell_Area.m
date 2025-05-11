function output_array = Compute_Cell_Area(lon_left_array, lon_right_array, lat_bot_array, lat_top_array, radius_array)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Cell_Area.m
% Description     : Compute the area of the cell
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
%   - radius_array       : Radius
%
% Output Parameters:
%   - output_array (m^2) : Area
%
% Physical Units:
%   - longitude          : degree
%   - latitude           : degree
%   - radius             : m
%   - area               : m^2
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arc = pi / 180;
if isequal(radius_array, 1) % Used in Compute_Cell_Volume() %
    output_array = (lon_right_array - lon_left_array) .* arc .* ( sin( lat_top_array .* arc) - sin( lat_bot_array .* arc));
else
    output_array = radius_array.^2 .* (lon_right_array - lon_left_array) .* arc .* ( sin( lat_top_array .* arc) - sin( lat_bot_array .* arc));
end

end