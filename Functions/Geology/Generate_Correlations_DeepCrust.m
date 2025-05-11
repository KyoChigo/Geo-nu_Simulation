function Geology = Generate_Correlations_DeepCrust(Geology, iteration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Generate_Correlations_DeepCrust.m
% Description     : Generate random correlation coefficients used in deepcrust method
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - Geology     : Geology data structure
%   - iteration   : -
%
% Output Parameters:
%   - Geology     : Geology data structure
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Generate Correlation for Bivart ~~~~~~~~~~~~~~~~~~~~ %
% % ~~~~~~~~~~~~~~~~~~~~ MC ~~~~~~~~~~~~~~~~~~~~ % %
data = Geology.Lithosphere.Model.Data.Bivar.seis.amp.prob;
for i = 1 :length(data(1, :))
    probability = data(:, i);
    probability_normalize = probability(:) / sum(probability(:)); % Normalize every column %
    probability_with_zero = [0; probability_normalize]; % Add 0 at the beginning %
    probability_comulative = cumsum(probability_with_zero); % Get cumulative array %
    probability_comulative(end) = 1e3*eps + probability_comulative(end); % Convert to double float? %
    [~, ~, Geology.Lithosphere.Model.Correlation.MC.DeepCrust.Bivar.SiO2(:, i)] = histcounts(rand(iteration, 1), probability_comulative);
    % histcounts(data, bins): Fills data into the specified bins; the third
    % output is the index indicating which bin each data point falls into. %

end

% % ~~~~~~~~~~~~~~~~~~~~ LC ~~~~~~~~~~~~~~~~~~~~ % %
data = Geology.Lithosphere.Model.Data.Bivar.seis.gran.prob;
for i = 1 :length(data(1, :))
    probability = data(:, i);
    probability_normalize = probability(:) / sum(probability(:));
    probability_with_zero = [0; probability_normalize];
    probability_comulative = cumsum(probability_with_zero); 
    probability_comulative(end) = 1e3*eps + probability_comulative(end);
    [~, ~, Geology.Lithosphere.Model.Correlation.LC.DeepCrust.Bivar.SiO2(:, i)] = histcounts(rand(iteration, 1), probability_comulative);
end
clear data i probability probability_normalize probability_with_zero probability_comulative

end