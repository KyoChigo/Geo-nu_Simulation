function Computation = Compute_Layer_Pressure(Computation, Name_Layer, Name_Former_Layer)
%%% 拿到需要用到的数据
rho = Computation.Lithosphere.(Name_Layer).Density;
thickness = Computation.Lithosphere.(Name_Layer).Thickness;
if strcmp(Name_Former_Layer, 'None')
    pressure_former_layer = 0 * rho; % 拿到一个全零结果。
else
    pressure_former_layer = Computation.Lithosphere.(Name_Former_Layer).Pressure;
end
%%% 计算压强
pressure_this_layer = rho .* thickness .* 9.80665 * 1e-6;
%%% 记录结果
Computation.Lithosphere.(Name_Layer).Pressure = 0.5 * pressure_this_layer + pressure_former_layer;
end