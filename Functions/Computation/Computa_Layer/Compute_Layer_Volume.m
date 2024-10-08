function Computation = Compute_Layer_Volume(Geology, Computation, Name_Layer)
%%% 拿到需要用的数据
surface_radius = Geology.Lithosphere.Model.GeoPhys.r;
layer_data = Computation.Lithosphere.(Name_Layer);
%%% 开始计算体积
longitude_left = layer_data.LatLon(:, 1) - 0.5;
longitude_right = layer_data.LatLon(:, 1) + 0.5;
latitude_bottom = layer_data.LatLon(:, 2) - 0.5;
latitude_top = layer_data.LatLon(:, 2) + 0.5;
depth = layer_data.Depth;
thickness = layer_data.Thickness;
radius_min = surface_radius - depth - 0.5 .* thickness;
radius_max = surface_radius - depth + 0.5 .* thickness;
volume = Compute_Cell_Volume(longitude_left, longitude_right, latitude_bottom, latitude_top, radius_min, radius_max);
%%% 记录结果
Computation.Lithosphere.(Name_Layer).Volume = volume;
end