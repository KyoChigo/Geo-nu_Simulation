function Computation = Zero_Results(Computation, Name_Layer, index)
k = index;
template = zeros(1, 3);
template_iteration = zeros(1, length(Computation.Run_Info.Iteration));
%%% %%% Thickness
    Computation.Lithosphere.(Name_Layer).Thickness(k, :) = template_iteration;
%%% %%% Depth
    Computation.Lithosphere.(Name_Layer).Depth(k, :) = template_iteration;
%%% %%% Radius
    Computation.Lithosphere.(Name_Layer).Radius(k, :) = template_iteration;
%%% %%% Mass
    Computation.Lithosphere.(Name_Layer).Mass.Total(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Mass.U238(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Mass.U235(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Mass.Th232(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Mass.K40(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Mass.K(k, :) = template;
%%% %%% Geonu Flux
    Computation.Lithosphere.(Name_Layer).Geonu_Flux.Total(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Geonu_Flux.U238(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Geonu_Flux.Th232(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Geonu_Flux.K40(k, :) = template;
%%% %%% Geonu Signal
    Computation.Lithosphere.(Name_Layer).Geonu_Signal.Total(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Geonu_Signal.U238(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Geonu_Signal.Th232(k, :) = template;
%%% %%% Heat Power
    Computation.Lithosphere.(Name_Layer).Heat_Power.Total(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Heat_Power.U238(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Heat_Power.U235(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Heat_Power.U(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Heat_Power.Th232(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Heat_Power.K40(k, :) = template;
    Computation.Lithosphere.(Name_Layer).Heat_Power.K(k, :) = template;

end