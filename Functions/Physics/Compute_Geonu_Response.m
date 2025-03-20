function Physics = Compute_Geonu_Response(Physics)
% Geonu_Response is a variable to compute geonu signal, which is
% Signals = Rock Mass * Abundance * Geonu_Response * Pee * 1/Distance^2 * N_Proton * Detection Efficiency
am_kg = Physics.Constants.Unit_Conversion.amu_kg;
IBD = Physics.Cross_Section.IBD;
one_year = 365 * 86400;
HPEs = {'U235', 'U238', 'Th232', 'K40'};
for i = 1 : length(HPEs)
    HPE = HPEs{i};
    half_life = Physics.Elements.Halflife.(HPE);
    atom_mass = Physics.Elements.Mass.(HPE);
    spectrum = Physics.Elements.Spectrum.dn_dE.(HPE);
    mass_abundance = Physics.Elements.Abundance.Mass.(HPE);
    geo_res = (mass_abundance/(atom_mass * am_kg)) * (log(2)/half_life) .* spectrum .* IBD .* (1/(4 * pi)) * (1e-4)* one_year * 1e32;
    % 1e-4 come form 1/m^2 to 1/cm^2
    Physics.Elements.Geonu_Response.(HPE) = geo_res;
end
disp('[Physics::Compute_Geonu_Response] Geonu Resoponse is complete');

end