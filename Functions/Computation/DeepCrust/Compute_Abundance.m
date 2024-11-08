function [abundance_U, abundance_Th, abundance_K40] = Compute_Abundance(index, Physics, Geology, Computation, Name_Layer, Name_Method)
%%% 拿到需要用的变量
mean_vp = Geology.Lithosphere.Model.Data.(Name_Layer).Vp(index);
cor_vp = Geology.Lithosphere.Model.Correlation.(Name_Layer).Vp;
temperature = Computation.Lithosphere.(Name_Layer).Temperature(index, :); % Unit: ℃
pressure = Computation.Lithosphere.(Name_Layer).Pressure(index, :); % Unit: MPa
%%% 处理
error_vp = 0.03 * mean_vp;
vp.layer = Generate_Random_Normal(mean_vp, error_vp, 0, cor_vp)'; % 操作符[']将vp.(Name_Layer).f转换成行矢量
% vp.layer就是实际的波速, v_crust
%%% Huang method
if strcmp(Name_Method, 'Huang')
%%% %%% 拿到需要用到的变量
    cor_end = Geology.Lithosphere.Model.Correlation.(Name_Layer).DeepCrust.End.Vp;
    if strcmp(Name_Layer, 'MC')
%%% %%% %%% These data can be found in Table 5 in https://agupubs.onlinelibrary.wiley.com/doi/10.1002/ggge.2012
        vp.(Name_Layer).f = Generate_Random_Normal(6.34, 0.16, 0, cor_end); % 操作符[']将vp.(Name_Layer).f转换成行矢量
        vp.(Name_Layer).m = Generate_Random_Normal(6.98, 0.20, 0, cor_end); % 操作符[']将vp.(Name_Layer).f转换成行矢量
        rock = Geology.Lithosphere.Model.DeepCrust.Amphibolite;
    elseif strcmp(Name_Layer, 'LC')
        vp.(Name_Layer).f = Generate_Random_Normal(6.52, 0.19, 0, cor_end); % 操作符[']将vp.(Name_Layer).f转换成行矢量
        vp.(Name_Layer).m = Generate_Random_Normal(7.21, 0.20, 0, cor_end); % 操作符[']将vp.(Name_Layer).f转换成行矢量
        rock = Geology.Lithosphere.Model.DeepCrust.Granulite;
    end
%%% %%% 转化成行矢量
    vp.(Name_Layer).f = vp.(Name_Layer).f'; % 临时变量
    vp.(Name_Layer).m = vp.(Name_Layer).m'; % 临时变量
%%% %%% 温度修正
    vp.f = vp.(Name_Layer).f - (temperature - 20) * 4 * 1e-4; % Unit: km/s
    vp.m = vp.(Name_Layer).m - (temperature - 20) * 4 * 1e-4; % Unit: km/s
%%% %%% 压强修正
    vp.f = vp.f + (pressure - 600) * 2 * 1e-4; % Unit: km/s
    vp.m = vp.m + (pressure - 600) * 2 * 1e-4; % Unit: km/s
%%% %%% 计算Fel的比例
    fraction = (vp.layer - vp.m) ./ ( vp.f - vp.m); % fraction指的是felsic的占比
    fraction( fraction < 0 ) = 0;
    fraction( fraction > 1 ) = 1;
%%% %%% 计算丰度
    abundance_U = Abundance_Huang( rock.Felsic.U', rock.Mafic.U', fraction); % 操作符[']将vp.(Name_Layer).f转换成行矢量
    abundance_Th = Abundance_Huang( rock.Felsic.Th', rock.Mafic.Th', fraction); % 操作符[']将vp.(Name_Layer).f转换成行矢量
    abundance_K40 = Abundance_Huang( rock.Felsic.K', rock.Mafic.K', fraction); % 操作符[']将vp.(Name_Layer).f转换成行矢量
end
%%% Bivariate method
if strcmp(Name_Method, 'Bivariate')
%%% %%% 拿到需要用到的变量
    if strcmp(Name_Layer, 'MC')
        vp = Geology.Lithosphere.Model.Data.Bivar.seis.amp.center.Vp;
        rock = Geology.Lithosphere.Model.Data.Bivar.amp.U.fit.param;
    elseif strcmp(Name_Layer, 'LC')
        vp = Geology.Lithosphere.Model.Data.Bivar.seis.gran.center.Vp;
        rock = Geology.Lithosphere.Model.Data.Bivar.gran.U.fit.param;
    end
    cor_bivar_abund = Geology.Lithosphere.Model.Correlation.(Name_Layer).DeepCrust.Bivar.Abundance;
    cor_bivar_sio2 = Geology.Lithosphere.Model.Correlation.(Name_Layer).DeepCrust.Bivar.SiO2;
    K2O = Physics.Constants.Others.K_K2O; % K在K2O中的质量分数, Unit: 1
    K40 = Physics.Elements.Abundance.Mass.K40; % K40的质量分数, Unit: 1
    wt = 0.01 * K2O * K40; % 
%%% %%% 压强与温度修正
    correction = (temperature - 20) * -4 * 1e-4 + (pressure/1e6 - 600) * 2 * 1e-4;
    center_vp = bsxfun(@plus, vp, correction);
%%% %%% 计算丰度
    abundance_U = Abundance_Bivariate(center_vp, vp.layer , rock.U.fit.param, cor_bivar_sio2, cor_bivar_abund) * 1e-6;
    abundance_Th = Abundance_Bivariate(center_vp, vp.layer, rock.Th.fit.param, cor_bivar_sio2, cor_bivar_abund) * 1e-6;
    abundance_K40 = Abundance_Bivariate(center_vp, vp.layer, rock.K2O.fit.param, cor_bivar_sio2, cor_bivar_abund) * wt;
end

end