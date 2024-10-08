function Physics = Load_Geonu_Spectrum(Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 加载Geonu能谱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Enomoto = load("Input_Files\Enomoto2007_AntineutrinoSpectrum.mat");
%%% load energy bins %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Physics.Elements.Spectrum.Energy.Binwidth = Enomoto.enomoto( 2, 2) - Enomoto.enomoto(1, 2); % Unit: MeV
Physics.Elements.Spectrum.Energy.Bins = Enomoto.enomoto(:, 2); % Unit: MeV
Physics.Elements.Spectrum.Energy.Length = length(Physics.Elements.Spectrum.Energy.Bins);
%%% Load spectrum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Physics.Elements.Spectrum.dn_dE.U238 = Enomoto.enomoto(:, 4) * 1e3; % Unit: 1/MeV
Physics.Elements.Spectrum.dn_dE.U235 = Enomoto.enomoto(:, 5) * 1e3; % Unit: 1/MeV
Physics.Elements.Spectrum.dn_dE.Th232 = Enomoto.enomoto(:, 6) * 1e3; % Unit: 1/MeV
Physics.Elements.Spectrum.dn_dE.K40 = Enomoto.enomoto(:, 7) * 1e3; % Unit: 1/MeV
%%% Compute total number of neutrino %%%%%%%%%%%%%%%%%%%%%%
binwidth = Physics.Elements.Spectrum.Energy.Binwidth;
Physics.Elements.Spectrum.Total_Number.U238 = binwidth * sum(Physics.Elements.Spectrum.dn_dE.U238);
Physics.Elements.Spectrum.Total_Number.U235 = binwidth * sum(Physics.Elements.Spectrum.dn_dE.U235);
Physics.Elements.Spectrum.Total_Number.Th232 = binwidth * sum(Physics.Elements.Spectrum.dn_dE.Th232);
Physics.Elements.Spectrum.Total_Number.K40 = binwidth * sum(Physics.Elements.Spectrum.dn_dE.K40);

% Output message
disp('[Physics::Load_Geonu_Spectrum] Geonu spectrum is complete');
end