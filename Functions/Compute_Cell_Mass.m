function mass = Compute_Cell_Mass(surface_radius, depth, thickness, density, lon_left, lon_right, lat_bottom, lat_top)
%%%%%%%%%%%%%%%%%%%%%%
% Unit list
% depth: m; the depth of center of cell
% thickness: m
% density: kg/m^3
% longitude: degree
% latitude: degree
% radius: m
% area: m^2
%%%%%%%%%%%%%%%%%%%%%%
radius_max = surface_radius - depth + 0.5 * thickness;
radius_min = surface_radius - depth - 0.5 * thickness;

volume = Compute_Cell_Volume(lon_left, lon_right, lat_bottom, lat_top, radius_min, radius_max);

mass = density * volume;