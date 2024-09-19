function area = Compute_Cell_Area(lon_left, lon_right, lat_bottom, lat_top, radius);
%%%%%%%%%%%%%%%%%%%%%%
% Unit list
% longitude: degree
% latitude: degree
% radius: m
% area: m^2
%%%%%%%%%%%%%%%%%%%%%%

arc = pi / 180;

area = radius^2 * (lon_right - lon_left) * arc * ( sin(lat_top * arc) -  sin(lat_bottom * arc));