function Physics = Compute_Cross_Section(Physics)
% ~~~~~~~~~~~~~~~~~~~~ Compute IBD Cross Section ~~~~~~~~~~~~~~~~~~~~ %
% Energy            : MeV                                             %
% IBD               : cm^2                                            %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

% % ~~~~~~~~~~~~~~~~~~~~ Setup ~~~~~~~~~~~~~~~~~~~~ % %
Energy_array = Physics.Elements.Spectrum.Energy.Bin_Centers; % Unit: MeV %
mass_e = 0.51099895069; % Unit: MeV %
mass_proton = 938.27208943; % Unit: MeV %
mass_neutron = 939.56542052; % Unit: MeV %
% % From Wiki % %

delta = mass_neutron - mass_proton;
threshold = 1.806; % Unit: MeV %

% % ~~~~~~~~~~~~~~~~~~~~ Computation ~~~~~~~~~~~~~~~~~~~~ % %
% % Temp Variables % %
crosssection_array = zeros(length(Energy_array), 1); % Column Vector %

% % For energy which is smaller than threshold % %
crosssection_array(Energy_array < threshold) = 0.0;

% % For energy which is larger than threshold % %
valid_indices = Energy_array > threshold;
part1 = (Energy_array(valid_indices) - delta) .^2;
part2 = mass_e^2 ./ ((Energy_array(valid_indices) - delta) .^2);
part3 = sqrt(1 - part2);
crosssection_array(valid_indices) = 9.52 * part1 .* part3 * 1e-44; % Unit: cm^2 %

% % % Record % % $
Physics.Cross_Section.Energy = Energy_array; % Unit: MeV %
Physics.Cross_Section.IBD = crosssection_array; % Unit: cm^2 %

% ~~~~~~~~~~~~~~~~~~~~ Output Message ~~~~~~~~~~~~~~~~~~~~ %
disp('[Physics::Compute_Cross_Section] IBD cross section is complete');

end