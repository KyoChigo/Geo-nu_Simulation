function Geology = Compute_Mantle_Mass(Geology, Computation)
iteration = Geology.Iteration;
cor = Geology.Mantle.Correlation;
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
lith_mass = zeros(1, iteration);
lith_U_mass = zeros(1, iteration);
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    lith_mass = lith_mass + sum(Computation.Lithosphere.(layer).Mass.Total, 1); % 同一列中所有行求和
    lith_U_mass = lith_U_mass + sum(Computation.Lithosphere.LC.Mass.U238, 1); % 后期需要修改！！！！！！！！！！
end
lith_mass = lith_mass'; % 转换成列矢量
lith_U_mass = lith_U_mass'; % 转换成列矢量
%%% Earth mass
mean = 5.97218*10^24;
error = 0.000060*10^24;
earth_mass = Generate_Random_Normal(mean, error,iteration);
%%% Core mass
mean = 1.835*10^24 + 9.675*10^22; % 内核与外核
error = 0.03 * mean;
core_mass = Generate_Random_Normal(mean, error, iteration);
%%% BSE mass
bse_mass = earth_mass - core_mass;
%%% Mantle mass
mantle_mass = bse_mass - lith_mass;
%%% 记录数据
% Geology.Other.Earth.Mass = earth_mass;
% Geology.Other.Core.Mass = core_mass;
% Geology.BSE.Mass = bse_mass;
% Geology.Mantle.Mass.Total = mantle_mass;
% Geology.
%%% 元素质量
%%% Uranium mass
U_mass = Geology.BSE.Abundance.U .* bse_mass - lith_U_mass;
%%% Th/U and K/U
ThU_ratio_dm = Generate_Random_Log_Normal(3.45, 1.66, 1.18, iteration, cor);
KUratio_dm = Generate_Random_Normal(19000, 1300, iteration, cor);

template_abundance_U_dm = Generate_Random_Normal(8, 8*0.3, iteration, cor) * 1e-9;
template_abundance_U_dm(template_abundance_U_dm < 0) = 0;
index = U_mass > template_abundance_U_dm .* mantle_mass * (1 - ??);


end