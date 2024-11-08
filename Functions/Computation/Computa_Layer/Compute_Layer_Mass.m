function Computation = Compute_Layer_Mass(Computation, Name_Layer)
%%% 拿到数据
U_Abundance = Computation.Lithosphere.(Name_Layer).Abundance.U;
U238_Abundance = Computation.Lithosphere.(Name_Layer).Abundance.U238;
U235_Abundance = Computation.Lithosphere.(Name_Layer).Abundance.U235;
Th232_Abundance = Computation.Lithosphere.(Name_Layer).Abundance.Th232;
K_Abundance = Computation.Lithosphere.(Name_Layer).Abundance.K;
K40_Abundance = Computation.Lithosphere.(Name_Layer).Abundance.K40;
density = Computation.Lithosphere.(Name_Layer).Density;
volume = Computation.Lithosphere.(Name_Layer).Volume;
%%% 计算质量
total_mass = density .* volume;
U_mass = U_Abundance .* total_mass;
U238_mass = U238_Abundance .* total_mass;
U235_mass = U235_Abundance .* total_mass;
Th232_mass = Th232_Abundance .* total_mass;
K_mass = K_Abundance .* total_mass;
K40_mass = K40_Abundance .* total_mass;
%%% 记录数据
Computation.Lithosphere.(Name_Layer).Mass.Total = total_mass;
Computation.Lithosphere.(Name_Layer).Mass.U = U_mass;
Computation.Lithosphere.(Name_Layer).Mass.U238 = U238_mass;
Computation.Lithosphere.(Name_Layer).Mass.U235 = U235_mass;
Computation.Lithosphere.(Name_Layer).Mass.Th232 = Th232_mass;
Computation.Lithosphere.(Name_Layer).Mass.K = K_mass;
Computation.Lithosphere.(Name_Layer).Mass.K40 = K40_mass;
end