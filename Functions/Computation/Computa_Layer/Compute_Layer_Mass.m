function Computation = Compute_Layer_Mass(Geology, Computation, Name_Layer)
density = Computation.Lithosphere.(Name_Layer).Density;
volume = Computation.Lithosphere.(Name_Layer).Volume;
total_mass = density .* volume;
Computation.Lithosphere.(Name_Layer).Mass.Total = total_mass;
end