function Geology = Allocate_Variables_Lithosphere(Geology)
layers = {'UC', 'MC', 'LC', 'LM', 's1', 's2', 's3'};
len_layer = length(layers);
template = zeros(length(Geology.Lithosphere.Model.GeoPhys.latlon), 3);
for i = 1 : len_layer
    layer = layers{i};
    Geology.Lithosphere.Model.Abundance.(layer).U = template;
    Geology.Lithosphere.Model.Abundance.(layer).Th = template;
    Geology.Lithosphere.Model.Abundance.(layer).K = template;
end
clear layers len_layer i layer;
end