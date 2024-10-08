function Geology = Compute_Abundance_BSE(Geology)
iteration = Geology.Iteration;
cor = Geology.BSE.Correlation;
mantle_U_total = Geology.BSE.Abundance.U_Total;
mantle_U_error = mantle_U_total * 0.2;
%%% Mass ratio
Th_U_Ratio = Generate_Random_Log_Normal(3.776, 0.122, 0.075, iteration, cor);
K_U_Ratio = Generate_Random_Normal(13800, 1300, iteration, cor);
Geology.BSE.Abundance.U = Generate_Random_Normal(mantle_U_total, mantle_U_error, iteration, cor) * 1e-9;
Geology.BSE.Abundance.Th = Th_U_Ratio .* Geology.BSE.Abundance.U;
Geology.BSE.Abundance.K = K_U_Ratio .* Geology.BSE.Abundance.U;
end