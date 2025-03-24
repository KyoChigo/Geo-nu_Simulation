function Plot_All_Experiments(Items)
% ~~~~~~~~~~~~~~~~~~~~ Define Results ~~~~~~~~~~~~~~~~~~~~ %
template = zeros(length(Items), 1);
total = template;
total_error = template;
lith = template;
lith_error = template;
Names = strings(length(Items), 1);;
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
% 设置主网格线样式
set(gca, 'GridLineStyle', '-');  % 主网格线为实线
set(gca, 'GridAlpha', 0.5);      % 主网格线透明度
set(gca, 'LineWidth', 0.5);      % 主网格线宽度

% 启用次要网格线并调整样式
set(gca, 'MinorGridLineStyle', '-');  % 次要网格线为实线
set(gca, 'MinorGridAlpha', 0.3);     % 次要网格线透明度
set(gca, 'LineWidth', 0.5);           % 次要网格线宽度

% 启用次要刻度线
set(gca, 'XMinorTick', 'on');  % 开启 X 轴次要刻度
set(gca, 'YMinorTick', 'on');  % 开启 Y 轴次要刻度


% % ~~~~~~~~~~~~~~~~~~~~~~~~ Errorbar ~~~~~~~~~~~~~~~~~~~~~~~~ %
% 定义不同的标记形状和颜色
marker_styles = {'o', 's', 'd', '^', 'v', 'p', 'h', 'x', '*'}; % 适用于最多 9 个数据点
colors = lines(length(Items)); % 生成不同颜色
% 存储绘制的句柄用于 legend
legend_entries = [];

for ii1 = 1:length(Items)
    % 选择标记样式
    marker_idx = mod(ii1 - 1, length(marker_styles)) + 1;
    marker = marker_styles{marker_idx};

    % 画竖直 errorbar
    h = errorbar(lith(ii1), total(ii1), total_error(ii1), 'Vertical', ...
        'LineWidth', 1.5, 'Color', colors(ii1, :), ...
        'Marker', marker, 'MarkerSize', 8, 'CapSize', 10, 'LineStyle', 'none');

    % 画水平 errorbar
    errorbar(lith(ii1), total(ii1), lith_error(ii1), lith_error(ii1), 'Horizontal', ...
        'LineWidth', 1.5, 'Color', colors(ii1, :), ...
        'Marker', marker, 'MarkerSize', 8, 'CapSize', 10, 'LineStyle', 'none');

    % 存储 legend 句柄
    legend_entries = [legend_entries, h];
end

% % ~~~~~~~~~~~~~~~~~~~~ Linear Fit ~~~~~~~~~~~~~~~~~~~~ % %
legend(legend_entries, Names, 'Location', 'best', 'FontSize', 10);
% % 线性拟合 % %
p = polyfit(lith, total, 1);  % 线性拟合 lith vs total，得到 y = p(1)*x + p(2) %
x_fit = linspace(0, 80, 100);  % 生成拟合曲线的 x 轴范围 %
y_fit = polyval(p, x_fit);  % 计算拟合曲线的 y 值 %

% % 绘制拟合直线 % %
plot(x_fit, y_fit, '-k', 'LineWidth', 2); % 黑色虚线，线宽 2 %

% % 添加图例 % %
legend_entries = [legend_entries, plot(nan, nan, '-k', 'LineWidth', 2)]; % 用于 legend 显示拟合直线 %
legend_labels = [Names; "Linear Fit"];
legend(legend_entries, legend_labels, 'Location', 'best', 'FontSize', 10);

xlabel('Lithosphere Geonu Signal (TNU)');
ylabel('Total Geonu Signal (TNU)');
xlim([0, 80]);
ylim([0, 80]);
% 设置横轴和纵轴刻度间隔为 5
xticks(0:5:80);  % 横轴从 0 到 80，间隔为 5
yticks(0:5:80);  % 纵轴从 0 到 80，间隔为 5

% ~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~ %
pic_path = sprintf('./Pics/Geonu_Signals_All_Experiments.jpg');
print(pic_path, '-djpeg', '-r500');


end