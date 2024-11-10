function Computation = Preallocate_Computation(Geology, Computation)
len = length(Geology.Lithosphere.Model.GeoPhys.latlon);
template = 0 + zeros(len, 3);
template_iteration = 0 + zeros(len, Geology.Iteration);
%%%%%%%%%%%%%%%%% Lithosphere %%%%%%%%%%%%%%%%%%%%%%
layers = {'UC', 'MC', 'LC', 'LM', 's1', 's2', 's3'};
abundance_fields = {'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
% mass_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
mass_fields = {'Total'};
geonu_flux_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
heat_power_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
% %%% %%% Thickness
%     Computation.Lithosphere.(layer).Thickness = template_iteration;
% %%% %%% Depth
%     Computation.Lithosphere.(layer).Depth = template_iteration;
%%% Radius
    Computation.Lithosphere.(layer).Radius = template_iteration;
% %%% %%% Density
%     Computation.Lithosphere.(layer).Density = template_iteration;
% %%% %%% Volume
%     Computation.Lithosphere.(layer).Volume = template_iteration;
% %%% %%% Temperature
%     Computation.Lithosphere.(layer).Temperature = template_iteration;
% %%% %%% Pressure
%     Computation.Lithosphere.(layer).Pressure = template_iteration;
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
% %%% %%% Geonu_Flux
%     for ii2 = 1 : length(geonu_flux_fields)
%         field = geonu_flux_fields{ii2};
%         Computation.Lithosphere.(layer).Geonu_Flux.(field) = template_iteration;
%     end
% %%% %%% Heat Power
%     for ii2 = 1 : length(heat_power_fields)
%         field = heat_power_fields{ii2};
%         Computation.Lithosphere.(layer).Heat_Power.(field) = template_iteration;
%     end
end
clear template template_iteration;
clear layers abundance_fields mass_fields geonu_flux_fields heat_power_fields;
clear ii1 layer;
%%%%%%%%%%%%%%%%% Mantle %%%%%%%%%%%%%%%%%%%%%%%%%%%
iteration = Geology.Iteration;
template = 0 + zeros(iteration, 1);
%%% %%% Abundance
abundance_fields = {'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
for ii1 = 1 : length(abundance_fields)
    field = abundance_fields{ii1};
    Computation.Mantle.Abundance.Depleted.(field) = template;
    Computation.Mantle.Abundance.Enriched.(field) = template;
end
%%% %%% Mass
mass_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
for ii1 = 1 : length(mass_fields)
    field = mass_fields{ii1};
    Computation.Mantle.Mass.Depleted.(field) = template;
    Computation.Mantle.Mass.Enriched.(field) = template;
end
%%% %%% Geonu Flux
geonu_flux_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
for ii1 = 1 : length(mass_fields)
    field = geonu_flux_fields{ii1};
    Computation.Mantle.Geonu_Flux.Depleted.(field) = template;
    Computation.Mantle.Geonu_Flux.Enriched.(field) = template;
end
%%% %%% Heat Power
heat_power_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
for ii1 = 1 : length(mass_fields)
    field = heat_power_fields{ii1};
    Computation.Mantle.Heat_Power.Depleted.(field) = template;
    Computation.Mantle.Heat_Power.Enriched.(field) = template;
end
clear template;
clear layers abundance_fields mass_fields geonu_flux_fields heat_power_fields;
clear ii1 layer;
%%%%%%%%%%%%%%%%% Other 
end