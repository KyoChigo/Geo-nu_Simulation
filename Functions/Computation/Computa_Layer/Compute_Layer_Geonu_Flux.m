function Computation = Compute_Layer_Geonu_Flux(Physics, Computation, Name_Layer)
%%% 质量
U_mass = Computation.Lithosphere.(Name_Layer).Mass.U;
U238_mass = Computation.Lithosphere.(Name_Layer).Mass.U238;
U235_mass = Computation.Lithosphere.(Name_Layer).Mass.U235;
Th232_mass = Computation.Lithosphere.(Name_Layer).Mass.Th232;
K_mass = Computation.Lithosphere.(Name_Layer).Mass.K;
K40_mass = Computation.Lithosphere.(Name_Layer).Mass.K40;
%%% 单位质量产生的通量
U_flux_per_mass = Physics.Elements.Geonu_Flux.U;
U238_flux_per_mass = Physics.Elements.Geonu_Flux.U238;
U235_flux_per_mass = Physics.Elements.Geonu_Flux.U235;
Th232_flux_per_mass = Physics.Elements.Geonu_Flux.Th232;
K_flux_per_mass = Physics.Elements.Geonu_Flux.K;
K40_flux_per_mass = Physics.Elements.Geonu_Flux.K40;
%%% 总通量
U_geonu_flux = U_flux_per_mass .* U_mass;
U238_geonu_flux = U238_flux_per_mass .* U238_mass;
U235_geonu_flux = U235_flux_per_mass .* U235_mass;
Th232_geonu_flux = Th232_flux_per_mass .* Th232_mass;
K_geonu_flux = K_flux_per_mass .* K_mass;
K40_geonu_flux = K40_flux_per_mass .* K40_mass;
%%% 记录数据
Computation.Lithosphere.(Name_Layer).Geonu_Flux.U = U_geonu_flux;
Computation.Lithosphere.(Name_Layer).Geonu_Flux.U238 = U238_geonu_flux;
Computation.Lithosphere.(Name_Layer).Geonu_Flux.U235 = U235_geonu_flux;
Computation.Lithosphere.(Name_Layer).Geonu_Flux.Th232 = Th232_geonu_flux;
Computation.Lithosphere.(Name_Layer).Geonu_Flux.K = K_geonu_flux;
Computation.Lithosphere.(Name_Layer).Geonu_Flux.K40 = K40_geonu_flux;
end