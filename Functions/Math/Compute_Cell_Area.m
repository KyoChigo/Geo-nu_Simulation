function output_array = Compute_Cell_Area(lon_left_array, lon_right_array, lat_bot_array, lat_top_array, radius_array)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 计算一个球帽的面积 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% lon: degree %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% lat: degree %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% radius: m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% are: m^2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arc = pi / 180;
if isequal(radius_array, 1) % 用于Compute_Cell_Volume()
    output_array = (lon_right_array - lon_left_array) .* arc .* ( sin( lat_top_array .* arc) - sin( lat_bot_array .* arc));
else
    output_array = radius_array.^2 .* (lon_right_array - lon_left_array) .* arc .* ( sin( lat_top_array .* arc) - sin( lat_bot_array .* arc));
end

end