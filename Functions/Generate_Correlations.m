function lithosphere = Generate_Correlations(lithosphere, iteration)

n = {'s1';'s2';'s3';'UC';'MC';'LC';'LM'};
randoms = Generate_Random_Standard_Normal(iteration); %only for thicknes`s correlation, which is same for all layers
% But thickness is negative sometimes. I don't know why

for interation = 1:length(n)    
    lithosphere.Cor(:).(n{interation}).Vp = Generate_Random_Standard_Normal(iteration); %"Generate_Random_Standard_Normal" is local function, see end of script
    lithosphere.Cor(:).(n{interation}).Abundance = Generate_Random_Standard_Normal(iteration);
    lithosphere.Cor(:).(n{interation}).Thickness = randoms;
end

% Abundances endmember (for Huang et al. 2013 method)
lithosphere.Cor.MC.End.Abundance = Generate_Random_Standard_Normal(iteration); % for felsic and mafic endmembers in MC (Huang et al. method)
lithosphere.Cor.LC.End.Abundance = Generate_Random_Standard_Normal(iteration); % for felsic and mafic endmembers in LC (Huang et al. method)

lithosphere.Cor.MC.Bivar.Abundance = Generate_Random_Standard_Normal(iteration); % for abundance of U, Th, K for each SiO2 bin
lithosphere.Cor.LC.Bivar.Abundance = Generate_Random_Standard_Normal(iteration); 

% Vp endmember (for Huang et al. 2013 method)
lithosphere.Cor.MC.End.Vp = Generate_Random_Standard_Normal(iteration); % for felsic and mafic endmembers in MC (Huang et al. method)
lithosphere.Cor.LC.End.Vp = Generate_Random_Standard_Normal(iteration); % for felsic and mafic endmembers in LC (Huang et al. method)
    
% Abundance endmember (for BSE and mantle mass balance)
lithosphere.Cor.BSE = Generate_Random_Standard_Normal(iteration); 
lithosphere.Cor.Mantle = Generate_Random_Standard_Normal(iteration);

clear randoms n