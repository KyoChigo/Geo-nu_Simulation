%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Structure_Output.m
% Description     : Define data structure of Output
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units  :
%   - Signal Rate       : TNU
%   - Geonu Flux        : cm^{-2}s^{-1}
%   - Radiogenic Power  : TW
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
% % Radiogenic Power, Geonu Flux and Geonu Signal % %
Interests_fields = {'Geonu_Flux', 'Geonu_Signal', 'Geonu_Spectrum'};
Layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM', 'Total'};
Items_fields = {'Total', 'U238', 'Th232', 'K40'};
for ii1 = 1 : length(Interests_fields)
    interest = Interests_fields{ii1};
    for ii2 = 1 : length(Layers)
        layer = Layers{ii2};
            for ii3 = 1 : length(Items_fields)
                item = Items_fields{ii3};
                Output.Lithosphere.(interest).(layer).(item) = 'Record';
            end % ii3 for item
    end % ii2 for layers
end % ii1 for Interests

% % Mass % %
Interests_fields = {'Mass', 'Heat_Power'};
Items_fields = {'Total', 'U', 'Th', 'K'};
for ii1 = 1 : length(Interests_fields)
    interest = Interests_fields{ii1};
    for ii2 = 1 : length(Layers)
    layer = Layers{ii2};
        for ii3 = 1 : length(Items_fields)
            item = Items_fields{ii3};
            Output.Lithosphere.(interest).(layer).(item) = 'Record';
        end
    end
end
clear Interests_fields Layers State_fields Items_fields 
clear interest layer state item;
clear ii1 ii2 ii3

% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ %
% % Geonu Signal % %
Interests_fields = {'Geonu_Signal', 'Geonu_Spectrum', 'Geonu_Flux'};
Layers = {'Depleted', 'Enriched', 'Total'};
Items_fields = {'Total', 'U238', 'Th232'};
for ii1 = 1 : length(Interests_fields)
    interest = Interests_fields{ii1};
    for ii2 = 1 : length(Layers)
        layer = Layers{ii2};
        for ii3 = 1 : length(Items_fields)
            item = Items_fields{ii3};
            Output.Mantle.(interest).(layer).(item) = 'Record';
        end
    end
end

% % Radiogenic Power % %
Interests_fields = {'Heat_Power'};
Layers = {'Depleted', 'Enriched', 'Total'};
Items_fields = {'Total', 'U', 'Th', 'K'};
for ii1 = 1 : length(Interests_fields)
    interest = Interests_fields{ii1};
    for ii2 = 1 : length(Layers)
    layer = Layers{ii2};
        for ii3 = 1 : length(Items_fields)
            item = Items_fields{ii3};
            Output.Mantle.(interest).(layer).(item) = 'Record';
        end
    end
end

clear Interests_fields interest Layers layer Items_fields item;
clear ii1 ii2 ii3;

