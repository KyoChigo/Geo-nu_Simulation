function Plot_One_Experiment(file_path)

Res = load(file_path);

[~, name, ~] = fileparts(file_path);

lith = Res.Output.Lithosphere.Geonu_Signal.Total.Total;
mantle = Res.Output.Mantle.Geonu_Signal.Total.Total;
total = lith + mantle;
% ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(lith(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(lith, 'BinWidth', 1);
title("Geonu Signal Distribution for Lithosphere");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
% 设置横轴和纵轴刻度间隔为 5
xticks(0:5:100);  % 横轴从 0 到 80，间隔为 5
grid on;
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signals_Lithosphere_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');
% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(mantle(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(mantle, 'BinWidth', 1);
title("Geonu Signal Distribution for Mantle");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
% 设置横轴和纵轴刻度间隔为 5
xticks(0:5:100);  % 横轴从 0 到 80，间隔为 5
grid on;
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signals_Mantle_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');
% ~~~~~~~~~~~~~~~~~~~~ Total ~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(total(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(total, 'BinWidth', 1);
title("Geonu Signal Distribution for Earth");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
% 设置横轴和纵轴刻度间隔为 5
xticks(0:5:100);  % 横轴从 0 到 80，间隔为 5
grid on;
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signals_Total_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');
% ~~~~~~~~~~~~~~~~~~~~ U238 ~~~~~~~~~~~~~~~~~~~~ %
u238 = Res.Output.Lithosphere.Geonu_Signal.Total.U238 + Res.Output.Mantle.Geonu_Signal.Total.U238;
pd = fitdist(u238(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(u238, 'BinWidth', 1);
title("Geonu Signal Distribution for 238U");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
% 设置横轴和纵轴刻度间隔为 5
xticks(0:5:100);  % 横轴从 0 到 80，间隔为 5
grid on;
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signals_238U_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');
% ~~~~~~~~~~~~~~~~~~~~ TH232 ~~~~~~~~~~~~~~~~~~~~ %
th232 = Res.Output.Lithosphere.Geonu_Signal.Total.Th232 + Res.Output.Mantle.Geonu_Signal.Total.Th232;
pd = fitdist(th232(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(th232, 'BinWidth', 1);
title("Geonu Signal Distribution for 232Th");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
% 设置横轴和纵轴刻度间隔为 5
xticks(0:5:100);  % 横轴从 0 到 80，间隔为 5
grid on;
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
pic_path = sprintf('./Pics/Geonu_Signals_232Th_%s.jpg', name);
print(pic_path, '-djpeg', '-r500');

end