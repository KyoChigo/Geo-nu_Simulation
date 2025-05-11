function [output] = Convert_XYZ_Coordinate(lon, lat, radius)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Convert_XYZ_Coordinate.m
% Description     : Convert to xyz position
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - lon         : Longitude
%   - lat         : Latitude
%   - radius      : Radius
%
% Output Parameters:
%   - output      : XYZ position
%
% Physical Units:
%   - longitude   : degree
%   - latitude    : degree
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Positive z-axis goes through North pole
% Positive x-axis goes through point (longitude = 0, latitude = 0)
% Positive y-axis goes through point (longitude = 90, latitude = 0)

% x = radius * cos(latitude) * cos(longitude);
% y = radius * cos(latitude) * sin(longitude);
% z = radius * sin(latitude)

x = radius * cos(lat * pi/180) * cos(lon * pi/180);
y = radius * cos(lat * pi/180) * sin(lon * pi/180);
z = radius * sin(lat * pi/180);

output = [x y z];

