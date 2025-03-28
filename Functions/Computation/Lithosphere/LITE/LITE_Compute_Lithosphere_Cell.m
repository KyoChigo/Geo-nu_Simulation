function [TOTAL_MASS, MASS_U, MASS_TH,  SIGNAL_U, SIGNAL_TH, PRESSURE_TO_LAYER]...
    = LITE_Compute_Lithosphere_Cell(index, iteration, name_model, name_layer,...
    last_layer_pressure, cor_array, array_for_radius, array_for_mass, array_for_abundance,...
    detector, array_for_signal)
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Input ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% index                 : index of the cell
% iteration             : iteration
% name_model            : name of the lithosphere mode
% name_layer            : name of the layer
% last_layer_pressure   : pressure comes from above layers, using to apply pressure correction
% cor_array             : variables about correlation coefficients
% array_for_radius      : variables for computing depth, thickness, volume
% array_for_mass        : varaibles for computing density, rock mass
% array_for_abundace    : variables for computing abundence of HPEs
% 

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Unit ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% radius: m
% mass: kg
% abundance: g/g
% THICKNESS: m
% DEPTH: m
% DENSITY: kg/m^3
% TEMPERATURE: ℃

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 判断 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
thickness_mean = array_for_radius(1); % Unit: m; single value %
if thickness_mean <= 0 | strcmp('LM_OC', name_layer) == 1
    template = zeros(1, iteration);
    TOTAL_MASS = template;
    MASS_U = template;
    MASS_TH = template;
    SIGNAL_U = template;
    SIGNAL_TH = template;
    PRESSURE_TO_LAYER = last_layer_pressure;
% % Clear Variables % %
    clear template thickness_mean;
    return
end

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Thickness ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
THICKNESS = 0; % Unit: m %
cor = cor_array{1}; % Thickness; column vector %
temp_int = strcmp('Crust1', name_model) + strcmp('Crust2', name_model);
uncertainty = 0.12;
if strcmp(name_layer, 'LM_CC') && temp_int == 1
    lab = Generate_Random_Normal(175000, 75000, 0, cor); % Unit: m; column vector %
    moho_mean = array_for_radius(2); % Unit:m; single value %
    moho = Generate_Random_Normal(moho_mean, moho_mean * uncertainty , 0, cor); % Unit: m; column vector %
    THICKNESS = lab - moho; % Unit: m; column vector %
    % % Clear Variables % %
    clear lab moho moho_mean;
else
    error = uncertainty * thickness_mean; % Unit: m %
    THICKNESS = Generate_Random_Normal(thickness_mean, error, 0, cor); % Unit: m; column vector %
    % % Clear Variables % %
    clear error;
end
% % 负项归零 % %
THICKNESS(THICKNESS < 0) = 0;
THICKNESS = THICKNESS'; % 转化成行矢量 %
% % Clear Variables % %
clear cor temp_int uncertainty;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Depth ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
DEPTH = 0; % Unit: m %
cor = cor_array{1}; % Thickness; column vector %
uncertainty = 0.12;
depth_mean = array_for_radius(3); % Unit: m; single value %
error = uncertainty * depth_mean; % Unit: m %
DEPTH = Generate_Random_Normal(depth_mean, error, 0, cor); % Unit: m; column vector %
DEPTH(DEPTH < 0) = 0;
DEPTH = DEPTH'; % 转换成行矢量 %
% % Clear Variables % %
clear cor uncertainty depth_mean error;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Radius ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
RADIUS = 0; % Unit: m %
surface_radius = array_for_radius(4); % Unit: m; single value %
RADIUS = surface_radius - DEPTH; % Unit: m; row vector %
% % Clear Variables % %
clear surface_radius;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Density ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
DENSITY = 0; % Unit: kg/m^3 %
cor = cor_array{2}; % Vp; column vector %
uncertainty = 0.05;
density_mean = array_for_mass(1); % Unit: kg/m^3; single value %
error = uncertainty * density_mean;
DENSITY = Generate_Random_Normal(density_mean, error, 0, cor); % column vector %
DENSITY(DENSITY < 0) = 0;
DENSITY = DENSITY'; % 转换成行矢量 %
% % Clear Variables % %
clear cor uncertainty density_mean error;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Volume ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
VOLUME = 0; % Unit: m^3 %
lon_center = array_for_mass(2); % Single value %
lat_center = array_for_mass(3);
lon_left = lon_center - 0.5; % Unit: ° %
lon_right = lon_center + 0.5;
lat_bottom = lat_center - 0.5; % Unit: ° % 
lat_top = lat_center + 0.5;
radius_min = RADIUS - 0.5 .* THICKNESS; % Unit: m; row vector %
radius_max = RADIUS + 0.5 .* THICKNESS; % Unit: m; row vector %
VOLUME = Compute_Cell_Volume(lon_left, lon_right, lat_bottom, lat_top, radius_min, radius_max); % Row vector %
% % Clear Variables % %
clear lon_center lat_center;
clear lon_left lon_right lat_bottom lat_top radius_min radius_max;
clear RADIUS;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Mass ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
TOTAL_MASS = DENSITY .* VOLUME; % Row Vector %
% % Clear Variables % %
clear VOLUME;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Temperature ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
TEMPERATURE = 0; % Unit: ℃ %
if strcmp(name_layer, 'MC_CC') | strcmp(name_layer, 'LC_CC')
    TEMPERATURE = 10 + 71.6 .* (1 - exp(-DEPTH./1000 ./ 10) ) + 10.7 .* DEPTH ./ 1000; % Row vector %
end
% % Clear Variables % %
clear DEPTH;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Pressure ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
PRESSURE = 0; % Unit: MPa %
pressure_this_layer = DENSITY .* THICKNESS .* 9.80665 * 1e-6; % kg/m^3 * m * m/s^2 = kg/(m s^2); Pa = kg/(m s^2) %
% % 这层产生的压强 % %
PRESSURE = 0.5 * pressure_this_layer + last_layer_pressure; % 用来压强修正；Row vector %
PRESSURE_TO_LAYER = pressure_this_layer + last_layer_pressure; % 这层的总压强 %
% % Clear Variables % %
clear pressure_this_layer;
clear THICKNESS;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Abundance ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
ABUNDANCE_U = 0;
ABUNDANCE_TH = 0;
ABUNDANCE_K = 0;
if strcmp(name_layer, 'MC_CC') || strcmp(name_layer, 'LC_CC')
% % Generate the Vp of this Cell % %
    vp_cor = cor_array{2}; % Crust Vp; column vector %
    vp_mean = array_for_abundance{1}; % Unit: km/s; single value %
    vp_error = 0.03 * vp_mean;
    vp_layer = Generate_Random_Normal(vp_mean, vp_error, 0, vp_cor); % Column vector %
    name_method = array_for_abundance{2}; % Str %
% % % Compute Abundance with Huang Method % % %
    if strcmp(name_method, 'Huang')
        felsic_U = array_for_abundance{3}; % Column vector %
        felsic_Th = array_for_abundance{4}; % Column vector %
        felsic_K = array_for_abundance{5}; % Column vector %
        mafic_U = array_for_abundance{6}; % Column vector %
        mafic_Th = array_for_abundance{7}; % Column vector %
        mafic_K = array_for_abundance{8}; % Column vector %
        cor_end = cor_array{3}; % End member Vp; column vector %
        if strcmp(name_layer, 'MC_CC')
            vp_f = Generate_Random_Normal(6.34, 0.16, 0, cor_end); % Column vector %
            vp_m = Generate_Random_Normal(6.98, 0.20, 0, cor_end); % Column vector %
        elseif strcmp(name_layer, 'LC_CC')
            vp_f = Generate_Random_Normal(6.52, 0.19, 0, cor_end); % Column vector %
            vp_m = Generate_Random_Normal(7.21, 0.20, 0, cor_end); % Column vector %
        end
% % % % 转化成行矢量 % % % % 
        vp_layer = vp_layer'; % Row vector %
        vp_f = vp_f'; % Row vector %
        vp_m = vp_m'; % Row vector %
        felsic_U = felsic_U'; % Row vector %
        felsic_Th = felsic_Th'; % Row vector %
        felsic_K = felsic_K'; % Row vector %
        mafic_U = mafic_U'; % Row vector %
        mafic_Th = mafic_Th'; % Row vector %
        mafic_K = mafic_K'; % Row vector %
% % % % 温度修正 % % % %
        vp_f = vp_f - (TEMPERATURE - 20) * 4 * 1e-4; 
        vp_m = vp_m - (TEMPERATURE - 20) * 4 * 1e-4;
% % % % 压强修正 % % % %
        vp_f = vp_f + (PRESSURE - 600) * 2 * 1e-4;
        vp_m = vp_m + (PRESSURE - 600) * 2 * 1e-4;
% % % % 计算felsic的比例 % % % %
        fraction = (vp_layer - vp_m) ./ (vp_f - vp_m); % Row vector %
        fraction(fraction < 0) = 0;
        fraction(fraction > 1) = 1;
% % % % 计算丰度 % % % % 
        K_Ratio = array_for_abundance{9}; % K40的自然丰度 %
        ABUNDANCE_U = Abundance_Huang(felsic_U, mafic_U, fraction); % Row vector %
        ABUNDANCE_TH = Abundance_Huang(felsic_Th, mafic_Th, fraction); % Row vector %
        ABUNDANCE_K = Abundance_Huang(felsic_K, mafic_K, fraction) ./ K_Ratio; % Row vector %
% % % % Clear Variables % % % %
clear felsic_U felsic_Th felsic_K mafic_U mafic_Th mafic_K;
clear cor_end vp_f vp_m fraction K_Ratio;
% % % Compute Abundance with Bivart Method % % %
    elseif strcmp(name_method, 'Bivariate')
        cor_biv_sio2 = cor_array{3};
        cor_biv_abund = cor_array{4};
        center_vp = array_for_abundance{3};
        u_fit_par = array_for_abundance{4};
        th_fit_par = array_for_abundance{5};
        k20_fit_par = array_for_abundance{6};
        K_K20 = array_for_abundance{7}; % K在K2O的质量分数，0.83
        temperature = TEMPERATURE';
        pressure = PRESSURE';
        center_vp = bsxfun(@plus, center_vp,((temperature-20)*-4*10^-4 + (pressure/10^6-600)*2*10^-4));
        
        ABUNDANCE_U = Abundance_Bivariate(center_vp, vp_layer, u_fit_par, cor_biv_sio2, cor_biv_abund) * 1e-6;
        ABUNDANCE_TH = Abundance_Bivariate(center_vp, vp_layer, th_fit_par, cor_biv_sio2, cor_biv_abund) * 1e-6;
        ABUNDANCE_K = Abundance_Bivariate(center_vp, vp_layer, k20_fit_par, cor_biv_sio2, cor_biv_abund) * 1e-2 * K_K20;
% % % % Clear Variables % % % %
        clear cor_biv_sio2 cor_biv_abund center_vp;
        clear u_fit_par th_fit_par k20_fit_par K_K20;
        clear temperature pressure center_vp;
    end
% % % Clear Variables % % %
clear vp_cor vp_mean vp_error vp_layer name_method;
clear PRESSURE TEMPERATURE;
% % Compute Abundance in other layers % %
else
    cor = cor_array{3}; % abundance; column vector %
    cor = cor'; % 转换成行矢量 %
    U_mean = array_for_abundance{1};
    U_P_error = array_for_abundance{2};
    U_N_error = array_for_abundance{3};
    Th_mean = array_for_abundance{4};
    Th_P_error = array_for_abundance{5};
    Th_N_error = array_for_abundance{6};
    K_mean = array_for_abundance{7};
    K_P_error = array_for_abundance{8};
    K_N_error = array_for_abundance{9};
% % % 计算丰度 % % %
    if U_P_error == U_N_error
        ABUNDANCE_U = Generate_Random_Normal(U_mean, U_P_error, 0, cor);
        ABUNDANCE_TH = Generate_Random_Normal(Th_mean, Th_P_error, 0, cor);
        ABUNDANCE_K = Generate_Random_Normal(K_mean, K_P_error, 0, cor);
    else
        ABUNDANCE_U = Generate_Random_Log_Normal(U_mean, U_P_error, U_N_error, 0, cor);
        ABUNDANCE_TH = Generate_Random_Log_Normal(Th_mean, Th_P_error, Th_N_error, 0, cor);
        ABUNDANCE_K = Generate_Random_Log_Normal(K_mean, K_P_error, K_N_error, 0, cor);
    end
% % % Clear Variables % % %
    clear cor;
    clear U_mean U_P_error U_N_error;
    clear Th_mean Th_P_error Th_N_error;
    clear K_mean K_P_error K_N_error;
end
ABUNDANCE_U(ABUNDANCE_U < 0) = 0;
ABUNDANCE_TH(ABUNDANCE_TH < 0) = 0;
ABUNDANCE_K(ABUNDANCE_K < 0) = 0;

MASS_U = TOTAL_MASS .* ABUNDANCE_U;
MASS_TH = TOTAL_MASS .* ABUNDANCE_TH;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Geonu Signals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
lon_center = array_for_mass(2);
lat_center = array_for_mass(3);
thickness_center = array_for_radius(1);
depth_center = array_for_radius(3);
surface_radius = array_for_radius(4);
distance = Compute_Distance(lon_center, lat_center, surface_radius, depth_center, detector); % Unit: m %
subcell_sizes = [4000,15000,25000,40000,60000];
subcell_limits = [100000,160000,280000,600000,1000000];
p = [-2.66418271373068e-42	1.124024966179065e-35	-1.94938406390849e-29	1.78637937516982e-23	-9.23203293588723e-18	2.64355903236367e-12	-3.47340369763152e-07	0.0247642194415582	29.1375158113139]; 
response_u238 = array_for_signal{1}; % Column vector $
response_th232 = array_for_signal{2}; % Column vector $
energy = array_for_signal{3}; % Column vector %
p1 = array_for_signal{4};
p2 = array_for_signal{5};
p3 = array_for_signal{6};
m21 = array_for_signal{7};
m31 = array_for_signal{8};
m32 = array_for_signal{9};
geonu_factor_u238 = 0;
geonu_factor_th232 = 0;

if distance > subcell_limits(5)
    part1 = 1 + p1 .* sin(1.27 * m21 .* bsxfun(@rdivide, distance, energy')) .^2; % 1 * Energy %
    part2 = p2 .* sin(1.27 * m31 .* bsxfun(@rdivide, distance, energy')) .^2; % 1 * Energy %
    part3 = p3 .* sin(1.27 * m32 .* bsxfun(@rdivide, distance, energy')) .^2; % 1 * Energy %
    Pee = part1 + part2 + part3; % cell * Energy %
    volume = Compute_Cell_Volume(lon_center - 0.5, lon_center + 0.5, lat_center - 0.5, lat_center + 0.5, surface_radius - depth_center - thickness_center/2, surface_radius - depth_center + thickness_center/2);
    factor_u238 = sum(volume .* response_u238 .* Pee'); % Cell * 1 %
    factor_th232 = sum(volume .* response_th232 .* Pee'); % Cell * 1 %
    % Unit: m^5/kg %
    geonu_factor_u238 = factor_u238  ./ (distance .^ 2); % Unit: m^3/kg %
    geonu_factor_th232 = factor_th232 ./ (distance .^2); % Unit: m^3/kg %
    % % Clear Vairables % %
    clear part1 part2 part3 Pee;
    clear volume factor_u238 factor_th232;
else
% % Get the subcell_size of subcell $ $
    if distance <= subcell_limits(1)
        subcell_size = subcell_sizes(1);
    elseif distance > subcell_limits(1) && distance <= subcell_limits(2)
        subcell_size = subcell_sizes(2);
    elseif distance > subcell_limits(2) && distance <= subcell_limits(3)
        subcell_size = subcell_sizes(3);
    elseif distance > subcell_limits(3) && distance <= subcell_limits(4)
        subcell_size = subcell_sizes(4);
    elseif distance > subcell_limits(4) && distance <= subcell_limits(5)
        subcell_size = subcell_sizes(5);
    end
% % Split cell % %
    [sub_lons, sub_lats, sub_depths, lon_sub_interval, lat_sub_interval, thick_sub_interval]...
        = Split_Cell(lon_center, lat_center, depth_center, 1, 1, thickness_center, subcell_size, surface_radius);

    for ii2 = 1 : length(sub_lons)

        sub_distances = Compute_Distance(sub_lons(ii2), sub_lats(ii2), surface_radius, sub_depths(ii2), detector);
        sub_subcell_size = polyval(p, sub_distances);
        sub_subcell_size(sub_subcell_size <100) = 100;

        if sub_subcell_size * 1.333 <= subcell_size
            [sub_sub_lons, sub_sub_lats, sub_sub_depths, lon_sub_sub_interval, lat_sub_sub_interval, thick_sub_sub_interval]...
                = Split_Cell(sub_lons(ii2), sub_lats(ii2), sub_depths(ii2), lon_sub_interval, lat_sub_interval, thick_sub_interval, sub_subcell_size, surface_radius);
            sub_sub_volumes = Compute_Cell_Volume(sub_sub_lons - lon_sub_sub_interval / 2, sub_sub_lons + lon_sub_sub_interval/2,...
                sub_sub_lats - lat_sub_sub_interval/2, sub_sub_lats + lat_sub_sub_interval/2,...
                surface_radius - sub_sub_depths - thick_sub_sub_interval/2, surface_radius - sub_sub_depths + thick_sub_sub_interval/2);
            % Cell * 1 %
            sub_sub_distances = Compute_Distance(sub_sub_lons, sub_sub_lats, surface_radius, sub_sub_depths, detector);
            % Cell * 1 %
            part1 = 1 + p1 .* sin(1.27 * m21 .* bsxfun(@rdivide, sub_sub_distances, energy')) .^2; % Cell * Energy %
            part2 = p2 .* sin(1.27 * m31 .* bsxfun(@rdivide, sub_sub_distances, energy')) .^2; % Cell * Energy %
            part3 = p3 .* sin(1.27 * m32 .* bsxfun(@rdivide, sub_sub_distances, energy')) .^2; % Cell * Energy %
            Pee = part1 + part2 + part3; % subcell * energy %
            factor_u238 = sum(sub_sub_volumes .* (response_u238 .* Pee')' , 2); % cell * 1 %
            factor_th232 = sum(sub_sub_volumes .* (response_th232 .* Pee')', 2); % cell * 1 %
            unit_geonu_factor_u238 = factor_u238 ./ (sub_sub_distances .^ 2); % cell * 1 %
            unit_geonu_factor_th232 = factor_th232 ./ (sub_sub_distances .^ 2); % cell * 1 %
            geonu_factor_u238 = geonu_factor_u238 + sum(unit_geonu_factor_u238, 1);  % Unit: m^3/kg %
            geonu_factor_th232 = geonu_factor_th232 + sum(unit_geonu_factor_th232, 1);  % Unit: m^3/kg %
            % % % Clear Variables % % %
            clear sub_sub_lons sub_sub_lats sub_sub_depths lon_sub_sub_interval lat_sub_sub_interval thick_sub_sub_interval;
            clear sub_sub_volumes sub_sub_distances;
            clear part1 part2 part3 Pee;
            clear factor_u238 factor_th232 unit_geonu_factor_u238 unit_geonu_factor_th232;
        else
            disp(name_layer);
            index
            ii2
            disp('[Compute_Lithosphere_Cell] The count for 1st split is missing now!!!');
        end % end: if %
    end % end: for %
    % % % Clear Variables % % %
    clear sub_lons sub_lats sub_depths lon_sub_interval lat_sub_interval thick_sub_interval;

end
% % Geonu Signal % %
SIGNAL_U = DENSITY .* ABUNDANCE_U .* geonu_factor_u238;
SIGNAL_TH = DENSITY .* ABUNDANCE_TH .* geonu_factor_th232;
% % Clear Variables % %
clear lon_center lat_center thickness_center depth_center;
clear surface_radius distance subcell_sizes subcell_limits;
clear p response_u238 response_th232 energy;
clear p1 p2 p3 m21;
clear geonu_factor_u238 geonu_factor_th232;
clear DENSITY ABUNDANCE_U ABUNDANCE_TH ABUNDANCE_K;

end