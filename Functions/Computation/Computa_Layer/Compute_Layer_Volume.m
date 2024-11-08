function Computation = Compute_Layer_Volume(Geology, Computation, Name_Layer)
%%% 拿到需要用的数据
surface_radius = Geology.Lithosphere.Model.GeoPhys.r; % Unit: m
layer_data = Computation.Lithosphere.(Name_Layer);
%%% 开始计算体积
longitude_left = layer_data.LatLon(:, 1) - 0.5; % Unit: °
longitude_right = layer_data.LatLon(:, 1) + 0.5; % Unit: °
latitude_bottom = layer_data.LatLon(:, 2) - 0.5; % Unit: °
latitude_top = layer_data.LatLon(:, 2) + 0.5; % Unit: °
depth = layer_data.Depth; % Unit: m
thickness = layer_data.Thickness; % Unit: m
radius_min = surface_radius - depth - 0.5 .* thickness; % Unit: m
radius_max = surface_radius - depth + 0.5 .* thickness; % Unit: m
volume = Compute_Cell_Volume(longitude_left, longitude_right, latitude_bottom, latitude_top, radius_min, radius_max);
 % Unit: m^3
%%% 记录结果
Computation.Lithosphere.(Name_Layer).Volume = volume; % Unit: m^3
end