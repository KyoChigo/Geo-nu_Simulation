function Computation = Compute_Layer_Abundance(Physics, Geology, Computation, Name_Layer)
%%% 这个函数可以给出U、Th和K的丰度
%%% 拿到需要用到的数据
layer_data = Geology.Lithosphere.Model.Abundance.(Name_Layer);
cor_abun = Geology.Lithosphere.Model.Correlation.(Name_Layer).Abundance;
deepcrust = Computation.Run_Info.Method.Deep_Crust;
mean_U = layer_data.U(:, 1);
mean_Th = layer_data.Th(:, 1);
mean_K = layer_data.K(:, 1);
error_U = layer_data.U(:, 2);
error_Th = layer_data.Th(:, 2);
error_K = layer_data.K(:, 2);
len = length(Geology.Lithosphere.Model.GeoPhys.latlon);
U238_mass_ratio = Physics.Elements.Abundance.Mass.U238;
U235_mass_ratio = Physics.Elements.Abundance.Mass.U235;
K40_mass_ratio = Physics.Elements.Abundance.Mass.K40;
%%% MC or LC
if strcmp(Name_Layer, 'MC') || strcmp(Name_Layer, 'LC')
    parfor ii1 = 1 : len
        [temp_U, temp_Th, temp_K] = Compute_Abundance(ii1, Physics, Geology, Computation, Name_Layer, deepcrust);
        abundance_U(ii1, :) = temp_U;
        abundance_Th(ii1, :) = temp_Th;
        abundance_K(ii1, :) = temp_K;
    end
%%% 其他layer
else
    parfor ii1 = 1 : len
        abundance_U(ii1, :) = Generate_Random_Normal(mean_U(ii1), error_U(ii1), 0, cor_abun);
        abundance_Th(ii1, :) = Generate_Random_Normal(mean_Th(ii1), error_Th(ii1), 0, cor_abun);
        abundance_K(ii1, :) = Generate_Random_Normal(mean_K(ii1), error_K(ii1), 0, cor_abun);
    end
end
%%% 小于零的项置零
abundance_U(abundance_U < 0 ) = 0;
abundance_Th(abundance_Th < 0) = 0;
abundance_K(abundance_K < 0) = 0;
%%% 记录结果
Computation.Lithosphere.(Name_Layer).Abundance.U = abundance_U;
Computation.Lithosphere.(Name_Layer).Abundance.U238 = abundance_U .* U238_mass_ratio;
Computation.Lithosphere.(Name_Layer).Abundance.U235 = abundance_U .* U235_mass_ratio;
Computation.Lithosphere.(Name_Layer).Abundance.Th232 = abundance_Th;
Computation.Lithosphere.(Name_Layer).Abundance.K = abundance_K;
Computation.Lithosphere.(Name_Layer).Abundance.K40 = abundance_K .* K40_mass_ratio;
end