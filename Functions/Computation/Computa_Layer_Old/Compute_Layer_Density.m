function Computation = Compute_Layer_Density(Geology, Computation, Name_Layer)
%%% 根据Name_Layer拿到对应的数据
layer_data = Geology.Lithosphere.Model.Data.(Name_Layer);
cor = Geology.Lithosphere.Model.Correlation.(Name_Layer).Vp;
%%% 开始计算
uncertainty = 0.05;
parfor ii1 = 1 : length(Geology.Lithosphere.Model.GeoPhys.latlon)
    mean = layer_data.rho(ii1); % Unit: g/cm^3
    error = uncertainty * mean; % Unit: g/cm^3
    rho(ii1, :) = Generate_Random_Normal(mean, error, 0, cor); % Unit: g/cm^3
end
%%% 小于零的项归零
rho(rho < 0) = 0;
Computation.Lithosphere.(Name_Layer).Density = rho; % Unit: g/cm^3
%%% 释放内存

end