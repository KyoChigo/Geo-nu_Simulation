function [distance] = Compute_Distance(lon_array, lat_array, surface_radius_array, detector)
detector_lon = detector.Longitude{1};
detector_lat = detector.Latitude{1};
detector_radius = detector.Radius;
detector_xyz = Convert_XYZ_Coordinate(detector_lon, detector_lat, detector_radius);

cells_xyz = zeros(length(lon_array), 3);
distance = zeros(length(lon_array), 1);
for i = 1 : length(lon_array)
    cells_xyz(i, :) = Convert_XYZ_Coordinate(lon_array(i), lat_array(i), surface_radius_array(i));
    distance(i, 1) = sqrt((detector_xyz(1, 1) - cells_xyz(i, 1))^2 + (detector_xyz(1, 2) - cells_xyz(i, 2))^2 + (detector_xyz(1, 3) - cells_xyz(i, 3))^2);
    % Unit: m
end
end