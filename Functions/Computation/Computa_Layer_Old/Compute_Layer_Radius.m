function Computation = Compute_Layer_Radius(Geology, Computation, Name_Layer)
%%% 根据Name_Layer拿到对应的数据
layer_data = Geology.Lithosphere.Model.Data.(Name_Layer);
surface_radius = Geology.Lithosphere.Model.GeoPhys.r; % Unit: m
depth = Computation.Lithosphere.(Name_Layer).Depth; % Unit: m
%%% 开始计算半径
Computation.Lithosphere.(Name_Layer).Radius = surface_radius - depth; % Unit: m
%%% 释放内存
end