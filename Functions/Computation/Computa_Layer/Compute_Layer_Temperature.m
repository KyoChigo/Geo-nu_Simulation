function Computation = Compute_Layer_Temperature(Computation, Name_Layer)
depth = Computation.Lithosphere.(Name_Layer).Depth; % Unit: m
temperature = 10 + 71.6 .* (1 - exp(-depth/1000 ./10) ) + 10.7 .* depth/1000;  % Unit: ℃
Computation.Lithosphere.(Name_Layer).Temperature = temperature;  % Unit: ℃
end