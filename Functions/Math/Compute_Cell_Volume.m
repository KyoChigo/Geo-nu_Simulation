function output_array = Compute_Cell_Volume(lon_left_array, lon_right_array, lat_bot_array, lat_top_array, radius_min_array, radius_max_array)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 计算一个球帽的体积 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% lon: degree %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% lat: degree %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% radius: m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% area: m^2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% volume: m^3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

area_array = Compute_Cell_Area(lon_left_array, lon_right_array, lat_bot_array, lat_top_array, 1);

output_array = 1/3 .* (radius_max_array .^3 - radius_min_array .^ 3) .* area_array;

end