function Computation = Compute_Layer_Heat_Power(Physics, Computation, Name_Layer)
%%% 数据
U_mass = Computation.Lithosphere.(Name_Layer).Mass.U;
U238_mass = Computation.Lithosphere.(Name_Layer).Mass.U238;
U235_mass = Computation.Lithosphere.(Name_Layer).Mass.U235;
Th232_mass = Computation.Lithosphere.(Name_Layer).Mass.Th232;
K_mass = Computation.Lithosphere.(Name_Layer).Mass.K;
K40_mass = Computation.Lithosphere.(Name_Layer).Mass.K40;
%%% 单位质量产生的热功率
U_heat_per_mass = Physics.Elements.Heat_Power.U;
U238_heat_per_mass = Physics.Elements.Heat_Power.U238;
U235_heat_per_mass = Physics.Elements.Heat_Power.U235;
Th232_heat_per_mass = Physics.Elements.Heat_Power.Th232;
K_heat_per_mass = Physics.Elements.Heat_Power.K;
K40_heat_per_mass = Physics.Elements.Heat_Power.K40;
%%% 总热功率
U_heat_power = U_heat_per_mass * U_mass;
U238_heat_power = U238_heat_per_mass * U238_mass;
U235_heat_power = U235_heat_per_mass * U235_mass;
Th232_heat_power = Th232_heat_per_mass * Th232_mass;
K_heat_power = K_heat_per_mass * K_mass;
K40_heat_power = K40_heat_per_mass * K40_mass;
%%% 记录数据
Computation.Lithosphere.(Name_Layer).Heat_Power.U = U_heat_power;
Computation.Lithosphere.(Name_Layer).Heat_Power.U238 = U238_heat_power;
Computation.Lithosphere.(Name_Layer).Heat_Power.U235 = U235_heat_power;
Computation.Lithosphere.(Name_Layer).Heat_Power.Th232 = Th232_heat_power;
Computation.Lithosphere.(Name_Layer).Heat_Power.K = K_heat_power;
Computation.Lithosphere.(Name_Layer).Heat_Power.K40 = K40_heat_power;
end