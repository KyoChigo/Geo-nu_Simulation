function Plot_All_Experiments(Items)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Plot_All_Experiments.m
% Description     : Plot the predictions for all detectors
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - Items       : Array of files
%
% Created On      : 2025-03-21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Define Results ~~~~~~~~~~~~~~~~~~~~ %
template = zeros(length(Items), 1);
total = template;
total_error = template;
lith = template;
lith_error = template;
Names = strings(length(Items), 1);
% ~~~~~~~~~~~~~~~~~~~~ Loop ~~~~~~~~~~~~~~~~~~~~ %
for ii1 = 1 : length(Items)
    item = Items(ii1, :);
    name_detector = item{1};
    file_path = item{2};
    [temp_total, temp_lith, temp_man] = Gaussian_Fit(file_path);
    total(ii1, 1) = temp_total(1, 1);
    total_error(ii1, 1) = temp_total(2, 1);
    lith(ii1, 1) = temp_lith(1, 1);
    lith_error(ii1, 1) = temp_lith(2, 1);
    Names(ii1, 1) = name_detector;
end
% ~~~~~~~~~~~~~~~~~~~~ Plot ~~~~~~~~~~~~~~~~~~~~ %
figure;
hold on;
grid on;
% % ~~~~~~~~~~~~~~~~~~~~~~~~ Grid Setting ~~~~~~~~~~~~~~~~~~~~~~~~ %
% % % Setup line style of grid % % %
set(gca, 'GridLineStyle', '-');  % Solid line %
set(gca, 'GridAlpha', 0.5);      % Alpha %
set(gca, 'LineWidth', 0.5);      % Linde width %

% % % Setup minor grid line style % % %
set(gca, 'MinorGridLineStyle', '-');  % Solid line %
set(gca, 'MinorGridAlpha', 0.3);      % Alpha %
set(gca, 'LineWidth', 0.5);           % Linde width %

% % % Use Minor ticks % % %
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');


% % ~~~~~~~~~~~~~~~~~~~~~~~~ Errorbar ~~~~~~~~~~~~~~~~~~~~~~~~ % %
% % Marker Setting % %
marker_styles = {'o', 's', 'd', '^', 'v', 'p', 'h', 'x', '*'};
colors = lines(length(Items));

legend_entries = [];

for ii1 = 1:length(Items)
    marker_idx = mod(ii1 - 1, length(marker_styles)) + 1;
    marker = marker_styles{marker_idx};

    % Vertical errorbar %
    h = errorbar(lith(ii1), total(ii1), total_error(ii1), 'Vertical', ...
        'LineWidth', 1.5, 'Color', colors(ii1, :), ...
        'Marker', marker, 'MarkerSize', 8, 'CapSize', 10, 'LineStyle', 'none');

    % Horizontal errorbar %
    errorbar(lith(ii1), total(ii1), lith_error(ii1), lith_error(ii1), 'Horizontal', ...
        'LineWidth', 1.5, 'Color', colors(ii1, :), ...
        'Marker', marker, 'MarkerSize', 8, 'CapSize', 10, 'LineStyle', 'none');

    legend_entries = [legend_entries, h];
end

% % ~~~~~~~~~~~~~~~~~~~~ Linear Fit ~~~~~~~~~~~~~~~~~~~~ % %
legend(legend_entries, Names, 'Location', 'best', 'FontSize', 10);
% % Linear fit % %
p = polyfit(lith, total, 1);  % lith vs total; Linear fit: y = p(1)*x + p(2) %
x_fit = linspace(0, 80, 100); 
y_fit = polyval(p, x_fit);

% % Plot fitted line % %
plot(x_fit, y_fit, '-k', 'LineWidth', 2);

% % Legends % %
legend_entries = [legend_entries, plot(nan, nan, '-k', 'LineWidth', 2)];
legend_labels = [Names; "Linear Fit"];
legend(legend_entries, legend_labels, 'Location', 'best', 'FontSize', 10);

xlabel('Lithosphere Geonu Signal (TNU)');
ylabel('Total Geonu Signal (TNU)');
xlim([0, 80]);
ylim([0, 80]);
xticks(0:5:80);
yticks(0:5:80);

% ~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~ %
pic_path = sprintf('./Pics/Geonu_Signals_All_Experiments.jpg');
print(pic_path, '-djpeg', '-r500');


end