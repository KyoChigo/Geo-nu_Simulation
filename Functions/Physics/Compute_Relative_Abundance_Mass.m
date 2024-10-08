function output = Compute_Relative_Abundance_Mass(Physics, Name_Element)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 利用mole丰度计算质量丰度 %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Mass: amu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Mass = Physics.Elements.Mass;
Abundance = Physics.Elements.Abundance.Mole;

if strcmp(Name_Element, 'U238')
    mass_U238 = Mass.U238;
    mass_U235 = Mass.U235;
    abun_U238 = Abundance.U238;
    abun_U235 = Abundance.U235;

    output = (abun_U238 * mass_U238) / (abun_U235 * mass_U235 + abun_U238 * mass_U238);
elseif strcmp(Name_Element, 'U235')
    mass_U238 = Mass.U238;
    mass_U235 = Mass.U235;
    abun_U238 = Abundance.U238;
    abun_U235 = Abundance.U235;

    output = (abun_U235 * mass_U235) / (abun_U235 * mass_U235 + abun_U238 * mass_U238);
elseif strcmp(Name_Element, 'Th232')
    output = 1;
elseif strcmp(Name_Element, 'K40')
    mass_K39 = Mass.K39;
    mass_K40 = Mass.K40;
    mass_K41 = Mass.K41;
    abun_K39 = Abundance.K39;
    abun_K40 = Abundance.K40;
    abun_K41 = Abundance.K41;

    output = (abun_K40 * mass_K40) / (abun_K39 * mass_K39 + abun_K40 * mass_K40 + abun_K41 * mass_K41);
end