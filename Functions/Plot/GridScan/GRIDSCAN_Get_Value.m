function [res] = GRIDSCAN_Get_Value(file_path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : GRIDSCAN_Get_Value.m
% Description     : Get the best result
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - file_path   : Path to file
%
% Output Parameters:
%   - res         : Best result
%
% Created On      : 2025-03-30
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Res = load(file_path);
    total = Res.Output.Lithosphere.Geonu_Signal.Total.Total + Res.Output.Mantle.Geonu_Signal.Total.Total;
    pd = fitdist(total(:, 1), 'Normal');
    res(1, 1) = Res.Physics.Oscillation.Parameters.delta_m21_square;
    res(1, 2) = Res.Physics.Oscillation.Parameters.sin_theta12_square;
    res(1, 3) = pd.mu;
    res(1, 4) = pd.sigma;
    clear Res total pd total;
end