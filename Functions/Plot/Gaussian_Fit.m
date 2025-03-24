function [total, lith, mantle] = Gaussian_Fit(file_path)
% ~~~~~~~~~~~~~~~~~~~~~~~~ Load Data ~~~~~~~~~~~~~~~~~~~~~~~~ %
Res = load(file_path);
temp_lith = Res.Output.Lithosphere.Geonu_Signal.Total.Total;
temp_man = Res.Output.Mantle.Geonu_Signal.Total.Total;
temp_total = temp_lith + temp_man;
% ~~~~~~~~~~~~~~~~~~~~~~~~ Fit Data ~~~~~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(temp_lith(:, 1), 'Normal');
lith(1, 1) = pd.mu;
lith(2, 1) = pd.sigma;
pd = fitdist(temp_man(:, 1), 'Normal');
mantle(1, 1) = pd.mu;
mantle(2, 1) = pd.sigma;
pd = fitdist(temp_total(:, 1), 'Normal');
total(1, 1) = pd.mu;
total(2, 1) = pd.sigma;
% ~~~~~~~~~~~~~~~~~~~~~~~~ Clear Variables ~~~~~~~~~~~~~~~~~~~~~~~~ %
clear Res temp_lith temp_man temp_total pd;

end