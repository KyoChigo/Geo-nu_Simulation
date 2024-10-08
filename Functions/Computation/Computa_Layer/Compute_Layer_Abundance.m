function Computation = Compute_Layer_Abundance(Geology, Computation, Name_Layer)
layer_data = Geology.Lithosphere.Model.Abundance.(Name_Layer);
cor_abun = Geology.Lithosphere.Model.Correlation.(Name_Layer).Abundance;
deepcrust = Computation.Run_Info.Method.Deep_Crust;
mean_U = layer_data.U(:, 1);
mean_Th = layer_data.Th(:, 1);
mean_K = layer_data.K(:, 1);
error_U = layer_data.U(:, 2);
error_Th = layer_data.Th(:, 2);
error_K = layer_data.K(:, 2);
%%% MC
if strcmp(Name_Layer, 'MC')
    mean_vp = Geology.Lithosphere.Model.Data.MC.Vp;
    error_vp = 0.03 * mean_vp;
    cor_vp = Geology.Lithosphere.Model.Correlation.MC.Vp;
    vp.layer = Generate_Random_Normal(mean_vp, error_vp, 0, cor_vp);
    temperature = Computation.Lithosphere.MC.Temperature;
    pressure = Computation.Lithosphere.MC.Pressure;
    if strcmp(deepcrust, 'Huang')
        cor_end = Geology.Lithosphere.Model.Correlation.MC.DeepCrust.End.Vp;
        vp.MC.f = Generate_Random_Normal(6.34, 0.16, 0, cor_end);
        vp.MC.m = Generate_Random_Normal(6.98, 0.20, 0, cor_end);
    %%% %%% 温度修正
        vp.f = vp.MC.f - (temperature - 20) * 4 * 1e-4;
        vp.m = vp.MC.m - (temperature - 20) * 4 * 1e-4;
    %%% %%% 计算Fel的比例
        fraction = (vp.layer - vp.m) ./ ( vp.f - vp.m);
        fraction( fraction < 0 ) = 0;
        fraction( fraction > 1 ) = 1;
    %%% %%% 计算丰度
        amphibolite = Geology.Lithosphere.Model.DeepCrust.Amphibolite;
        abundance_U = Abundance_Huang( amphibolite.Felsic.U, amphibolite.Mafic.U, fraction);
        abundance_Th = Abundance_Huang( amphibolite.Felsic.K, amphibolite.Mafic.U, fraction);
        abundance_K = Abundance_Huang( amphibolite.Felsic.K, amphibolite.Mafic.U, fraction);
    elseif strcmp(deepcrust, 'Bivariate')
    else
        disp('[Compute_Layer_Abundance] Wrong Deep Crust Method.');
    end
%%% LC
elseif strcmp(Name_Layer, 'LC')
    temperature = Computation.Lithosphere.LC.Temperature;
    pressure = Computation.Lithosphere.LC.Pressure;
    if strcmp(deepcrust, 'Huang')
        cor_end = Geology.Lithosphere.Model.Correlation.LC.DeepCrust.End.Vp;
        vp.LC.f = Generate_Random_Normal(6.52, 0.19, 0, cor_end);
        vp.MC.m = Generate_Random_Normal(6.98, 0.20, 0, cor_end);
    %%% %%% 温度修正
        vp.f = vp.MC.f - (temperature - 20) * 4 * 1e-4;
        vp.m = vp.MC.m - (temperature - 20) * 4 * 1e-4;
    %%% %%% 计算Fel的比例
        fraction = (vp.layer - vp.m) ./( vp.f - vp.m);
        fraction( fraction < 0 ) = 0;
        fraction( fraction > 1 ) = 1;
    %%% %%% 计算丰度
        amphibolite = Geology.Lithosphere.Model.DeepCrust.Amphibolite;
        abundance_U = Abundance_Huang( amphibolite.Felsic.U, amphibolite.Mafic.U, fraction);
        abundance_Th = Abundance_Huang( amphibolite.Felsic.K, amphibolite.Mafic.U, fraction);
        abundance_K = Abundance_Huang( amphibolite.Felsic.K, amphibolite.Mafic.U, fraction);
    elseif strcmp(deepcrust, 'Bivariate')
    else
        disp('[Compute_Layer_Abundance] Wrong Deep Crust Method.');
    end
%%% 其他layer
else
    parfor ii1 = 1 : length(Geology.Lithosphere.Model.GeoPhys.latlon)
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
Computation.Lithosphere.(Name_Layer).Abundance.Th = abundance_Th;
% Computation.Lithosphere.(Name_Layer).Abundance.K = 
end