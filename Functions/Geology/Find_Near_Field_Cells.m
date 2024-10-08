function [Geology, Physics] = Find_Near_Field_Cells(Geology, Physics)
method = Geology.Lithosphere.Model.Method.Near_Field;
GeoPhys = Geology.Lithosphere.Model.GeoPhys;
detector = Physics.Detector;
%%% 计算Detector的半径 %%%%%%%%%%%%%%%%
index_closest = knnsearch([GeoPhys.latlon(:, 1), GeoPhys.latlon(:, 2)], [detector.Latitude{1}, detector.Longitude{1}]);
Physics.Detector.Radius = GeoPhys.r(index_closest) - detector.Depth{1}; % Unit: m
detector = Physics.Detector; % Update detector
%%% 寻找附近的cell %%%%%%%%%%%%%%%%%%
if strcmp(method, 'Traditional')
    disp("Using Traditional Method to Find Near Field Cells");
    longitude_array = detector.Longitude{1} - 0.5 - 2: 1 : detector.Longitude{1} + 0.5 + 2;
    latitude_array = detector.Latitude{1} - 0.5 - 1: 1 : detector.Latitude{1} + 0.5 + 1;
    i = 1;
    for i_lon = 1 : length(longitude_array)
        for i_lat = 1 : length(latitude_array)
            near_field.lonlat(i, 1) = longitude_array(i_lon);
            near_field.lonlat(i, 2) = latitude_array(i_lat);
            i = i + 1;
        end
    end
    near_field.index = knnsearch(GeoPhys.latlon, near_field.lonlat);
elseif strcmp(method, "Nearest")
    disp("Using Nearest Method to Find Near Field Cells");
    distance = Compute_Distance(GeoPhys.latlon(:, 1), GeoPhys.latlon(:, 2), GeoPhys.r, detector);
    distance_sort = sort(distance);
    near_field.index = knnsearch(distance, distance_sort(1: 24));
end
%%% Assign Near Field
Geology.Lithosphere.Model.Logical.Near_Field = ismember(GeoPhys.latlon, GeoPhys.latlon(near_field.index, :), 'rows');
end