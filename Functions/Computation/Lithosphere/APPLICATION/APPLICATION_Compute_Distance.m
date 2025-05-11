function [DISTANCE] = APPLICATION_Compute_Distance(index, detector, array_for_radius, array_for_mass)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : APPLICATION_Compute_Distance.m
% Description     : Compute distance between the grid cell and detector
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - index                 : Index of the grid cell
%   - detector              : Information of the detector
%   - array_for_radius      : Variables for radius computation
%   - array_for_mass        : Variables for mass computation
%
% Output Parameters:
%   - DISTANCE   (m)        : Distance
%
% Created On      : 2025-04-14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Compute Distance ~~~~~~~~~~~~~~~~~~~~ %
lon_center = array_for_mass(2);
lat_center = array_for_mass(3);
depth_center = array_for_radius(3);
surface_radius = array_for_radius(4);
DISTANCE = Compute_Distance(lon_center, lat_center, surface_radius, depth_center, detector); % Unit: m %

end