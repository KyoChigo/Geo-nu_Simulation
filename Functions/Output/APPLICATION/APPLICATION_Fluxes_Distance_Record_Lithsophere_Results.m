%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : APPLICATION_Record_Lithosphere_Results.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - mass          : kg
%   - signal rate   : TNU
%   - geonu flux    : cm^{-2} s^{-1}
%   - distance      : m
%
% Created On      : 2025-04-14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
Output.Lithosphere.Mass.(name_layer).U = sum(mass_u, 1)';
Output.Lithosphere.Mass.(name_layer).Th = sum(mass_th, 1)';
Output.Lithosphere.Mass.(name_layer).Total = Output.Lithosphere.Mass.(name_layer).U + Output.Lithosphere.Mass.(name_layer).Th;

Output.Lithosphere.Geonu_Signal.(name_layer).U238 = signal_u;
Output.Lithosphere.Geonu_Signal.(name_layer).Th232 = signal_th;
Output.Lithosphere.Geonu_Signal.(name_layer).Total = Output.Lithosphere.Geonu_Signal.(name_layer).U238 + Output.Lithosphere.Geonu_Signal.(name_layer).Th232;

Output.Lithosphere.Geonu_Flux.(name_layer).U238 = flux_u;
Output.Lithosphere.Geonu_Flux.(name_layer).Th232 = flux_th;
Output.Lithosphere.Geonu_Flux.(name_layer).Total = Output.Lithosphere.Geonu_Flux.(name_layer).U238 + Output.Lithosphere.Geonu_Flux.(name_layer).Th232;

Output.Lithosphere.Distance.(name_layer) = distance;

% ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
if strcmp(name_layer, 'LM')
    layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
    template = 0 .* Output.Lithosphere.Mass.s1.Total;
    Output.Lithosphere.Mass.Total.Total = template;
    Output.Lithosphere.Mass.Total.U = template;
    Output.Lithosphere.Mass.Total.Th = template;
    template = 0 .* Output.Lithosphere.Geonu_Signal.s1.Total;
    Output.Lithosphere.Geonu_Signal.Total.Total = template;
    Output.Lithosphere.Geonu_Signal.Total.U238 = template;
    Output.Lithosphere.Geonu_Signal.Total.Th232 = template;
    template = 0 .* Output.Lithosphere.Geonu_Flux.s1.Total;
    Output.Lithosphere.Geonu_Flux.Total.Total = template;
    Output.Lithosphere.Geonu_Flux.Total.U238 = template;
    Output.Lithosphere.Geonu_Flux.Total.Th232 = template;
    template = 0 .* Output.Lithosphere.Heat_Power.s1.Total;
    Output.Lithosphere.Heat_Power.Total.Total = template;
    Output.Lithosphere.Heat_Power.Total.U = template;
    Output.Lithosphere.Heat_Power.Total.Th = template;

    % abun_mass_u238 = Physics.Elements.Abundance.Mass.U238;
    % abun_mass_th232 = Physics.Elements.Abundance.Mass.Th232;
    hp_res_u = Physics.Elements.Heat_Power.U;
    hp_res_th = Physics.Elements.Heat_Power.Th232;
    % % Add up all layers % %
    for ii1 = 1 : length(layers)
        layer = layers{ii1};
        Output.Lithosphere.Mass.Total.U = Output.Lithosphere.Mass.Total.U + Output.Lithosphere.Mass.(layer).U;
        Output.Lithosphere.Mass.Total.Th = Output.Lithosphere.Mass.Total.Th + Output.Lithosphere.Mass.(layer).Th;
        Output.Lithosphere.Mass.Total.Total = Output.Lithosphere.Mass.Total.Total + Output.Lithosphere.Mass.(layer).Total;
        
        Output.Lithosphere.Geonu_Signal.Total.U238 = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.(layer).U238;
        Output.Lithosphere.Geonu_Signal.Total.Th232 = Output.Lithosphere.Geonu_Signal.Total.Th232 + Output.Lithosphere.Geonu_Signal.(layer).Th232;

        Output.Lithosphere.Geonu_Flux.Total.U238 = Output.Lithosphere.Geonu_Flux.Total.U238 + Output.Lithosphere.Geonu_Flux.(layer).U238;
        Output.Lithosphere.Geonu_Flux.Total.Th232 = Output.Lithosphere.Geonu_Flux.Total.Th232 + Output.Lithosphere.Geonu_Flux.(layer).Th232;
        
        % % % Compute heat power in here to save memory % % %
        Output.Lithosphere.Heat_Power.(layer).U = hp_res_u .* Output.Lithosphere.Mass.(layer).U;
        Output.Lithosphere.Heat_Power.(layer).Th = hp_res_th .* Output.Lithosphere.Mass.(layer).Th;
        Output.Lithosphere.Heat_Power.(layer).Total = Output.Lithosphere.Heat_Power.(layer).U + Output.Lithosphere.Heat_Power.(layer).Th;

        Output.Lithosphere.Heat_Power.Total.U = Output.Lithosphere.Heat_Power.Total.U + Output.Lithosphere.Heat_Power.(layer).U;
        Output.Lithosphere.Heat_Power.Total.Th = Output.Lithosphere.Heat_Power.Total.Th + Output.Lithosphere.Heat_Power.(layer).Th;
    end
    Output.Lithosphere.Geonu_Signal.Total.Total = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.Total.Th232;
    Output.Lithosphere.Geonu_Flux.Total.Total = Output.Lithosphere.Geonu_Flux.Total.U238 + Output.Lithosphere.Geonu_Flux.Total.Th232;
    Output.Lithosphere.Heat_Power.Total.Total = Output.Lithosphere.Heat_Power.Total.U + Output.Lithosphere.Heat_Power.Total.Th;
    
    clear abun_mass_u238 abun_mass_th232 hp_res_u hp_res_th;
    clear template layers layer;
    
end