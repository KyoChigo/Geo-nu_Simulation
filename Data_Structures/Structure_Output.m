%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Run Info %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Output.Run_Info.Oscillation_Parameter = 'later';
Output.Run_Info.Iteration = 'later';
Output.Run_Info.Abundance = 'later';
Output.Run_Info.Method = 'later';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Lithosphere %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Interests_fields = {'Mass', 'Heat_Power', 'Geonu_Flux', 'Geonu_Signal'};
Layers = {'UC', 'MC', 'LC', 'LM', 's1', 's2', 's3', 'Near_Field'};
State_fields = {'OC', 'CC'};
Items_fields = {'Total', 'U', 'Th', 'K'};
for ii1 = 1 : length(Interests_fields)
    interest = Interests_fields{ii1};
    for ii2 = 1 : length(Layers)
        layer = Layers{ii2};
        for ii3 = 1 : length(State_fields)
            state = State_fields{ii3};
            for ii4 = 1 : length(Items_fields)
                item = Items_fields{ii4};
                Output.Lithosphere.(interest).(layer).(state).(item) = 'Preallocate_Output->';
            end % ii4 for item
        end % ii3 for stytle
    end % ii2 for layers
end % ii1 for Interests

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Mantle %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ii1 = 1 : length(Interests_fields)
    interest = Interests_fields{ii1};
    Output.Mantle.(interest) = 'Preallocate_Output->';
end

clear Interests_fields Layers State_fields Items_fields 
clear interest layer state item;
clear ii1 ii2 ii3 ii4