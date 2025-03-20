function Geology = Generate_Correlations(Geology)
iteration = Geology.Iteration;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 随机产生相关系数 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
randoms = Generate_Random_Standard_Normal(iteration); % 所有层数厚度的关联系数都一样
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
for i = 1:length(layers)
    layer = layers{i};
    template.Vp = Generate_Random_Standard_Normal(iteration);
    template.Abundance = Generate_Random_Standard_Normal(iteration);
    template.Thickness = randoms;
    Geology.Lithosphere.Model.Correlation.(layer) = template;
end
clear layers i layer template;
%%% %%% End and Bivar are used for computate abundance in MC and LC
%%% End is used in Huang method; Bivar is used in Bivart method
layers = {'MC', 'LC'};
for i = 1:length(layers)
    layer = layers{i};
    template.End.Abundance = Generate_Random_Standard_Normal(iteration);
    template.End.Vp = Generate_Random_Standard_Normal(iteration);
    template.Bivar.Abundance = Generate_Random_Standard_Normal(iteration);
    Geology.Lithosphere.Model.Correlation.(layer).DeepCrust = template;
end
clear layers i layer template;
Geology = Generate_Correlations_DeepCrust(Geology, iteration);
%%% Mantle %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Geology.Mantle.Correlation = Generate_Random_Standard_Normal(iteration);
%%% BSE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Geology.BSE.Correlation = Generate_Random_Standard_Normal(iteration);
end