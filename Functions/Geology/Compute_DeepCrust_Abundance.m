function Geology = Compute_DeepCrust_Abundance(Physics, Geology)
ppm = 1e-6;
K2O = Physics.Constants.Others.K_K2O; % K在K2O中的质量分数, Unit: 1
K40 = Physics.Elements.Abundance.Mass.K40; % K40的质量分数, Unit: 1
wt = 0.01 * K2O * K40; % 为什么乘0.01？
iteration = Geology.Iteration;
%%% Amphibolite
%%% %%% Amphibolite.felsic
cor = Geology.Lithosphere.Model.Correlation.MC.DeepCrust.End.Abundance;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.U = Generate_Random_Log_Normal(1.37, 1.03, 0.59, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.Th = Generate_Random_Log_Normal(8.27, 8.12, 4.10, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.K = Generate_Random_Log_Normal(2.89, 1.81, 1.11, iteration, cor) * wt;

Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.U  = Generate_Random_Log_Normal(0.37, 0.39, 0.19, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.Th = Generate_Random_Log_Normal(0.58, 0.57, 0.29, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.K = Generate_Random_Log_Normal(0.50, 0.41, 0.23, iteration, cor) * wt;
%%% Granulite
cor = Geology.Lithosphere.Model.Correlation.LC.DeepCrust.End.Abundance;
Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.U = Generate_Random_Log_Normal(0.42, 0.41, 0.21, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.Th = Generate_Random_Log_Normal(3.87, 7.35, 2.54, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.K = Generate_Random_Log_Normal(2.71, 2.05, 1.17, iteration, cor) * wt;

Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.U  = Generate_Random_Log_Normal(0.10, 0.14, 0.06, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.Th = Generate_Random_Log_Normal(0.30, 0.46, 0.18, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.K = Generate_Random_Log_Normal(0.39, 0.31, 0.17, iteration, cor) * wt;
end