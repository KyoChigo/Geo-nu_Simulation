function lithosphere = Assign_Abundances_Mantle(lithosphere, mantle_U_total, iteration)

Cor = lithosphere.Cor;

%%%%%%%%%%%%%%%%%%%%%%%% Define mass ratio %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lithosphere.Mass_Ratio.Th_U = Generate_Random_Log_Normal(3.776,0.122,0.075,iteration,Cor.BSE);  %mass ratio Wipperfurth et al. 2018
lithosphere.Mass_Ratio.K_U = Generate_Random_Normal(13800,1300,iteration,Cor.BSE); % value from Arevalo et al. 2009 
lithosphere.BSE.Abundance.U = Generate_Random_Normal(mantle_U_total,mantle_U_total*0.2,iteration,Cor.BSE)*10^-9; %McDonough and Sun '95
lithosphere.BSE.Abundance.Th = lithosphere.BSE.Abundance.U .* lithosphere.Mass_Ratio.Th_U; 
lithosphere.BSE.Abundance.K = lithosphere.BSE.Abundance.U .* lithosphere.Mass_Ratio.K_U;

clear Cor