function Computation = Fill_Computation(Computation, Geology)
%%% Computation.Run_Info
Computation.Run_Info.Iteration = Geology.Iteration;
Computation.Run_Info.Method.Near_Field = Geology.Lithosphere.Model.Method.Near_Field;
Computation.Run_Info.Method.Deep_Crust = Geology.Lithosphere.Model.Method.Deep_Crust;
%%% Computation.Lithosphere
layers = {'UC', 'MC', 'LC', 'LM', 's1', 's2', 's3'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    Computation.Lithosphere.(layer).LatLon = Geology.Lithosphere.Model.GeoPhys.latlon; % Unit: degree
end

end