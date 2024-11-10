function [THICKNESS, DEPTH, DENSITY, RADIUS, VOLUME, TEMPERATURE, PRESSURE, ABUNDANCE, MASS, GEONUFLUX, HEATPOWER] = Compute_Layer(index, name_layer, Physics, Geology, Computation)
%%% variables[0]: Thickness (m)
%%% variables[1]: Depth (m)
%%% variables[2]: Density (g/cm^3)
%%% variables[3]: Radius (m)
%%% variables[4]: Volume (m^3)
%%% variables[5]: Temperature (℃)
%%% variables[6]: Pressure (MPa)
%%% variables[7]: Mass (kg)
%%% variables[8]: Geonu Flux (?)
%%% variables[9]: Heat Power (W)
%%%%%%%%%%%%%%%%%%
name_model = Geology.Lithosphere.Model.Name;
%%%%%%%%%%%%%%%%%%% 判断 %%%%%%%%%%%%%%%%%
temp_thickness = Geology.Lithosphere.Model.Data.(name_layer).thick(index);
iteration = Geology.Iteration;
%%% 如果厚度小于等于零，直接返回0结果
if temp_thickness <= 0 
    template = zeros(1, iteration);
    THICKNESS = template;
    DEPTH = template;
    DENSITY = template;
    RADIUS = template;
    VOLUME = template;
    TEMPERATURE = template;
    PRESSURE = template;
    % 丰度
    ABUNDANCE.U = template;
    ABUNDANCE.U238 = template;
    ABUNDANCE.U235 = template;
    ABUNDANCE.Th232 = template;
    ABUNDANCE.K = template;
    ABUNDANCE.K40 = template;
    % 质量
    MASS.Total = template;
    MASS.U = template;
    MASS.U238 = template;
    MASS.U235 = template;
    MASS.Th232 = template;
    MASS.K = template;
    MASS.K40 = template;
    % Geonu flux
    GEONUFLUX.Total = template;
    GEONUFLUX.U = template;
    GEONUFLUX.U238 = template;
    GEONUFLUX.U235 = template;
    GEONUFLUX.Th232 = template;
    GEONUFLUX.K = template;
    GEONUFLUX.K40 = template;
    % Heat Power
    HEATPOWER.Total = template;
    HEATPOWER.U = template;
    HEATPOWER.U238 = template;
    HEATPOWER.U235 = template;
    HEATPOWER.Th232 = template;
    HEATPOWER.K = template;
    HEATPOWER.K40 = template;
    % disp(index + "直接返回");
    return;
end
%%%%%%%%%%%%%%%%%%% Thickness %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
THICKNESS = Compute_Layer_Thickness(name_model, name_layer, temp_thickness, Geology.Lithosphere.Model.Correlation.(name_layer).Thickness);
THICKNESS
%%%%%%%%%%%%%%%%%%% Depth %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%% 
end