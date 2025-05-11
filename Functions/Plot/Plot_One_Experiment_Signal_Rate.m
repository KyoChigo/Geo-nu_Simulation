function Plot_One_Experiment_Signal_Rate(file_path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Plot_One_Experiment_Signal_Rate.m
% Description     : Get statistical results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - file_path   : Path to file
%
% Physical Units:
%   - signal rate : TNU
%
% Created On      : 2025-03-21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Res = load(file_path);

[~, name, ~] = fileparts(file_path);

sig_lith = Res.Output.Lithosphere.Geonu_Signal.Total.Total;
sig_mantle = Res.Output.Mantle.Geonu_Signal.Total.Total;
sig_total = sig_lith + sig_mantle;
sig_mantle = sig_mantle(sig_mantle ~= 0); % Drop 0 values %
sig_total = sig_total(sig_total ~= 0); % Drop 0 values %
% ~~~~~~~~~~~~~~~~~~~~ Signal ~~~~~~~~~~~~~~~~~~~~ %
% % ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ % %
pd = fitdist(sig_lith(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(sig_lith, 'BinWidth', 1);
title("Geonu Signal Distribution for Lithosphere");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
parameter_tex = sprintf('Geonu Signal Rate\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_Lithosphere_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');
% % ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ % %
pd = fitdist(sig_mantle(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(sig_mantle, 'BinWidth', 1);
title("Geonu Signal Rate Distribution for Mantle");
xlabel('Geonu Signal Rate (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
parameter_tex = sprintf('Geonu Signal Rate\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_Mantle_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');
% % ~~~~~~~~~~~~~~~~~~~~ Total ~~~~~~~~~~~~~~~~~~~~ % %
pd = fitdist(sig_total(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(sig_total, 'BinWidth', 1);
title("Geonu Signal Rate Distribution for Earth");
xlabel('Geonu Signal Rate (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
parameter_tex = sprintf('Geonu Signal Rate\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_Total_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');
% % ~~~~~~~~~~~~~~~~~~~~ U238 ~~~~~~~~~~~~~~~~~~~~ % %
u238 = Res.Output.Lithosphere.Geonu_Signal.Total.U238 + Res.Output.Mantle.Geonu_Signal.Total.U238;
pd = fitdist(u238(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(u238, 'BinWidth', 1);
title("Geonu Signal Rate Distribution for 238U");
xlabel('Geonu Signal Rate (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
parameter_tex = sprintf('Geonu Signal Rate\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_238U_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');
% % ~~~~~~~~~~~~~~~~~~~~ TH232 ~~~~~~~~~~~~~~~~~~~~ % %
th232 = Res.Output.Lithosphere.Geonu_Signal.Total.Th232 + Res.Output.Mantle.Geonu_Signal.Total.Th232;
pd = fitdist(th232(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(th232, 'BinWidth', 1);
title("Geonu Signal Rate Distribution for 232Th");
xlabel('Geonu Signal Rate (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
parameter_tex = sprintf('Geonu Signal Rate\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_232Th_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');

end