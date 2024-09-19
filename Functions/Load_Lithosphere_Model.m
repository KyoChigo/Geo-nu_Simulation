function lithosphere = Load_Lithosphere_Model(lithosphere)

% 通过lithosphere.str加载对应的地质模型，并把模型储存在listhosphere.data中

% 最后还是返回lithosphere

model = lithosphere.Model_Name;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load Lithosphere Data %%%%%%%%%%%%%%%%%%%
% -- Load Geophysical Model for Lithosphere -- 
if strcmp(model,'Litho1')
    % -- Load LITHO1.0 Data -- (Pasyanos et al. 2014)
    Lithosphere_Model = load('.\InputFiles\LithosphereModels\LITHO1_Data.mat'); % set geophysical model variable
    GeoPhys = Lithosphere_Model.Litho1;
    GeoPhys.Name = 'Litho1';
elseif strcmp(model,'Crust1')
    % -- Load CRUST1.0 Data -- (Laske et al. 2013)
    Lithosphere_Model = load('.\InputFiles\LithosphereModels\CRUST1_Data.mat'); % set geophysical model variable
    GeoPhys = Lithosphere_Model.Crust1;
    GeoPhys.Name = 'Crust1';
elseif strcmp(model,'Crust2')
    % -- Load Crust2.0 Data -- (Bassin et al. 2000)
    Lithosphere_Model = load('.\InputFiles\LithosphereModels\CRUST2_Data.mat'); % set geophysical model variable
    GeoPhys = Lithosphere_Model.Crust2;
    GeoPhys.Name = 'Crust2';
 elseif strcmp(model,'ECM1')
    % -- Load Crust2.0 Data -- (Bassin et al. 2000)
    Lithosphere_Model = load('.\InputFiles\LithosphereModels\ECM1_Data.mat'); % set geophysical model variable
    GeoPhys = Lithosphere_Model.ECM1;
    GeoPhys.Name = 'ECM1';
else 
    error('Wrong inputed geophysical model: "%s"',model)
end   

lithosphere.Model_Data = Lithosphere_Model;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Asign CC and OC %%%%%%%%%%%%%%%%%%%%%%%%%
lithosphere = Asign_OC_CC(lithosphere);

clear GeoPhys