function Geology = Compute_Abundance_BSE(Geology)
%%% %%%% 给出Th/U和K/U质量比，这里的K包括K的所有同位素而非K40
iteration = Geology.Iteration;
cor = Geology.BSE.Correlation;
mantle_U_mean = Geology.BSE.Abundance.U_Mean; % Unit: g/g
mantle_U_error = mantle_U_mean * 0.2;  % Unit: g/g
%%% Mass ratio
%%% 数据来自https://www.sciencedirect.com/science/article/abs/pii/S0012821X18303807?via%3Dihub
Th_U_Ratio = Generate_Random_Log_Normal(3.776, 0.122, 0.075, iteration, cor);
K_U_Ratio = Generate_Random_Normal(13800, 1300, iteration, cor); % 没找到
%%% 记录数据
Geology.BSE.Abundance.U = Generate_Random_Normal(mantle_U_mean, mantle_U_error, iteration, cor) * 1e-9; % Unit: g/g
% 1e-9是因为ppb = 1e-9。输入的时候没有把单位放进来，此处考虑了单位的影响
Geology.BSE.Abundance.Th = Th_U_Ratio .* Geology.BSE.Abundance.U; % Unit: g/g
Geology.BSE.Abundance.K = K_U_Ratio .* Geology.BSE.Abundance.U; % Unit: g/g
end