file_dir = "./Input_Files/IBD-Cross-Section/";

years = ["Approximation", "1999", "2003", "2022"];

ibd_data = cell(1, length(years));

for index = 1 : length(years)
    year = years(index);
    file_path = fullfile(file_dir, strcat("IBD_", year, ".csv"));
    ibd_data{index} = readmatrix(file_path);
end

ibds(:, 1) = ibd_data{1}(:, 1);
ibds(:, 2) = ibd_data{1}(:, 2);
ibds(:, 3) = ibd_data{2}(:, 2);
ibds(:, 4) = ibd_data{3}(:, 2);
ibds(:, 5) = ibd_data{4}(:, 2);

energy_zero = (0.0000:0.0005:1.8055)';
zero_block = [energy_zero, zeros(length(energy_zero), 4)];

% 找到 1.8065 到 4.5005 的索引范围
start_idx = find(abs(ibds(:,1) - 1.8060) < 1e-6);
end_idx   = find(abs(ibds(:,1) - 4.5005) < 1e-6);

% 提取并每两个点取一个
ibds_trimmed = ibds(start_idx:1:end_idx, :);

IBD_Cross_Section = [zero_block; ibds_trimmed];