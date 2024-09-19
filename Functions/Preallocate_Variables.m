function lithosphere = Preallocate_Variables(lithosphere)

GeoPhys = Get_GeoPhys(lithosphere);
len_lat = length(GeoPhys.latlon); %多少行
template = zeros(len_lat, 3); % N行3列：均值，正负误差
%%%%%%%%%%%%%%%%%%%%%%%%% Abundance, Mass, Geonu Flux and Heat Flux for 
%%%%%%%%%%%%%%%%%%%%%%%%% 9 layres: ice, water, UC, MC, LC, LM, s1, s2, s3
n = {'U';'Th';'K'};
for i = 1:length(n)
    lithosphere.Layers.ice.Abundance.(n{i})   = deal(template);
    lithosphere.Layers.water.Abundance.(n{i}) = deal(template);
    lithosphere.Layers.UC.Abundance.(n{i})    = deal(template);
    lithosphere.Layers.MC.Abundance.(n{i})    = deal(template);
    lithosphere.Layers.LC.Abundance.(n{i})    = deal(template);
    lithosphere.Layers.LM.Abundance.(n{i})    = deal(template);
    lithosphere.Layers.s1.Abundance.(n{i})    = deal(template);
    lithosphere.Layers.s2.Abundance.(n{i})    = deal(template);
    lithosphere.Layers.s3.Abundance.(n{i})    = deal(template);
end
n = {'Total_Mass';'U';'Th';'K'};
for i = 1:length(n)
    lithosphere.Layers.ice.Mass(:).(n{i})   = deal(template);
    lithosphere.Layers.water.Mass(:).(n{i}) = deal(template);
    lithosphere.Layers.UC.Mass(:).(n{i})    = deal(template);
    lithosphere.Layers.MC.Mass(:).(n{i})    = deal(template);
    lithosphere.Layers.LC.Mass(:).(n{i})    = deal(template);
    lithosphere.Layers.LM.Mass(:).(n{i})    = deal(template);
    lithosphere.Layers.s1.Mass(:).(n{i})    = deal(template);
    lithosphere.Layers.s2.Mass(:).(n{i})    = deal(template);
    lithosphere.Layers.s3.Mass(:).(n{i})    = deal(template);
end
n = {'Geonu_U238','Geonu_Th232','Heat_Flux'};
for i = 1:length(n)
    lithosphere.Layers.ice.Flux(:).(n{i})   = deal(template);
    lithosphere.Layers.water.Flux(:).(n{i}) = deal(template);
    lithosphere.Layers.UC.Flux(:).(n{i})    = deal(template);
    lithosphere.Layers.MC.Flux(:).(n{i})    = deal(template);
    lithosphere.Layers.LC.Flux(:).(n{i})    = deal(template);
    lithosphere.Layers.LM.Flux(:).(n{i})    = deal(template);
    lithosphere.Layers.s1.Flux(:).(n{i})    = deal(template);
    lithosphere.Layers.s2.Flux(:).(n{i})    = deal(template);
    lithosphere.Layers.s3.Flux(:).(n{i})    = deal(template);
end
clear n x i