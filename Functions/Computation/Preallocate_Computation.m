function Computation = Preallocate_Computation(Geology, Computation)
len = length(Geology.Lithosphere.Model.GeoPhys.latlon);
template = 999 + zeros(len, 3);
template_iteration = 999 + zeros(len, Geology.Iteration);
%%%%%%%%%%%%%%%%% Lithosphere %%%%%%%%%%%%%%%%%%%%%%
layers = {'UC', 'MC', 'LC', 'LM', 's1', 's2', 's3'};
abundance_fields = {'U', 'Th', 'K'};
mass_fields = {'Total', 'U238', 'U235', 'Th232', 'K40', 'K'};
geonu_flux_fields = {'Total', 'U238', 'Th232', 'K40'};
geonu_signal_fields = {'Total', 'U238', 'Th232'};
heat_power_fields = {'Total', 'U238', 'U235', 'U', 'Th232', 'K40', 'K'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
%%% %%% Thickness
    Computation.Lithosphere.(layer).Thickness = template_iteration;
%%% %%% Depth
    Computation.Lithosphere.(layer).Depth = template_iteration;
%%% %%% Radius
    Computation.Lithosphere.(layer).Radius = template_iteration;
%%% %%% Density
    Computation.Lithosphere.(layer).Density = template_iteration;
%%% %%% Volume
    Computation.Lithosphere.(layer).Volume = template_iteration;
%%% %%% Temperature
    Computation.Lithosphere.(layer).Temperature = template_iteration;
%%% %%% Pressure
    Computation.Lithosphere.(layer).Pressure = template_iteration;
%%% %%% Abundance
    for ii2 = 1 : length(abundance_fields)
        field = abundance_fields{ii2};
        Computation.Lithosphere.(layer).Abundance.(field) = template_iteration;
    end
%%% %%% Mass
    for ii2 = 1 : length(mass_fields)
        field = mass_fields{ii2};
        Computation.Lithosphere.(layer).Mass.(field) = template_iteration;
    end
%%% %%% Geonu_Flux
    for ii2 = 1 : length(geonu_flux_fields)
        field = geonu_flux_fields{ii2};
        Computation.Lithosphere.(layer).Geonu_Flux.(field) = template;
    end
%%% %%% Geonu Signal
    for ii2 = 1 : length(geonu_signal_fields)
        field = geonu_signal_fields{ii2};
        Computation.Lithosphere.(layer).Geonu_Signal.(field) = template;
    end
%%% %%% Heat Power
    for ii2 = 1 : length(heat_power_fields)
        field = heat_power_fields{ii2};
        Computation.Lithosphere.(layer).Heat_Power.(field) = template;
    end
end
%%%%%%%%%%%%%%%%% Mantle %%%%%%%%%%%%%%%%%%%%%%%%%%%
end