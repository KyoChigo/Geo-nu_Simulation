function Near_Field = Find_Near_Field_Cells(lithosphere, detector, Near_Field, calcFlux)

if (calcFlux == 1)
GeoPys = Get_GeoPhys(lithosphere);
x = knnsearch([GeoPys.latlon(:, 1), GeoPys.latlon(:, 2)], [detector.Data{1, 1}, detector.Data{1, 2}]);
% knnsearch() will find the index of cell which is most clost to detector
detector.Data{1, 3} = GeoPys.r(x) - detector.Data{1, 3};% Get radius of detector
end
clear x

if Near_Field.Method == "Traditional"
    center = detector.Data{1, 6};
    longitude_array = center(1) + 0.5: 1 : center(1) - 0.5 + 6;
    latitude_array = center(2) + 0.5: 1 : center(2) - 0.5 + 4;
    i = 1;
    for i_lon = 1 : length(longitude_array)
        for i_lat = 1 : length(latitude_array)
            Near_Field.Lonlat(i, 1) = longitude_array(i_lon);
            Near_Field.Lonlat(i, 2) = latitude_array(i_lat);
            i = i + 1;
        end
    end
    clear center i i_lon i_lat longitude_array latitude_array ;
    Near_Field.Index = knnsearch(GeoPys. latlon, Near_Field.Lonlat);
else
    distance = Compute_Distance(GeoPys.latlon(:, 1), GeoPys.latlon(:, 2), detector, GeoPys.r, 0);
    distance_sort = sort(distance);
    Near_Field.Index = knnsearch(distance, distance_sort(1:24));
    clear distance distance_sort
end

Near_Field.Logic = ismember(GeoPys.latlon, GeoPys.latlon(Near_Field.Index, :), 'rows'); % Assign local cells in all cells

