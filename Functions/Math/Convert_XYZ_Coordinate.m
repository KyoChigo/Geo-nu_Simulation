function [output] = Convert_XYZ_Coordinate(lon, lat, radius)

% longitude (degree)
% latitude (degree)
% radius (metter);

% Positive z-axis goes through North pole
% Positive x-axis goes through point (longitude = 0, latitude = 0)
% Positive y-axis goes through point (longitude = 90, latitude = 0)

% x = radius * cos(latitude) * cos(longitude);
% y = radius * cos(latitude) * sin(longitude);
% z = radius * sin(latitude)

x = radius .* cos(lat * pi/180) * cos(lon * pi/180);
y = radius .* cos(lat * pi/180) * sin(lon * pi/180);
z = radius .* sin(lat * pi/180);

output = [x y z];

