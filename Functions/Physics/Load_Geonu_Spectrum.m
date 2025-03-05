function Physics = Load_Geonu_Spectrum(Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 加载Geonu能谱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Enomoto = load("Input_Files\Enomoto2007_AntineutrinoSpectrum.mat");
%%% load energy bins %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
binwidth = 0.1; % Unit: MeV
Physics.Elements.Spectrum.Energy.Binwidth = binwidth; % Unit: MeV
Physics.Elements.Spectrum.Energy.Bin_Centers = (0 + 0.5 * binwidth:binwidth:3.5)'; % Unit: MeV
%%% 创建0数组 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
template = 0 .* Physics.Elements.Spectrum.Energy.Bin_Centers;
Physics.Elements.Spectrum.dn_dE.U238 = template;
Physics.Elements.Spectrum.dn_dE.U235 = template;
Physics.Elements.Spectrum.dn_dE.Th232 = template;
Physics.Elements.Spectrum.dn_dE.K40 = template;
%%% 重整能谱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Length = length(Physics.Elements.Spectrum.Energy.Bin_Centers);
Physics.Elements.Spectrum.Energy.Length = Length;
for ii1 = 1:Length
    energy = Physics.Elements.Spectrum.Energy.Bin_Centers(ii1, 1) + 0.5 *binwidth;
    index = find(Enomoto.enomoto(:, 2) > energy, 1, 'first') - 1;
    last_index = index - 99;
    if last_index <= 0
        last_index = 1;
    end
    %%% Load spectrum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Physics.Elements.Spectrum.dn_dE.U238(ii1, 1) = sum(Enomoto.enomoto(last_index : index, 4)) * 1e3; % Unit: 1/MeV
    Physics.Elements.Spectrum.dn_dE.U235(ii1, 1) = sum(Enomoto.enomoto(last_index : index, 5)) * 1e3; % Unit: 1/MeV
    Physics.Elements.Spectrum.dn_dE.Th232(ii1, 1) = sum(Enomoto.enomoto(last_index : index, 6)) * 1e3; % Unit: 1/MeV
    Physics.Elements.Spectrum.dn_dE.K40(ii1, 1) = sum(Enomoto.enomoto(last_index : index, 7)) * 1e3; % Unit: 1/MeV
end
%%% Compute total number of neutrino %%%%%%%%%%%%%%%%%%%%%%
Physics.Elements.Spectrum.Total_Number.U238 = 1e-3 * sum(Physics.Elements.Spectrum.dn_dE.U238);
Physics.Elements.Spectrum.Total_Number.U235 = 1e-3 * sum(Physics.Elements.Spectrum.dn_dE.U235);
Physics.Elements.Spectrum.Total_Number.Th232 = 1e-3 * sum(Physics.Elements.Spectrum.dn_dE.Th232);
Physics.Elements.Spectrum.Total_Number.K40 = 1e-3 * sum(Physics.Elements.Spectrum.dn_dE.K40);

% Output message
disp('[Physics::Load_Geonu_Spectrum] Geonu spectrum is complete');
end