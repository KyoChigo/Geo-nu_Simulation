function Physics = Compute_Cross_Section(Physics)

Energy_array = Physics.Elements.Spectrum.Energy.Bin_Centers;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 计算IBD cross section %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Energy: MeV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Cross section: cm^2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% From Wiki
mass_e = 0.51099895069; % Unit: MeV
mass_proton = 938.27208943; % Unit: MeV
mass_neutron = 939.56542052; % Unit: MeV

delta = mass_neutron - mass_proton;
threshold = 1.806; % Unit: MeV

crosssection_array = zeros(length(Energy_array), 1); % 列矢量
% For energy which is smaller than threshold
crosssection_array(Energy_array < threshold) = 0.0;

% For energy which is larger than threshold
valid_indices = Energy_array > threshold;
part1 = (Energy_array(valid_indices) - delta) .^2;
part2 = mass_e^2 ./ ((Energy_array(valid_indices) - delta) .^2);
part3 = sqrt(1 - part2);
crosssection_array(valid_indices) = 9.52 * part1 .* part3 * 1e-44; % Unit: cm^2

Physics.Cross_Section.Energy = Energy_array; % Unit: MeV
Physics.Cross_Section.IBD = crosssection_array; % Unit: cm^2

% Output message
disp('[Physics::Compute_Cross_Section] IBD cross section is complete');
end