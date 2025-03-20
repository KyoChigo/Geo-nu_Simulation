function [sub_longitude, sub_latitude, sub_depth, lon_sub_interval, lat_sub_interval, thick_sub_interval] = Split_Cell(longitude, latitude, depth, lon_interval, lat_interval, thick_internal, size_subcell, surface_radius)
% ~~~~~~~~~~~~~~~~~~~ Input ~~~~~~~~~~~~~~~~~~~
% longitude         (deg): longitude of the center of the cell
% latitude          (deg): latitude of the center of the cell
% depth             (m): depth of the center of the cell
% lon_interval      (deg): longitude size of the cell
% lat_interval      (deg): latitude size of the cell
% thick_interval    (m): thickness of the cell
% size_subcell      (m): the size to subcells
% surface_radius    (m): the radius of the earth
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% ~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~
% sub_longitude     (deg): longitude of the center of the subcell
% sub_latitude      (deg): latitude of the center of the subcell
% sub_depth         (m): depth of the center of the subcell
% lon_sub_interval  (deg): longitude size of the subcell
% lat_sub_interval  (deg): latitude size of the subcell
% thick_sub_interval(m): thickness of the subcell
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

radius = surface_radius - depth; % Unit: m
% ~~~~~~~~~~~~~~~~~~~~~~~~~ Longitude ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arc = pi/180;
x = sqrt(cos(latitude * arc) * cos(latitude * arc) * sin(lon_interval * arc /2) .^2);
length = 2 * radius * x; % Unit: m
lon_sub_interval = lon_interval / round(length / size_subcell); % Compute the new logitude interval of subcell
sub_longitude = longitude - (lon_interval / 2) + (lon_sub_interval / 2) : lon_sub_interval : longitude + (lon_interval / 2) - (lon_sub_interval/2); 
% Generate new longitudes of the center of subcells
clear x length;
% ~~~~~~~~~~~~~~~~~~~~~~~~~ Latitude ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
length = radius * lat_interval * arc;
lat_sub_interval = lat_interval / round(length / size_subcell);
sub_latitude = latitude - (lat_interval / 2) + (lat_sub_interval / 2) : lat_sub_interval : latitude + (lat_interval / 2) - (lat_sub_interval / 2);
% clear length;
% ~~~~~~~~~~~~~~~~~~~~~~~~~ Depth ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    if thick_internal > 1.3333 * size_subcell
        thick_sub_interval = thick_internal ./ ceil(thick_internal ./ size_subcell);
        sub_depth = depth - (thick_internal/2) + (thick_sub_interval / 2): thick_sub_interval: depth + (thick_internal / 2) - (thick_sub_interval / 2);
    else
        sub_depth = depth;
        thick_sub_interval = thick_internal;
    end
% ~~~~~~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[sub_longitude, sub_latitude, sub_depth] = meshgrid(sub_longitude, sub_latitude, sub_depth);
sub_longitude = sub_longitude(:);
sub_latitude = sub_latitude(:);
sub_depth = sub_depth(:);

end