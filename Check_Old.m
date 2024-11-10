%%%%%%%%%%%%%%%%% s1
temp_sum = s1_cc_sums + s1_oc_sums;
%%%%%%%%%%%%%%%%% s2
temp_sum = s2_cc_sums + s2_oc_sums;
%%%%%%%%%%%%%%%%% s3
temp_sum = s3_cc_sums + s3_oc_sums;
%%%%%%%%%%%%%%%%% Sediment
temp_sum = s1_cc_sums + s1_oc_sums + s2_cc_sums + s2_oc_sums + s3_cc_sums + s3_oc_sums;
%%%%%%%%%%%%%%%%% UC
temp_sum = UC_cc_sums + UC_oc_sums;
%%%%%%%%%%%%%%%%% MC
temp_sum = MC_cc_sums + MC_oc_sums;
%%%%%%%%%%%%%%%%% LC
temp_sum = LC_cc_sums + LC_oc_sums;
%%%%%%%%%%%%%%%%% Crust
temp_sum = UC_cc_sums + UC_oc_sums + MC_cc_sums + MC_oc_sums + LC_cc_sums + LC_oc_sums;
%%%%%%%%%%%%%%%%% Sediment + Crust
temp_sum = UC_cc_sums + UC_oc_sums + MC_cc_sums + MC_oc_sums + LC_cc_sums + LC_oc_sums + s1_cc_sums + s1_oc_sums + s2_cc_sums + s2_oc_sums + s3_cc_sums + s3_oc_sums;

temp_ratio = temp_sum .* 0;
temp_ratio(:, 1) = temp_sum(:, 2) ./ temp_sum(:, 1);
temp_ratio(:, 2) = temp_sum(:, 3) ./ temp_sum(:, 1);
temp_ratio(:, 3) = temp_sum(:, 4) ./ temp_sum(:, 1) ./ 00011959;
temp_ratio(:, 4) = temp_sum(:, 3) ./ temp_sum(:, 2);
temp_ratio(:, 5) = temp_sum(:, 4) ./ temp_sum(:, 2) ./ 00011959;

temp_ratio_new = Total.Mass .* 0;
temp_ratio_new(:, 1) = Total.Mass(:, 2) ./ Total.Mass(:, 1);
temp_ratio_new(:, 2) = Total.Mass(:, 3) ./ Total.Mass(:, 1);
temp_ratio_new(:, 3) = Total.Mass(:, 4) ./ Total.Mass(:, 1) ./ 00011959;
temp_ratio_new(:, 4) = Total.Mass(:, 3) ./ Total.Mass(:, 2);
temp_ratio_new(:, 5) = Total.Mass(:, 4) ./ Total.Mass(:, 2) ./ 00011959;