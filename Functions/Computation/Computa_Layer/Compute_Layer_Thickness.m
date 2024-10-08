function Computation = Compute_Layer_Thickness(Geology, Computation, Name_Layer)
%%% 根据Name_Layer拿到对应的数据
layer_data = Geology.Lithosphere.Model.Data.(Name_Layer);
cor = Geology.Lithosphere.Model.Correlation.(Name_Layer).Thickness;
GeoPhys = Geology.Lithosphere.Model.GeoPhys;
litho_model_name = Geology.Lithosphere.Model.Name;
%%% 开始计算
temp = strcmp('Crust1', litho_model_name) + strcmp('Crust2', litho_model_name);
uncertainty = 0.12;
parfor ii1 = 1 : length(GeoPhys.latlon)
    if strcmp(Name_Layer, 'LM') && temp == 1
        %%% LM + Crust的计算方法
        LAB = Generate_Random_Normal(175000, 75000, 0, cor);
        Moho = Generate_Random_Normal(GeoPhys.moho(ii1), GeoPhys.moho(ii1) * uncertainty , 0, cor);
        Thickness(ii1, :) = LAB - Moho;
    else
        mean = layer_data.thick(ii1);
        error = uncertainty * mean;
        Thickness(ii1, :) = Generate_Random_Normal(mean, error, 0, cor);
    end
%%% %%% VERBOSE
    % if mod(ii1, 1000) == 0
    %     disp(ii1);
    % end
end
%%% 小于零的项归零
Thickness(Thickness < 0) = 0;
%%% 记录结果
Computation.Lithosphere.(Name_Layer).Thickness = Thickness;
end