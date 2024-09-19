function Geonu = Load_Geonutrino_Spectrum(Elements)
%%%%%%%%%%% Get values from Elements
Avogadro = Elements.Avogadro;
decay_U238 = Elements.Decay_Constants.U238;
decay_Th232 = Elements.Decay_Constants.Th232;
mass_U238 = Elements.Atomic_Mass.U238;
mass_Th232 = Elements.Atomic_Mass.Th232;
am_kg = Elements.Atomic_Mass.amu_kg;

detected_efficiency = 1;
exposure = 365 * 86400; % One year. Unit: s
number_target = 10^32; % The number of proton


size = 75;

Geonu.Energy.Energy_Binwidth = size; % Unit: keV
Geonu.Energy.Energy_Bins = 0.5 * size: size: 3300;
Geonu.Energy.Energy_Bins = Geonu.Energy.Energy_Bins'; % Make it be to vertical vector
Geonu.Energy.Energy_Len = length(Geonu.Energy.Energy_Bins);

%%%%%%%%%%%%%% Load Enomoto's Spectrum %%%%%%%%%%%%%%%%
%%% There are 13 columns in data file:
%%% 1. Energy (keV); 2. Energy (MeV);3. Energy (pJ)
%%% 4. Geonu number of U238 (sum = 6) in each decay, i.e. dn/dE
%%% 5. Geonu number of U235 (sum = 4) in each decay, i.e. dn/dE
%%% 6. Geonu number of T232 (sum = 4) in each decay, i.e. dn/dE
%%% 7. Geonu number of K40 (sum = 0.893) in each decay, i.e. dn/dE
%%% Geonu number of Re187(No.8), Lu176(No.9), La138(No.10), ln115(No.11), Cd113(No.11) and Rb87(No.13)
Geonu.Enomoto = load("InputFiles\Enomoto2007_AntineutrinoSpectrum.mat");
%%%%% Resum the specturm because of different bin-width

for i = 1:Geonu.Energy.Energy_Len
    index_top = round(Geonu.Energy.Energy_Bins(i) + 0.5 * size);
    index_bottom = round(Geonu.Energy.Energy_Bins(i) - 0.5 * size + 1);
%%%% Compute dn/dE. Unit: 1/keV %%%%%%%%
    Geonu.Spectrum.U238(i, 1) = Geonu.Energy.Energy_Bins(i);
    Geonu.Spectrum.U235(i, 1) = Geonu.Energy.Energy_Bins(i);
    Geonu.Spectrum.Th232(i, 1) = Geonu.Energy.Energy_Bins(i);
    Geonu.Spectrum.K40(i, 1) = Geonu.Energy.Energy_Bins(i);

    Geonu.Spectrum.U238(i, 2) = sum(Geonu.Enomoto.enomoto(index_bottom : index_top, 4));
    Geonu.Spectrum.U235(i, 2) = sum(Geonu.Enomoto.enomoto(index_bottom : index_top, 5));
    Geonu.Spectrum.Th232(i, 2) = sum(Geonu.Enomoto.enomoto(index_bottom : index_top, 6));
    Geonu.Spectrum.K40(i, 2) = sum(Geonu.Enomoto.enomoto(index_bottom : index_top, 7));
%%%% Compute Cross Section. Unit: cm^2 %%%%%
    Geonu.Cross_Section(i, 1) = Geonu.Energy.Energy_Bins(i);
    Geonu.Cross_Section(i, 2) = Compute_IBD_Cross_Section(Geonu.Energy.Energy_Bins(i));
%%%% Measured Geonu
    % Unit: cm^2/(kg * keV)
    Geonu.Measured_Spectrum.U238.Part1(i, 1) = Geonu.Energy.Energy_Bins(i);
    Geonu.Measured_Spectrum.U238.Part1(i, 2) = (1 / (mass_U238 * am_kg)) * Avogadro * decay_U238 *  detected_efficiency * exposure * number_target * Geonu.Spectrum.U238(i, 2) * Geonu.Cross_Section(i, 2) / (4 * pi);
    Geonu.Measured_Spectrum.Th232.Part1(i, 1) = Geonu.Energy.Energy_Bins(i);
    Geonu.Measured_Spectrum.Th232.Part1(i, 2) = (1 / (mass_Th232 * am_kg)) * Avogadro * decay_Th232 * detected_efficiency * exposure * number_target * Geonu.Spectrum.Th232(i, 2) * Geonu.Cross_Section(i, 2) / (4 * pi);
end
%%%% Total Number of neutrino in each decay. Unit: 1 %%%%
Geonu.Neutrino_Number.U238 = sum(Geonu.Enomoto.enomoto(: , 4));
Geonu.Neutrino_Number.U235 = sum(Geonu.Enomoto.enomoto(: , 5));
Geonu.Neutrino_Number.Th232 = sum(Geonu.Enomoto.enomoto(: , 6));
Geonu.Neutrino_Number.K40 = sum(Geonu.Enomoto.enomoto(: , 7));



