function [distance] = Compute_Distance(lon_array, lat_array, surface_radius, depth, detector)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Distance.m
% Description     : Compute the distance between the grid cell and detector
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - lon_array         : Longitudes of the cells
%   - lat_array         : Latitudes of the cells
%   - surface_radius    : Surface radius
%   - depth             : Depth of the cells
%   - detector          : Detector information
%
% Output Parameters:
%   - distance (m)      : Distance
%
% Physical Units:
%   - longitude         : degree
%   - latitude          : degree
%   - radius            : m
%   - distance          : m
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

detector_lon = detector.Longitude;
detector_lat = detector.Latitude;
detector_radius = detector.Radius;
detector_xyz = Convert_XYZ_Coordinate(detector_lon, detector_lat, detector_radius);

cells_xyz = zeros(length(lon_array), 3);
distance = zeros(length(lon_array), 1);
    for i = 1 : length(lon_array)
        radius = surface_radius - depth(i);
        cells_xyz(i, :) = Convert_XYZ_Coordinate(lon_array(i), lat_array(i), radius);
        distance(i, 1) = sqrt((detector_xyz(1, 1) - cells_xyz(i, 1)) .^2 + (detector_xyz(1, 2) - cells_xyz(i, 2)) .^2 + (detector_xyz(1, 3) - cells_xyz(i, 3)) .^2);
        % Unit: m %
    end

end