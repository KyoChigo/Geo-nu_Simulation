function [thick, radius, total_mass, abund_U, abund_Th, abund_K, pressure_to_layer] = Compute_Cell(index, iteration, name_model, name_layer, array_for_radius, cor_array, array_for_mass, last_layer_pressure, array_for_abundance)
%%%%%%%%%%%%%%%%%%%%%%%% 单位 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% radius: m
% mass: kg
% abundance: g/g
% THICKNESS: m
% DEPTH: m
% DENSITY: kg/m^3
% TEMPERATURE: ℃
%%%%%%%%%%%%%%%%%%%%%%%% 判断 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thickness_mean = array_for_radius(1); % Unit: m; single value
if thickness_mean <= 0
    template = zeros(1, iteration);
    thick = template;
    radius = template;
    total_mass = template;
    abund_U = template;
    abund_Th = template;
    abund_K = template;
    pressure_to_layer = last_layer_pressure;
    clear template thickness_mean;
    return
end
%%%%%%%%%%%%%%%%%%%%%%%% Thickness %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
THICKNESS = 0; % Unit: m
cor = cor_array{1}; % Thickness; column vector
temp_int = strcmp('Crust1', name_model) + strcmp('Crust2', name_model);
uncertainty = 0.12;
if strcmp(name_layer, 'LM') && temp_int == 1
    lab = Generate_Random_Normal(175000, 75000, 0, cor); % Unit: m; column vector
    moho_mean = array_for_radius(2); % Unit:m; single value
    moho = Generate_Random_Normal(moho_mean, moho_mean * uncertainty , 0, cor); % Unit: m; column vector
    THICKNESS = lab - moho; % Unit: m; column vector
    clear lab moho moho_mean;
else
    error = uncertainty * thickness_mean; % Unit: m
    THICKNESS = Generate_Random_Normal(thickness_mean, error, 0, cor); % Unit: m; column vector
    clear error;
end
clear cor temp_int uncertainty;
%%% 负项归零
THICKNESS(THICKNESS < 0) = 0;
THICKNESS = THICKNESS'; % 转化成行矢量
%%% 记录数据
thick = THICKNESS;
%%%%%%%%%%%%%%%%%%%%%%%% Depth %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DEPTH = 0; % Unit: m
cor = cor_array{1}; % Thickness; column vector
uncertainty = 0.12;
depth_mean = array_for_radius(3); % Unit: m; single value
error = uncertainty * depth_mean; % Unit: m
DEPTH = Generate_Random_Normal(depth_mean, error, 0, cor); % Unit: m; column vector
clear cor uncertainty depth_mean error;
DEPTH(DEPTH < 0) = 0;
DEPTH = DEPTH'; % 转换成行矢量
%%%%%%%%%%%%%%%%%%%%%%%% Radius %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RADIUS = 0; % Unit: m
surface_radius = array_for_radius(4); % Unit: m; single value
RADIUS = surface_radius - DEPTH; % Unit: m; row vector
clear surface_radius;
%%% %%% 记录半径
radius = RADIUS;
%%%%%%%%%%%%%%%%%%%%%%%% Density %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DENSITY = 0; % Unit: kg/m^3
cor = cor_array{2}; % Vp; column vector
uncertainty = 0.05;
density_mean = array_for_mass(1); % Unit: kg/m^3; single value
error = uncertainty * density_mean;
DENSITY = Generate_Random_Normal(density_mean, error, 0, cor); % column vector
clear cor uncertainty density_mean error;
DENSITY(DENSITY < 0) = 0;
DENSITY = DENSITY'; % 转换成行矢量
%%%%%%%%%%%%%%%%%%%%%%%% Volume %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
VOLUME = 0; % Unit:
lon_center = array_for_mass(2); % Single value
lat_center = array_for_mass(3);
lon_left = lon_center - 0.5; % Unit: °
lon_right = lon_center + 0.5;
lat_bottom = lat_center - 0.5; % Unit: °
lat_top = lat_center + 0.5;
radius_min = RADIUS - 0.5 .* THICKNESS; % Unit: m; row vector
radius_max = RADIUS + 0.5 .* THICKNESS; % Unit: m; row vector
VOLUME = Compute_Cell_Volume(lon_left, lon_right, lat_bottom, lat_top, radius_min, radius_max); % Row vector
clear lon_left lon_right lat_bottom lat_top radius_min radius_max;
%%%%%%%%%%%%%%%%%%%%%%%% Mass %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MASS = 0; % Unit: kg/m^3 * m^3 = kg;
MASS = DENSITY .* VOLUME; % Row Vector
%%% 记录数据
total_mass = MASS;
%%%%%%%%%%%%%%%%%%%%%%%% Temperature %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TEMPERATURE = 0; % Unit: ℃
if strcmp(name_layer, 'MC') | strcmp(name_layer, 'LC')
TEMPERATURE = 10 + 71.6 .* (1 - exp(-DEPTH./1000 ./ 10) ) + 10.7 .* DEPTH ./ 1000; % Row vector
end
%%%%%%%%%%%%%%%%%%%%%%%% Pressure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PRESSURE = 0; % Unit: MPa
pressure_this_layer = DENSITY .* THICKNESS .* 9.80655 * 1e-6; % kg/m^3 * m * m/s^2 = kg/(m s^2); Pa = kg/(m s^2)
% 这层产生的压强
PRESSURE = 0.5 * pressure_this_layer + last_layer_pressure; % 用来压强修正；Row vector
pressure_to_layer = pressure_this_layer + last_layer_pressure; % 这层的总压强
clear pressure_this_layer;
%%%%%%%%%%%%%%%%%%%%%%%% Abundance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ABUNDANCE_U = 0;
ABUNDANCE_TH = 0;
ABUNDANCE_K = 0;
if strcmp(name_layer, 'MC') || strcmp(name_layer, 'LC')
    vp_cor = cor_array{3}; % Crust Vp; column vector
    vp_mean = array_for_abundance{1}; % Unit: km/s; single value
    vp_error = 0.03 * vp_mean;
    vp_layer = Generate_Random_Normal(vp_mean, vp_error, 0, vp_cor); % Column vector
    name_method = array_for_abundance{2}; % Str
    felsic_U = array_for_abundance{3}; % Column vector
    felsic_Th = array_for_abundance{4}; % Column vector
    felsic_K = array_for_abundance{5}; % Column vector
    mafic_U = array_for_abundance{6}; % Column vector
    mafic_Th = array_for_abundance{7}; % Column vector
    mafic_K = array_for_abundance{8}; % Column vector
%%% %%% %%% Compute Abundance with Huang %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(name_method, 'Huang')
        cor_end = cor_array{3}; % End member Vp; column vector
        if strcmp(name_layer, 'MC')
            vp_f = Generate_Random_Normal(6.34, 0.16, 0, cor_end); % Column vector
            vp_m = Generate_Random_Normal(6.98, 0.20, 0, cor_end); % Column vector
        elseif strcmp(name_layer, 'LC')
            vp_f = Generate_Random_Normal(6.52, 0.19, 0, cor_end); % Column vector
            vp_m = Generate_Random_Normal(7.21, 0.20, 0, cor_end); % Column vector
        end
%%% %%% %%% %%% 转化成行矢量
        vp_layer = vp_layer'; %Row vector
        vp_f = vp_f'; % Row vector
        vp_m = vp_m'; % Row vector
        felsic_U = felsic_U'; % Row vector
        felsic_Th = felsic_Th'; % Row vector
        felsic_K = felsic_K'; % Row vector
        mafic_U = mafic_U'; % Row vector
        mafic_Th = mafic_Th'; % Row vector
        mafic_K = mafic_K'; % Row vector
%%% %%% %%% %%% 温度修正
        vp_f = vp_f - (TEMPERATURE - 20) * 4 * 1e-4; 
        vp_m = vp_m - (TEMPERATURE - 20) * 4 * 1e-4;
%%% %%% %%% %%% 压强修正
        vp_f = vp_f + (PRESSURE - 600) * 2 * 1e-4;
        vp_m = vp_m + (PRESSURE - 600) * 2 * 1e-4;
%%% %%% %%% %%% 计算felsic的比例
        fraction = (vp_layer - vp_m) ./ (vp_f - vp_m); % Row vector;
        fraction(fraction < 0) = 0;
        fraction(fraction > 1) = 1;
%%% %%% %%% %%% 计算丰度
        ABUNDANCE_U = Abundance_Huang(felsic_U, mafic_U, fraction); % Row vector
        ABUNDANCE_TH = Abundance_Huang(felsic_Th, mafic_Th, fraction); % Row vector
        ABUNDANCE_K = Abundance_Huang(felsic_K, mafic_K, fraction); % Row vector
clear vp_mean vp_error vp_layer name_method felsic_U felsic_Th felsic_K mafic_U mafic_Th mafic_K;
clear cor_end vp_f vp_m fraction;
%%% %%% %%% Compute Abundance with Bivart %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strcmp(name_method, 'Bivariate')
        disp('[Compute_Cell] Bivariate is to be finished');
    end
%%% %%% %%% Compute Abundance in other layers %%%%%%%%%%%%%%%%%%%%%%
else
    cor = cor_array{3}; % abundance; column vector
    cor = cor'; % 转换成行矢量
    U_mean = array_for_abundance{1};
    U_error = array_for_abundance{2};
    Th_mean = array_for_abundance{3};
    Th_error = array_for_abundance{4};
    K_mean = array_for_abundance{5};
    K_error = array_for_abundance{6};
%%% %%% %%% %%% 计算丰度
    ABUNDANCE_U = Generate_Random_Normal(U_mean, U_error, 0, cor);
    ABUNDANCE_TH = Generate_Random_Normal(Th_mean, Th_error, 0, cor);
    ABUNDANCE_K = Generate_Random_Normal(K_mean, K_error, 0, cor);
    clear U_mean U_error Th_mean Th_error K_mean K_error;
end
ABUNDANCE_U(ABUNDANCE_U < 0) = 0;
ABUNDANCE_TH(ABUNDANCE_TH < 0) = 0;
ABUNDANCE_K(ABUNDANCE_K < 0) = 0;
%%% 记录数据
abund_U = ABUNDANCE_U;
abund_Th = ABUNDANCE_TH;
abund_K = ABUNDANCE_K;
%%%%%%%%%%%%%%%%%%%%%%%% Test
    % template = zeros(1, iteration);
    % abund_U = template;
    % abund_Th = template;
    % abund_K = template;
    % clear template;
%%% 
end