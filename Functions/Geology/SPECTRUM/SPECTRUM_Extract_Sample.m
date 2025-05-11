function Geology = SPECTRUM_Extract_Sample(index, Geology)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : SPECTRUM_Abstract.m
% Description     : Extract all information from a single random sampling in Geology
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - index                 : Index of the grid cell
%   - Geology               : Geology data structure
%
% Output Parameters:
%   - Geology               : Extracted Geology data structure
%
% Created On      : 2025-04-16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Geology.Iteration = 1;
% ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
items = {'Abundance', 'Thickness', 'Vp'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    for ii2 = 1 : length(items)
        item = items{ii2};
        Geology.Lithosphere.Model.Correlation.(layer).(item) = Geology.Lithosphere.Model.Correlation.(layer).(item)(index, :);
    end
end
layers = {'MC', 'LC'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.End.Abundance = Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.End.Abundance(index, :);
    Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.End.Vp = Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.End.Vp(index, :);
    Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.Bivar.Abundance = Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.Bivar.Abundance(index, :);
    Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.Bivar.SiO2 = Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.Bivar.SiO2(index, :);
end
rocks = {'Amphibolite', 'Granulite'};
components = {'Felsic', 'Mafic'};
elements = {'U', 'Th', 'K'};
for ii1 = 1 : length(rocks)
    rock = rocks{ii1};
    for ii2 = 1 : length(components)
        component = components{ii2};
        for ii3 = 1 : length(elements)
            element = elements{ii3};
            Geology.Lithosphere.Model.DeepCrust.(rock).(component).(element) = Geology.Lithosphere.Model.DeepCrust.(rock).(component).(element)(index, :);
        end
    end
end
% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ %
Geology.Mantle.Correlation = Geology.Mantle.Correlation(index, :);

% ~~~~~~~~~~~~~~~~~~~~ BSE ~~~~~~~~~~~~~~~~~~~~ %
Geology.BSE.Correlation = Geology.BSE.Correlation(index, :);
elements = {'U', 'Th', 'K'};
for ii1 = 1 : length(elements)
    element = elements{ii1};
    Geology.BSE.Abundance.(element) = Geology.BSE.Abundance.(element)(index, :);
end

end