%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Run Info %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Computation.Run_Info.Iteration = 'Fill_Computation()';
Computation.Run_Info.Method.Near_Field = 'Fill_Computation()';
Computation.Run_Info.Method.Deep_Crust = 'Fill_Computation()';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Lithosphere %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

layers = {'UC', 'MC', 'LC', 'LM', 's1', 's2', 's3'};
abundance_fields = {'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
mass_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
geonu_flux_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
heat_power_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};

for ii1 = 1:length(layers)
    layer = layers{ii1};
%%% longitude, latitude and radius
    Computation.Lithosphere.(layer).LatLon = 'later';
    Computation.Lithosphere.(layer).Radius = 'later';
%%% Thickness of layers
    Computation.Lithosphere.(layer).Thickness = 'later';
%%% Depth of layers
    Computation.Lithosphere.(layer).Depth = 'later';
%%% Volume of layers
    Computation.Lithosphere.(layer).Volume = 'later';
%%% Temperature of layers
    Computation.Lithosphere.(layer).Temperature = 'later';
%%% Pressure of layers
    Computation.Lithosphere.(layer).Pressure = 'later';
%%% Abundance of layers
    for ii2 = 1 : length(abundance_fields)
        field = abundance_fields{ii2};
        Computation.Lithosphere.(layer).Abundance.(field) = 'later';
    end % ii2 loop of abundance
%%% Density of layers
    Computation.Lithosphere.(layer).Density = 'later';
%%% Mass of layers
    for ii2 = 1 : length(mass_fields)
        field = mass_fields{ii2};
        Computation.Lithosphere.(layer).Mass.(field) = 'later';
    end % ii2 loop of mass
%%% Geonu_Flux of layers
    for ii2 = 1 : length(geonu_flux_fields)
        field = geonu_flux_fields{ii2};
        Computation.Lithosphere.(layer).Geonu_Flux.(field) = 'later';
    end % ii2 loop of geonu flux
%%% Heat Power of layers
    for ii2 = 1 : length(heat_power_fields)
        field = heat_power_fields{ii2};
        Computation.Lithosphere.(layer).Heat_Power.(field) = 'later';
    end % ii2 loop of heat power
end % ii1 loop
clear layers abundance_fields mass_fields geonu_flux_fields geonu_signal_fields heat_power_fields ii1 ii2 field layer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Mantle %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
abundance_fields = {'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
mass_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
geonu_flux_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
heat_power_fields = {'Total', 'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
%%% Abundance of mantle
for ii1 = 1 : length(abundance_fields)
    field = abundance_fields{ii1};
    Computation.Mantle.Abundance.Depleted.(field) = 'later';
    Computation.Mantle.Abundance.Enriched.(field) = 'later';
end
%%% Mass of mantle
for ii1 = 1 : length(mass_fields)
    field = mass_fields{ii1};
    Computation.Mantle.Mass.Depleted.(field) = 'later';
    Computation.Mantle.Mass.Enriched.(field) = 'later';
end
%%% Geonu Flux of mantle
for ii1 = 1 : length(geonu_flux_fields)
    field = geonu_flux_fields{ii1};
    Computation.Mantle.Geonu_Flux.Depleted.(field) = 'later';
    Computation.Mantle.Geonu_Flux.Enriched.(field) = 'later';
end
%%% Heat Power of mantle
for ii1 = 1 : length(heat_power_fields)
    field = heat_power_fields{ii1};
    Computation.Mantle.Heat_Power.Depleted.(field) = 'later';
    Computation.Mantle.Heat_Power.Enriched.(field) = 'later';
end
clear abundance_fields geonu_flux_fields heat_power_fields mass_fields;
clear field;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% BSE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Computation.BSE.Mass = 0;
abundance_fields = {'U', 'U238', 'U235', 'Th232', 'K', 'K40'};
for ii1 = 1 : length(abundance_fields)
    field = abundance_fields{ii1};
    Computation.BSE.Abundance.(field) = 'later';
end
clear abundance_fields ii1;
clear field;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Other %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Computation.Other.Earth.Mass = 0;
Computation.Other.Core.Mass = 0;