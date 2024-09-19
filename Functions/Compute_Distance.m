function [distance] = Compute_Distance(longitude, latitude, detector, surface_radius, depth)

detector_lon = detector.Data{1, 1};
detector_lat = detector.Data{1, 2};
detector_radius = detector.Data{1, 3};
detector_xyz = Convert_XYZ_Coordinate(detector_lon, detector_lat, detector_radius);

cells_xyz = zeros(length(longitude), 3);
distance = zeros(length(longitude), 1);
for i = 1 : length(longitude)
    cells_xyz(i, :) = Convert_XYZ_Coordinate(longitude(i), latitude(i), surface_radius(i) - depth);
    distance(i, 1) = sqrt((detector_xyz(1, 1) - cells_xyz(i, 1))^2 + (detector_xyz(1, 2) - cells_xyz(i, 2))^2 + (detector_xyz(1, 3) - cells_xyz(i, 3))^2) ; % Unit: m
end

clear detector_lon detector_lat detector_radius detector_xyz cells_xyz
