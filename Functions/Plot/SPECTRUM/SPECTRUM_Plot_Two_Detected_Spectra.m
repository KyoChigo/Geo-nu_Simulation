function SPECTRUM_Plot_Two_Detected_Spectra(yufeng_file_path, enomoto_file_path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : SPECTRUM_Plot_Two_Detected_Spectra.m
% Description     : Plot the detected spectrum based on different input spectrum
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - yufeng_file_path   : Path to file that uses Yufeng's spectrum
%   - enomoto_file_path  : Path to file that uses Enomoto's spectrum
%
% Created On      : 2025-04-18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Load Data ~~~~~~~~~~~~~~~~~~~~ %
[~, name_yufeng, ~] = fileparts(yufeng_file_path);
[~, name_enomoto, ~] = fileparts(enomoto_file_path);

res1 = load(yufeng_file_path);
res2 = load(enomoto_file_path);

sig_1 = res1.Output.Lithosphere.Geonu_Signal.Total.Total + res1.Output.Mantle.Geonu_Signal.Total.Total;
sig_2 = res2.Output.Lithosphere.Geonu_Signal.Total.Total + res2.Output.Mantle.Geonu_Signal.Total.Total;

spe_1_u238 = res1.Output.Lithosphere.Geonu_Spectrum.Total.U238 + res1.Output.Mantle.Geonu_Spectrum.Total.U238;
spe_1_th232 = res1.Output.Lithosphere.Geonu_Spectrum.Total.Th232 + res1.Output.Mantle.Geonu_Spectrum.Total.Th232;
spe_2_u238 = res2.Output.Lithosphere.Geonu_Spectrum.Total.U238 + res2.Output.Mantle.Geonu_Spectrum.Total.U238;
spe_2_th232 = res2.Output.Lithosphere.Geonu_Spectrum.Total.Th232 + res2.Output.Mantle.Geonu_Spectrum.Total.Th232;

% ~~~~~~~~~~~~~~~~~~~~ Get Index ~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(sig_1, 'Normal');
mean = pd.mu;
idx_1 = find(sig_1 >= mean - 0.01 & sig_1 <= mean + 0.01, 1);
pd = fitdist(sig_2, 'Normal');
mean = pd.mu;
idx_2 = find(sig_2 >= mean - 0.01 & sig_2 <= mean + 0.01, 1);
energy = res1.Physics.Cross_Section.Energy;

% ~~~~~~~~~~~~~~~~~~~~ Plot ~~~~~~~~~~~~~~~~~~~~ %
figure('Position', [100, 100, 800, 400]); % 800 x 400 %
hold on;
plot(energy, spe_1_u238(idx_1, :), 'g-', 'LineWidth', 2);
plot(energy, spe_2_u238(idx_2, :), 'r-', 'LineWidth', 2);
plot(energy, spe_1_th232(idx_1, :), 'g--', 'LineWidth', 2);
plot(energy, spe_2_th232(idx_2, :), 'r--', 'LineWidth', 2);
xlabel("Energy (MeV)");
ylabel("Signal Rate (TNU/MeV)");
title("Detected Spectra");
xticks(energy(1): 0.1 : energy(end));
yticks(0: 0.02: 1);
legend('Yufeng: 238U', 'Enomoto: 238U', 'Yufeng: 232Th', 'Enomoto: 232Th');
grid on;

% ~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~ %
pic_path = sprintf('./Pics/SPECTRUM/Geonu_Spectrum_%s_%s.jpg', name_yufeng, name_enomoto);
print(pic_path, '-djpeg', '-r1000');

end