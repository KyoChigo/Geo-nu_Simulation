function Computation = Compute_Lithosphere(Physics, Geology, Computation)
%%%%%%%%%%%%%%%%% Lithosphere %%%%%%%%%%%%%%%%%%%%%%
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
%%% 计算Layer的厚度
    Computation = Compute_Layer_Thickness(Geology, Computation, layer); % Unit: m
    fprintf('[Compute_Layer_Properties] %s Thickness Complete.\n', layer);
%%% 计算Layer的深度
    Computation = Compute_Layer_Depth(Geology, Computation, layer); % Unit: m
    fprintf('[Compute_Layer_Properties] %s Depth Complete.\n', layer);
%%% 计算Layer的密度
    Computation = Compute_Layer_Density(Geology, Computation, layer); % Unit: g/cm^3
    fprintf('[Compute_Layer_Properties] %s Density Complete.\n', layer);
%%% 计算Layer的半径
    Computation = Compute_Layer_Radius(Geology, Computation, layer); % Unit: m
    fprintf('[Compute_Layer_Properties] %s Radius Complete.\n', layer);
%%% 计算Layer的体积
    Computation = Compute_Layer_Volume(Geology, Computation, layer);  % Unit: m^3
    fprintf('[Compute_Layer_Properties] %s Volume Complete.\n', layer);
%%% 计算layer的温度
    Computation = Compute_Layer_Temperature(Computation, layer);  % Unit: ℃；这个温度只用来修正Vp，并不能表示真正的温度
    fprintf('[Compute_Layer_Properties] %s Temperature Complete.\n', layer);
%%% 计算layer的压强
    if strcmp(layer, 's1')
        Computation = Compute_Layer_Pressure(Computation, layer, 'None'); % Unit: MPa；这个压强只能用来修正Vp，并不能表示真正的压强
    else
        Computation = Compute_Layer_Pressure(Computation, layer, layers{ii1 - 1}); % Unit: MPa；这个压强只能用来修正Vp，并不能表示真正的压强
    end
    fprintf('[Compute_Layer_Properties] %s Pressure Complete.\n', layer);
%%% 计算layer的元素丰度
    Computation = Compute_Layer_Abundance(Physics, Geology, Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Abundance Complete.\n', layer);
%%% 计算layer的质量
    Computation = Compute_Layer_Mass(Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Mass Complete.\n', layer);
%%% 计算layer的Geonu Flux
    Computation = Compute_Layer_Geonu_Flux(Physics, Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Geonu Flux Complete.\n', layer);
%%% 计算layer的Heat Power
    Computation = Compute_Layer_Heat_Power(Physics, Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Heat Power Complete.\n', layer);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Mantle %%%%%%%%%%%%%%%%%%%%%%%%%%%
end