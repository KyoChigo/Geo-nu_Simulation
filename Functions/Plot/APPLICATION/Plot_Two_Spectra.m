function Plot_Two_Spectra(Yufeng_file, Enomoto_file)

Res1 = load(Yufeng_file);
Res2 = load(Enomoto_file);

[~, name1, ~] = fileparts(Yufeng_file);
[~, name2, ~] = fileparts(Enomoto_file);

sig_lith_1 = Res1.Output.Lithosphere.Geonu_Signal.Total.Total;
sig_lith_2 = Res2.Output.Lithosphere.Geonu_Signal.Total.Total;
sig_man_1 = Res1.Output.Mantle.Geonu_Signal.Total.Total;
sig_man_2 = Res2.Output.Mantle.Geonu_Signal.Total.Total;
sig_total_1 = sig_lith_1 + sig_man_1;
sig_total_2 = sig_lith_2 + sig_man_2;

sig_man_1 = sig_man_1(sig_man_1 ~= 0);
sig_man_2 = sig_man_2(sig_man_2 ~= 0);
sig_total_1 = sig_total_1(sig_total_1 ~= 0);
sig_total_2 = sig_total_2(sig_total_2 ~= 0);

sig_u238_1 = Res1.Output.Lithosphere.Geonu_Signal.Total.U238 + Res1.Output.Mantle.Geonu_Signal.Total.U238;
sig_u238_2 = Res2.Output.Lithosphere.Geonu_Signal.Total.U238 + Res2.Output.Mantle.Geonu_Signal.Total.U238;
sig_th232_1 = Res1.Output.Lithosphere.Geonu_Signal.Total.Th232 + Res1.Output.Mantle.Geonu_Signal.Total.Th232;
sig_th232_2 = Res2.Output.Lithosphere.Geonu_Signal.Total.Th232 + Res2.Output.Mantle.Geonu_Signal.Total.Th232;

% ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
figure;
hold on;
% % Histogram % %
histogram(sig_lith_1, 'BinWidth', 1, 'EdgeColor', 'b', 'LineWidth', 1.5, ...
    'FaceAlpha', 0.9, 'DisplayName', 'Yufeng');
histogram(sig_lith_2, 'BinWidth', 1, 'EdgeColor', 'r', 'LineWidth', 1.5, ...
    'FaceAlpha', 0, 'DisplayName', 'Enomoto');
% % Labels % %
xlabel('Geoneutrino Signal Rate (TNU)');
ylabel('Entries');
title('Comparison of Lithosphere Geoneutrino Signal Rates');
% % Range and Ticks % %
xlim([0, 100]);
xticks(0 : 5 : 100);
legend('Location', 'best');
grid on;
% % Fit Info % %
pd1 = fitdist(sig_lith_1, 'Normal');
pd2 = fitdist(sig_lith_2, 'Normal');
parameter_tex = sprintf('Yufeng: %.2f_{-%.2f}^{+%.2f} TNU\n Enomoto: %.2f_{-%.2f}^{+%.2f} TNU', pd1.mu, pd1.sigma, pd1.sigma, pd2.mu, pd2.sigma, pd2.sigma);
y_lim = ylim;
x_pos = 55;
y_pos = y_lim(2) * 0.7;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
hold off;
% % Output % %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_Lithosphere_%s_%s.jpg', name1, name2);
print(pic_path, '-djpeg', '-r500');

% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ %
figure;
hold on;
% % Histogram % %
histogram(sig_man_1, 'BinWidth', 1, 'EdgeColor', 'b', 'LineWidth', 1.5, ...
    'FaceAlpha', 0.9, 'DisplayName', 'Yufeng');
histogram(sig_man_2, 'BinWidth', 1, 'EdgeColor', 'r', 'LineWidth', 1.5, ...
    'FaceAlpha', 0, 'DisplayName', 'Enomoto');
% % Labels % %
xlabel('Geoneutrino Signal Rate (TNU)');
ylabel('Entries');
title('Comparison of Mantle Geoneutrino Signal Rates');
% % Range and Ticks % %
xlim([0, 100]);
xticks(0 : 5 : 100);
legend('Location', 'best');
grid on;
% % Fit Info % %
pd1 = fitdist(sig_man_1, 'Normal');
pd2 = fitdist(sig_man_2, 'Normal');
parameter_tex = sprintf('Yufeng: %.2f_{-%.2f}^{+%.2f} TNU\n Enomoto: %.2f_{-%.2f}^{+%.2f} TNU', pd1.mu, pd1.sigma, pd1.sigma, pd2.mu, pd2.sigma, pd2.sigma);
y_lim = ylim;
x_pos = 55;
y_pos = y_lim(2) * 0.7;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
hold off;
% % Output % %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_Mantle_%s_%s.jpg', name1, name2);
print(pic_path, '-djpeg', '-r500');

% ~~~~~~~~~~~~~~~~~~~~ Total ~~~~~~~~~~~~~~~~~~~~ %
figure;
hold on;
% % Histogram % %
histogram(sig_total_1, 'BinWidth', 1, 'EdgeColor', 'b', 'LineWidth', 1.5, ...
    'FaceAlpha', 0.9, 'DisplayName', 'Yufeng');
histogram(sig_total_2, 'BinWidth', 1, 'EdgeColor', 'r', 'LineWidth', 1.5, ...
    'FaceAlpha', 0, 'DisplayName', 'Enomoto');
% % Labels % %
xlabel('Geoneutrino Signal Rate (TNU)');
ylabel('Entries');
title('Comparison of Total Geoneutrino Signal Rates');
% % Range and Ticks % %
xlim([0, 100]);
xticks(0 : 5 : 100);
legend('Location', 'best');
grid on;
% % Fit Info % %
pd1 = fitdist(sig_total_1, 'Normal');
pd2 = fitdist(sig_total_2, 'Normal');
parameter_tex = sprintf('Yufeng: %.2f_{-%.2f}^{+%.2f} TNU\n Enomoto: %.2f_{-%.2f}^{+%.2f} TNU', pd1.mu, pd1.sigma, pd1.sigma, pd2.mu, pd2.sigma, pd2.sigma);
y_lim = ylim;
x_pos = 55;
y_pos = y_lim(2) * 0.7;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
hold off;
% % Output % %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_Total_%s_%s.jpg', name1, name2);
print(pic_path, '-djpeg', '-r500');

% ~~~~~~~~~~~~~~~~~~~~ U238 ~~~~~~~~~~~~~~~~~~~~ %
figure;
hold on;
% % Histogram % %
histogram(sig_u238_1, 'BinWidth', 1, 'EdgeColor', 'b', 'LineWidth', 1.5, ...
    'FaceAlpha', 0.9, 'DisplayName', 'Yufeng');
histogram(sig_u238_2, 'BinWidth', 1, 'EdgeColor', 'r', 'LineWidth', 1.5, ...
    'FaceAlpha', 0, 'DisplayName', 'Enomoto');
% % Labels % %
xlabel('Geoneutrino Signal Rate (TNU)');
ylabel('Entries');
title('Comparison of 238U Geoneutrino Signal Rates');
% % Range and Ticks % %
xlim([0, 100]);
xticks(0 : 5 : 100);
legend('Location', 'best');
grid on;
% % Fit Info % %
pd1 = fitdist(sig_u238_1, 'Normal');
pd2 = fitdist(sig_u238_2, 'Normal');
parameter_tex = sprintf('Yufeng: %.2f_{-%.2f}^{+%.2f} TNU\n Enomoto: %.2f_{-%.2f}^{+%.2f} TNU', pd1.mu, pd1.sigma, pd1.sigma, pd2.mu, pd2.sigma, pd2.sigma);
y_lim = ylim;
x_pos = 55;
y_pos = y_lim(2) * 0.7;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
hold off;
% % Output % %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_238U_%s_%s.jpg', name1, name2);
print(pic_path, '-djpeg', '-r500');

% ~~~~~~~~~~~~~~~~~~~~ Th232 ~~~~~~~~~~~~~~~~~~~~ %
figure;
hold on;
% % Histogram % %
histogram(sig_th232_1, 'BinWidth', 1, 'EdgeColor', 'b', 'LineWidth', 1.5, ...
    'FaceAlpha', 0.9, 'DisplayName', 'Yufeng');
histogram(sig_th232_2, 'BinWidth', 1, 'EdgeColor', 'r', 'LineWidth', 1.5, ...
    'FaceAlpha', 0, 'DisplayName', 'Enomoto');
% % Labels % %
xlabel('Geoneutrino Signal Rate (TNU)');
ylabel('Entries');
title('Comparison of 232Th Geoneutrino Signal Rates');
% % Range and Ticks % %
xlim([0, 100]);
xticks(0 : 5 : 100);
legend('Location', 'best');
grid on;
% % Fit Info % %
pd1 = fitdist(sig_th232_1, 'Normal');
pd2 = fitdist(sig_th232_2, 'Normal');
parameter_tex = sprintf('Yufeng: %.2f_{-%.2f}^{+%.2f} TNU\n Enomoto: %.2f_{-%.2f}^{+%.2f} TNU', pd1.mu, pd1.sigma, pd1.sigma, pd2.mu, pd2.sigma, pd2.sigma);
y_lim = ylim;
x_pos = 55;
y_pos = y_lim(2) * 0.7;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
hold off;
% % Output % %
pic_path = sprintf('./Pics/Geonu_Signal_Rate_232Th_%s_%s.jpg', name1, name2);
print(pic_path, '-djpeg', '-r500');

end