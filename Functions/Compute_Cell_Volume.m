function volume = Compute_Cell_Volume(lon_left, lon_right, lat_bottom, lat_top, radius_min, radius_max)
%%%%%%%%%%%%%%%%%%%%%%
% Unit list
% longitude: degree
% latitude: degree
% radius: m
% valume: m^3
%%%%%%%%%%%%%%%%%%%%%%

area = Compute_Cell_Area(lon_left, lon_right, lat_bottom, lat_top, 1);

volume = area * (radius_max^3 - radius_min^3)/ 3;
