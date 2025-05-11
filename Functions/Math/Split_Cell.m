function [sub_longitude, sub_latitude, sub_depth, lon_sub_interval, lat_sub_interval, thick_sub_interval]...
    = Split_Cell(longitude, latitude, depth, lon_interval, lat_interval, thick_internal, size_subcell, surface_radius)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Split_Cell.m
% Description     : Split grid cell into smaller cells
% probability
%
% Adapted from    : miniVox() by Scott A. Wipperfurth
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - longitude             (degree)    : Longitude of the original cell
%   - latitude              (degree)    : Latitude of the original cell
%   - lon_interval          (degree)    : Longitude gap of the original cell
%   - lat_interval          (degree)    : Latitude gap of the original cell
%   - thick_internal        (m)         : Thickness of the original cell
%   - size_subcell          (m)         : Size of the subdivided cells
%   - surface_radius        (m)         : Surface radius
%
% Output Parameters:
%   - sub_longitude         (degree)    : Longitudes of the subdivided cells
%   - sub_latitude          (degree)    : Latitudes of the subdivided cells
%   - sub_depth             (m)         : Depths of the subdivided cells
%   - lon_sub_interval      (degree)    : Longitude gaps of the subdivided cells
%   - lat_sub_interval      (degree)    : Latitude gaps of the subdivided cells
%   - thick_sub_interval    (m)         : Thickness of the subdivided cells
%
% Creation Date   : 2025-03-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

radius = surface_radius - depth; % Unit: m %
% ~~~~~~~~~~~~~~~~~~~~~~~~~ Longitude ~~~~~~~~~~~~~~~~~~~~~~~~~ %
arc = pi/180;
x = sqrt(cos(latitude * arc) * cos(latitude * arc) * sin(lon_interval * arc /2) .^2);
length = 2 * radius * x; % Unit: m %
lon_sub_interval = lon_interval / round(length / size_subcell); 
% Compute the new logitude interval of subcell %
sub_longitude = longitude - (lon_interval / 2) + (lon_sub_interval / 2) : lon_sub_interval : longitude + (lon_interval / 2) - (lon_sub_interval/2); 
% Generate new longitudes of the center of subcells%
clear x length;
% ~~~~~~~~~~~~~~~~~~~~~~~~~ Latitude ~~~~~~~~~~~~~~~~~~~~~~~~~ %
length = radius * lat_interval * arc;
lat_sub_interval = lat_interval / round(length / size_subcell);
sub_latitude = latitude - (lat_interval / 2) + (lat_sub_interval / 2) : lat_sub_interval : latitude + (lat_interval / 2) - (lat_sub_interval / 2);
% Clear length;
% ~~~~~~~~~~~~~~~~~~~~~~~~~ Depth ~~~~~~~~~~~~~~~~~~~~~~~~~ %
    if thick_internal > 1.3333 * size_subcell
        thick_sub_interval = thick_internal ./ ceil(thick_internal ./ size_subcell);
        sub_depth = depth - (thick_internal/2) + (thick_sub_interval / 2): thick_sub_interval: depth + (thick_internal / 2) - (thick_sub_interval / 2);
    else
        sub_depth = depth;
        thick_sub_interval = thick_internal;
    end
% ~~~~~~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~~~~~~ %
[sub_longitude, sub_latitude, sub_depth] = meshgrid(sub_longitude, sub_latitude, sub_depth);
sub_longitude = sub_longitude(:);
sub_latitude = sub_latitude(:);
sub_depth = sub_depth(:);

end