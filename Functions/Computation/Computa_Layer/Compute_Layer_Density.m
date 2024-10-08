function Computation = Compute_Layer_Density(Geology, Computation, Name_Layer)
%%% 根据Name_Layer拿到对应的数据
layer_data = Geology.Lithosphere.Model.Data.(Name_Layer);
cor = Geology.Lithosphere.Model.Correlation.(Name_Layer).Vp;
%%% 开始计算
uncertainty = 0.05;
parfor ii1 = 1 : length(Geology.Lithosphere.Model.GeoPhys.latlon)
    mean = layer_data.rho(ii1);
    error = uncertainty * mean;
    rho(ii1, :) = Generate_Random_Normal(mean, error, 0, cor);
end
%%% 小于零的项归零
rho(rho < 0) = 0;
Computation.Lithosphere.(Name_Layer).Density = rho;
end