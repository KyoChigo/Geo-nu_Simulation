function Computation = Compute_Layer_Properties(Physics, Geology, Computation, Name_Layer)

%%% 计算Layer的厚度
Computation = Compute_Layer_Thickness(Geology, Computation, Name_Layer);
fprintf('[Compute_Layer_Properties] %s Thickness Complete.\n', Name_Layer);
%%% 计算Layer的深度
Computation = Compute_Layer_Depth(Geology, Computation, Name_Layer);
fprintf('[Compute_Layer_Properties] %s Depth Complete.\n', Name_Layer);
%%% 计算Layer的密度
Computation = Compute_Layer_Density(Geology, Computation, Name_Layer);
fprintf('[Compute_Layer_Properties] %s Density Complete.\n', Name_Layer);
%%% 计算Layer的半径
Computation = Compute_Layer_Radius(Geology, Computation, Name_Layer);
fprintf('[Compute_Layer_Properties] %s Radius Complete.\n', Name_Layer);
%%% 计算Layer的体积
Computation = Compute_Layer_Volume(Geology, Computation, Name_Layer);
fprintf('[Compute_Layer_Properties] %s Volume Complete.\n', Name_Layer);
%%% 计算layer的温度
Computation = Compute_Layer_Temperature(Computation, Name_Layer);
fprintf('[Compute_Layer_Properties] %s Temperature Complete.\n', Name_Layer);
%%% 计算layer的压强
Computation = Compute_Layer_Pressure()
%%% 计算Layer的元素丰度
% Computation = Compute_Layer_Abundance(Geology, Computation, Name_Layer);
% fprintf('[Compute_Layer_Properties] %s Abundance Complete.\n', Name_Layer);
%%% 计算Layer的质量
% Computation = Compute_Layer_Mass(Geology, Computation, Name_Layer);
% fprintf('[Compute_Layer_Properties] %s Mass Complete.\n', Name_Layer);
%%% 计算Layer的xxx


%%%%%%% 循环结束
end