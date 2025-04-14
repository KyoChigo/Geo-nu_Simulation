function [DISTANCE] = APPLICATION_Compute_Distance(index, detector, array_for_radius, array_for_mass)
% ~~~~~~~~~~~~~~~~~~~~ Compute Distance ~~~~~~~~~~~~~~~~~~~~ %
lon_center = array_for_mass(2);
lat_center = array_for_mass(3);
depth_center = array_for_radius(3);
surface_radius = array_for_radius(4);
DISTANCE = Compute_Distance(lon_center, lat_center, surface_radius, depth_center, detector); % Unit: m %

end