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
abundance_fields = {'U', 'Th', 'K'};
mass_fields = {'Total', 'U238', 'U235', 'Th232', 'K40', 'K'};
geonu_flux_fields = {'Total', 'U238', 'Th232', 'K40'};
geonu_signal_fields = {'Total', 'U238', 'Th232'};
heat_power_fields = {'Total', 'U238', 'U235', 'U', 'Th232', 'K40', 'K'};

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
%%% Geonu_Signal of layers
    for ii2 = 1 : length(geonu_signal_fields)
        field = geonu_signal_fields{ii2};
        Computation.Lithosphere.(layer).Geonu_Signal.(field) = 'later';
    end % ii2 loop of geonu signal
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
Computation.Mantle = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% BSE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Computation.BSE = 0;