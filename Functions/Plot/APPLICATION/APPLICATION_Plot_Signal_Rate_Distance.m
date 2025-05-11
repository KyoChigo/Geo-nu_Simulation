function APPLICATION_Plot_Signal_Rate_Distance(index, file_path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : APPLICATION_Plot_Signal_Rate_Distance.m
% Description     : Plot the signal rate as a function of distance
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - index       : Index of cases
%   - file_path   : Path to the file
%
% Created On      : 2025-04-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Res = load(file_path);
[~, name, ~] = fileparts(file_path);
% ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
clear Distance signal flux;
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    Distance(:, ii1) = Res.Output.Lithosphere.Distance.(layer) ./ 1e3;
    signal(:, ii1) = Res.Output.Lithosphere.Geonu_Signal.(layer).Total(:, index);
    flux(:, ii1) = Res.Output.Lithosphere.Geonu_Flux.(layer).Total(:, index);
end

% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ %
layers = {'Depleted', 'Enriched'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    Distance(:, end + 1) = mean(Res.Output.Mantle.Distance.(layer), 2) ./1e3;
    signal(:, end + 1) = Res.Output.Mantle.Geonu_Signal.(layer).Total(:, index);
    flux(:, end + 1) = Res.Output.Mantle.Geonu_Flux.(layer).Total(:, index);
end

% ~~~~~~~~~~~~~~~~~~~~ Cumulative Plot: Signal Rate ~~~~~~~~~~~~~~~~~~~~ %
% Define bins
edges = logspace(log10(10), log10(2e4), 400);  % 400 bins %
signal_binned = zeros(length(edges)-1, 9);
distance_centers = (edges(1:end-1) + edges(2:end)) / 2;

for ii1 = 1 : 9
    D = Distance(:, ii1);
    S = signal(:, ii1);

    % Clean data %
    valid_idx = (D > 0) & (S > 0);
    D = D(valid_idx);
    S = S(valid_idx);

    % Sum values for each bin %
    [~, ~, bin_idx] = histcounts(D, edges);
    for ii2 = 1 : length(bin_idx)
        if bin_idx(ii2) > 0
            signal_binned(bin_idx(ii2), ii1) = signal_binned(bin_idx(ii2), ii1) + S(ii2);
        end
    end
end

% Add up %
signal_sed    = sum(signal_binned(:, 1:3), 2);
signal_crust  = sum(signal_binned(:, 4:7), 2);
signal_mantle = sum(signal_binned(:, 8:9), 2);
signal_total  = sum(signal_binned, 2);

% Cumulative values %
cumsum_sed    = cumsum(signal_sed);
cumsum_crust  = cumsum(signal_crust);
cumsum_mantle = cumsum(signal_mantle);
cumsum_total = cumsum(signal_total);
sum_total  = sum(signal_total);  % Denominator %

% Convert to percentage %
pct_sed    = 100 * cumsum_sed    ./ sum_total;
pct_crust  = 100 * cumsum_crust  ./ sum_total;
pct_mantle = 100 * cumsum_mantle ./ sum_total;
pct_total = 100 * cumsum_total ./ sum_total;

% % ~~~~~~~~~~~~~~~~~~~~ Plot: Cumulative (TNU) ~~~~~~~~~~~~~~~~~~~~ % %
figure; hold on;
% Plot absolute signal values (cumulative signal) %
plot(distance_centers, cumsum_sed,    'g',  'LineWidth', 2);
plot(distance_centers, cumsum_crust,  'r',  'LineWidth', 2);
plot(distance_centers, cumsum_mantle, 'b',  'LineWidth', 2);
plot(distance_centers, cumsum_total, 'k--',  'LineWidth', 2);

set(gca, 'XScale', 'log');
xlim([10, 2e4]);
xlabel("Distance (km)");
ylabel("Cumulative Signal (TNU)");
legend("Sediment", "Crust+LM", "Mantle", "Total", 'Location', 'northwest');
grid on;
title("Cumulative Signal vs Distance (Absolute)");
% % % ~~~~~~~~~~~~~~~~~~~~ Save ~~~~~~~~~~~~~~~~~~~~ % % %
pic_path = sprintf('./Pics/APPLICATION/Geonu_Signals_Rate_Abs_index_%d_%s.jpg', index, name);
print(pic_path, '-djpeg', '-r500');

% % ~~~~~~~~~~~~~~~~~~~~ Plot: Cumulative (%) ~~~~~~~~~~~~~~~~~~~~ % %
% plot %
figure; hold on;
plot(distance_centers, pct_sed,    'g',  'LineWidth', 2);
plot(distance_centers, pct_crust,  'r',  'LineWidth', 2);
plot(distance_centers, pct_mantle, 'b',  'LineWidth', 2);
plot(distance_centers, pct_total, 'k--',  'LineWidth', 2);

set(gca, 'XScale', 'log');
% set(gca, 'YScale', 'log');
xlim([10, 2e4]);
ylim([0, 105]);
xlabel("Distance (km)");
ylabel("Cumulative Signal Rate (%)");
legend("Sediment", "Crust+LM", "Mantle","Total", 'Location', 'northwest');
yticks(0:5:100);  % x ticks: 5 units %
grid on;
title("Cumulative Signal Rate vs Distance (Percentage)");

% % % ~~~~~~~~~~~~~~~~~~~~ Save ~~~~~~~~~~~~~~~~~~~~ % % %
pic_path = sprintf('./Pics/APPLICATION/Geonu_Signals_Rate_Percent_index_%d_%s.jpg', index, name);
print(pic_path, '-djpeg', '-r500');

% ~~~~~~~~~~~~~~~~~~~~ Cumulative Plot: Flux ~~~~~~~~~~~~~~~~~~~~ %
flux = flux ./ 1e6;
edges = logspace(log10(10), log10(2e4), 400);  % 400 bins %
flux_binned = zeros(length(edges)-1, 9);
distance_centers = (edges(1:end-1) + edges(2:end)) / 2;

for ii1 = 1 : 9
    D = Distance(:, ii1);
    F = flux(:, ii1);

    % Clean data %
    valid_idx = (D > 0) & (F > 0);
    D = D(valid_idx);
    F = F(valid_idx);

    % Sum values for each bin %
    [~, ~, bin_idx] = histcounts(D, edges);
    for ii2 = 1 : length(bin_idx)
        if bin_idx(ii2) > 0
            flux_binned(bin_idx(ii2), ii1) = flux_binned(bin_idx(ii2), ii1) + F(ii2);
        end
    end
end
% Add up %
flux_sed    = sum(flux_binned(:, 1:3), 2);
flux_crust  = sum(flux_binned(:, 4:7), 2);
flux_mantle = sum(flux_binned(:, 8:9), 2);
flux_total  = sum(flux_binned, 2);
sum_total = sum(flux_total, 1);

% Convert flux to percentage (cumulative flux) %
cumsum_flux_sed    = cumsum(flux_sed);
cumsum_flux_crust  = cumsum(flux_crust);
cumsum_flux_mantle = cumsum(flux_mantle);
cumsum_flux_total  = cumsum(flux_total);

pct_flux_sed    = 100 * cumsum_flux_sed    ./ sum_total;
pct_flux_crust  = 100 * cumsum_flux_crust  ./ sum_total;
pct_flux_mantle = 100 * cumsum_flux_mantle ./ sum_total;
pct_flux_total = 100 * cumsum_flux_total ./ sum_total;

% % ~~~~~~~~~~~~~~~~~~~~ Plot: Cumulative (cm^-2s^-1) ~~~~~~~~~~~~~~~~~~~~ % %
% Plot the cumulative flux in absolute units (TNU) %
figure; hold on;

% Plot absolute flux values (cumulative flux) %
plot(distance_centers, cumsum_flux_sed,    'g',  'LineWidth', 2);
plot(distance_centers, cumsum_flux_crust,  'r',  'LineWidth', 2);
plot(distance_centers, cumsum_flux_mantle, 'b',  'LineWidth', 2);
plot(distance_centers, cumsum_flux_total, 'k--',  'LineWidth', 2);

set(gca, 'XScale', 'log');
xlim([10, 2e4]);
xlabel("Distance (km)");
ylabel('Cumulative Flux/1e6 $(cm^{-2}s^{-1})$', 'Interpreter', 'latex');
legend("Sediment", "Crust+LM", "Mantle", "Total", 'Location', 'northwest');
grid on;
title("Cumulative Flux vs Distance (Absolute)");
% % % ~~~~~~~~~~~~~~~~~~~~ Save ~~~~~~~~~~~~~~~~~~~~ % % %
pic_path = sprintf('./Pics/APPLICATION/Geonu_Flux_Abs_index_%d_%s.jpg', index, name);
print(pic_path, '-djpeg', '-r500');

% Plot percentage flux data %
figure; hold on;
plot(distance_centers, pct_flux_sed,    'g',  'LineWidth', 2);
plot(distance_centers, pct_flux_crust,  'r',  'LineWidth', 2);
plot(distance_centers, pct_flux_mantle, 'b',  'LineWidth', 2);
plot(distance_centers, pct_flux_total, 'k--',  'LineWidth', 2);

set(gca, 'XScale', 'log');
xlim([10, 2e4]);
ylim([0, 105]);
xlabel("Distance (km)");
ylabel("Cumulative Flux (%)");
legend("Sediment", "Crust+LM", "Mantle", "Total", 'Location', 'northwest');
yticks(0:5:100);  % y ticks for percentage (left axis) %
grid on;
title("Cumulative Flux vs Distance (Percentage)");
% % % ~~~~~~~~~~~~~~~~~~~~ Save ~~~~~~~~~~~~~~~~~~~~ % % %
pic_path = sprintf('./Pics/APPLICATION/Geonu_Flux_Percent_index_%d_%s.jpg', index, name);
print(pic_path, '-djpeg', '-r500');

end