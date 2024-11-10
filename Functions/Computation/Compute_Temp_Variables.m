template = zeros(len, iteration);
if strcmp(name_layer, 's1')
    PRESSURE = template;
end
THICKNESS = template;
RADIUS = template;
TOTAL_MASS = template;
ABUNDANCE_U = template;
ABUNDANCE_TH = template;
ABUNDANCE_K = template;
clear template;

cor_thick = Geology.Lithosphere.Model.Correlation.(name_layer).Thickness; % Column vector
cor_vp = Geology.Lithosphere.Model.Correlation.(name_layer).Vp; % Column vector
thick = Geology.Lithosphere.Model.Data.(name_layer).thick; % 64800 * 1
depth = Geology.Lithosphere.Model.Data.(name_layer).depth; % 64800 * 1
density = Geology.Lithosphere.Model.Data.(name_layer).rho; % 64800 * 1
if strcmp(name_layer, 'MC')
    crust_vp = Geology.Lithosphere.Model.Data.(name_layer).Vp;
    name_method = Geology.Lithosphere.Model.Method.Deep_Crust;
    cor_end = Geology.Lithosphere.Model.Correlation.(name_layer).DeepCrust.End.Vp; % Column vector
    felsic_U = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.U; % Column vector
    felsic_Th = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.Th; % Column vector
    felsic_K = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.K; % Column vector
    mafic_U = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.U; % Column vector
    mafic_Th = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.Th; % Column vector
    mafic_K = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.K; % Column vector
elseif strcmp(name_layer, 'LC')
    crust_vp = Geology.Lithosphere.Model.Data.(name_layer).Vp;
    name_method = Geology.Lithosphere.Model.Method.Deep_Crust;
    cor_end = Geology.Lithosphere.Model.Correlation.(name_layer).DeepCrust.End.Vp; % Column vector
    felsic_U = Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.U; % Column vector
    felsic_Th = Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.Th; % Column vector
    felsic_K = Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.K; % Column vector
    mafic_U = Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.U; % Column vector
    mafic_Th = Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.Th; % Column vector
    mafic_K = Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.K; % Column vector
else
    cor_abund = Geology.Lithosphere.Model.Correlation.(name_layer).Abundance; % Column vector
    abund_U = Geology.Lithosphere.Model.Abundance.(name_layer).U; % 64800 * 3;
    abund_Th = Geology.Lithosphere.Model.Abundance.(name_layer).Th; % 64800 * 3;
    abund_K = Geology.Lithosphere.Model.Abundance.(name_layer).K; % 64800 * 3;
end