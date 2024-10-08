function Computation = Compute_All(Physics, Geology, Computation)
%%%%%%%%%%%%%%%%% Lithosphere %%%%%%%%%%%%%%%%%%%%%%
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
%%% 计算Layer的厚度
    Computation = Compute_Layer_Thickness(Geology, Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Thickness Complete.\n', layer);
%%% 计算Layer的深度
    Computation = Compute_Layer_Depth(Geology, Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Depth Complete.\n', layer);
%%% 计算Layer的密度
    Computation = Compute_Layer_Density(Geology, Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Density Complete.\n', layer);
%%% 计算Layer的半径
    Computation = Compute_Layer_Radius(Geology, Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Radius Complete.\n', layer);
%%% 计算Layer的体积
    Computation = Compute_Layer_Volume(Geology, Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Volume Complete.\n', layer);
%%% 计算layer的温度
    Computation = Compute_Layer_Temperature(Computation, layer);
    fprintf('[Compute_Layer_Properties] %s Temperature Complete.\n', layer);
%%% 计算layer的压强
    if strcmp(layer, 's1')
        Computation = Compute_Layer_Pressure(Computation, layer, 'None');
    else
        Computation = Compute_Layer_Pressure(Computation, layer, layers{ii1 - 1});
    end
    fprintf('[Compute_Layer_Properties] %s Pressure Complete.\n', layer);
end
%%% 计算layer的
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Mantle %%%%%%%%%%%%%%%%%%%%%%%%%%%
end