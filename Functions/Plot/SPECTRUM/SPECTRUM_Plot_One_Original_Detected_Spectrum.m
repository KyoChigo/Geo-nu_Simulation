function SPECTRUM_Plot_One_Original_Detected_Spectrum(file_path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : SPECTRUM_Plot_One_Original_Detected_Spectrum.m
% Description     : Plot the detected spectrum
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - file_path   : Path to file
%
% Created On      : 2025-04-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Load Data ~~~~~~~~~~~~~~~~~~~~ %
[~, name, ~] = fileparts(file_path);
load(file_path);

energy = Physics.Cross_Section.Energy;
detected_u238 = Output.Lithosphere.Geonu_Spectrum.Total.U238 + Output.Mantle.Geonu_Spectrum.Total.U238;
detected_th232 = Output.Lithosphere.Geonu_Spectrum.Total.Th232 + Output.Mantle.Geonu_Spectrum.Total.Th232;

model_u238 = Physics.Elements.Spectrum.dn_dE.U238 .* Physics.Cross_Section.IBD;
model_th232 = Physics.Elements.Spectrum.dn_dE.Th232 .* Physics.Cross_Section.IBD;

sig_u238 = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Mantle.Geonu_Signal.Total.U238;
sig_th232 = Output.Lithosphere.Geonu_Signal.Total.Th232 + Output.Mantle.Geonu_Signal.Total.Th232;
sig = sig_u238 + sig_th232;

% ~~~~~~~~~~~~~~~~~~~~ Get Index ~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(sig, 'Normal');
mean = pd.mu;
idx = find(sig >= mean - 0.01 & sig <= mean + 0.01, 1);

% ~~~~~~~~~~~~~~~~~~~~ Plot ~~~~~~~~~~~~~~~~~~~~ %
% % Define normalization function % %
normalize = @(x) x / sum(x);
% % Normalization % %
norm_model_u238 = normalize(model_u238);
norm_model_th232 = normalize(model_th232);
norm_det_u238 = normalize(detected_u238(idx, :)');
norm_det_th232 = normalize(detected_th232(idx, :)');

figure;
% % % Subplot 1: Normalized spectra % % %
subplot(2,1,1);
hold on;
plot(energy, norm_model_u238, 'g-', 'LineWidth', 2);
plot(energy, norm_model_th232, 'r-', 'LineWidth', 2);
plot(energy, norm_det_u238, 'k--', 'LineWidth', 2);
plot(energy, norm_det_th232, 'k:', 'LineWidth', 2);
% % % % Labels and title % % % %
xlabel('Energy (MeV)');
ylabel('Normalized Spectrum');
title('Normalized Detected and Original Spectra');
legend('Original 238U', 'Original 232Th', 'Detected 238U', 'Detected 232Th',  'Location', 'southwest');
% % % % Ticks % % % %
xticks(energy(1):0.1:energy(end));
set(gca, 'YScale', 'log');
ylim([1e-7, 1e-1]);
yticks([1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1]);
grid on;
hold off;

% % % Subplot 2: Ratio % % %
subplot(2,1,2);

ratio_u238 = norm_det_u238 ./ norm_model_u238;
ratio_th232 = norm_det_th232 ./ norm_model_th232;
ratio_u238(isnan(ratio_u238)) = 0;  % Convert 0/0 to 0 %
ratio_th232(isnan(ratio_th232)) = 0;  % Convert 0/0 to 0 %

hold on;
plot(energy, ratio_u238, 'LineWidth', 2, 'Color', 'g');
plot(energy, ratio_th232, 'LineWidth', 2, 'Color', 'r');
xlabel('Energy (MeV)');
ylabel('Ratio (Detected / Original)');
title('Ratio of Normalized Detected Spectrum to Original Spectrum');
legend('238U', '232Th', 'Location', 'southeast');
ylim([0.97, 1.05]);
xticks(energy(1):0.1:energy(end));
yticks(0.97: 0.01: 1.05);
set(gca, 'YScale', 'log');

grid on;

% ~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~ %
pic_path = sprintf('./Pics/SPECTRUM/Geonu_Spectrum_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');

end

