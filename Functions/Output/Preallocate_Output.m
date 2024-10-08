function Output = Prellocate_Output(Output, Physics, Geology)
energy = Physics.Cross_Section.Energy;
iteration = Geology.Iteration;
template = zeros(iteration, length(energy));
%%% Prellocate
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
                Output.Lithosphere.(interest).(layer).(state).(item) = template;
            end % ii4 for item
        end % ii3 for stytle
    end % ii2 for layers
end % ii1 for Interests
end