file = "./Output/Result_2025-03-20_21-15-22.mat";
[~, name, ~] = fileparts(file);
Res = load(file);
lith = Res.Output.Lithosphere.Geonu_Signal.Total.Total;
mantle = Res.Output.Mantle.Geonu_Signal.Total.Total;
total = lith + mantle;
% ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(lith(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(lith, 'BinWidth', 1);
title('Geonu Signal Distribution for Lithosphere');
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
grid on;
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
text(60, 200, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signals_Lithosphere_%s.jpg', name);
print(pic_path, '-djpeg', '-r300');
% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(mantle(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(mantle, 'BinWidth', 1);
title('Geonu Signal Distribution for Mantle');
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
grid on;
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
text(60, 600, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signals_Mantle_%s.jpg', name);
print(pic_path, '-djpeg', '-r300');
% ~~~~~~~~~~~~~~~~~~~~ Total ~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(total(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(total, 'BinWidth', 1);
title('Geonu Signal Distribution for Earth');
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
grid on;
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
text(60, 200, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signals_Total_%s.jpg', name);
print(pic_path, '-djpeg', '-r300');
