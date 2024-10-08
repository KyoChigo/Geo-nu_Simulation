function Computation = Compute_Layer_Depth(Geology, Computation, Name_Layer)
%%% 根据Name_Layer拿到对应的数据
layer_data = Geology.Lithosphere.Model.Data.(Name_Layer);
cor = Geology.Lithosphere.Model.Correlation.(Name_Layer).Thickness;
%%% 开始计算厚度
uncertainty = 0.12;
parfor ii1 = 1 : length(Geology.Lithosphere.Model.GeoPhys.latlon)
    mean = layer_data.depth(ii1);
    error = uncertainty * mean;
    depth(ii1, :) = Generate_Random_Normal(mean, error, 0, cor);
end
%%% 小于零的项归零
    depth(depth < 0) = 0;
    Computation.Lithosphere.(Name_Layer).Depth = depth;
end