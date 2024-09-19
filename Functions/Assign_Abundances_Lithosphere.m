function lithosphere = Assign_Abundances_Lithosphere(lithosphere, HPE, iteration)

OC = lithosphere.Logical.OC;
CC = lithosphere.Logical.CC;
Cor = lithosphere.Cor;

template = zeros(length(lithosphere.Logical.OC), 3); % record mean and uncertainty
temp_OC_U = template;
temp_OC_Th = template;
temp_OC_K = template;

%%%%%%%%%%%%%%%%%%%%%%%% For the OC State (where element is true in OC), assign the abundance of XXXX.
temp_OC_U(OC, :) = repmat(HPE.Abundance.OC.U, sum(OC), 1);
temp_OC_Th(OC, :) = repmat(HPE.Abundance.OC.Th, sum(OC), 1);
temp_OC_K(OC, :) = repmat(HPE.Abundance.OC.K, sum(OC), 1);

%%%%%%%%%%%%%%%%%%%%%%%% Assign the Abundance of OC states in UC, MC and LC %%%%%%%%%%%%%%%%
%%%%%%%% Unit: kg/kg
[lithosphere.Layers.UC.Abundance.U, lithosphere.Layers.MC.Abundance.U, lithosphere.Layers.LC.Abundance.U] = deal(temp_OC_U);
[lithosphere.Layers.UC.Abundance.Th, lithosphere.Layers.MC.Abundance.Th, lithosphere.Layers.LC.Abundance.Th] = deal(temp_OC_Th);
[lithosphere.Layers.UC.Abundance.K, lithosphere.Layers.MC.Abundance.K, lithosphere.Layers.LC.Abundance.K] = deal(temp_OC_K);
%%%%%%%%%%%%%%%%%%%%%%%% Assign the Abundance of CC states in UC and LM%%%%%%%%%%%%%%%
%%%%%%%% Unit: kg/kg
lithosphere.Layers.UC.Abundance.U(CC, :) = repmat(HPE.Abundance.UC.U, sum(CC), 1);
lithosphere.Layers.UC.Abundance.Th(CC, :) = repmat(HPE.Abundance.UC.Th, sum(CC), 1);
lithosphere.Layers.UC.Abundance.K(CC, :) = repmat(HPE.Abundance.UC.K, sum(CC), 1);

lithosphere.Layers.LM.Abundance.U(CC, :) = repmat(HPE.Abundance.LM.U, sum(CC), 1);
lithosphere.Layers.LM.Abundance.Th(CC, :) = repmat(HPE.Abundance.LM.Th, sum(CC), 1);
lithosphere.Layers.LM.Abundance.K(CC, :) = repmat(HPE.Abundance.LM.K, sum(CC), 1);
%%%%%%%%%%%%%%%%%%%%%%%% Assign the sediment %%%%%%%%%%%%%%%%%%%%%
len = length(lithosphere.Model_Data.ice.lat); % len is the total number of cells. Therefore you can replace it with other structure
temp_sed_U = repmat(HPE.Abundance.Sediment.U, len, 1);
temp_sed_Th = repmat(HPE.Abundance.Sediment.Th, len, 1);
temp_sed_K = repmat(HPE.Abundance.Sediment.K, len, 1);

[lithosphere.Layers.s1.Abundance.U, lithosphere.Layers.s2.Abundance.U, lithosphere.Layers.s3.Abundance.U] = deal(temp_sed_U);
[lithosphere.Layers.s1.Abundance.Th, lithosphere.Layers.s2.Abundance.Th, lithosphere.Layers.s3.Abundance.Th] = deal(temp_sed_Th);
[lithosphere.Layers.s1.Abundance.K, lithosphere.Layers.s2.Abundance.K, lithosphere.Layers.s3.Abundance.K] = deal(temp_sed_K);
%%%%%%%%%%%%%%%%%%%%%%%%% Assign the abundance and speed of p-wave of MC and LC %%%%%%%%%%%%
ppm = 1e-6;
wt = 10^-2 * 0.000112 * 0.83; %10^-2 to bring to kg/kg, .000112 to bring K to K40, and 0.83 for K20 to K 
% Have no idea what's meaning of wt !!!!!!!!
%%%%%%%%%%%%%% Middle crust %%%%%%%%%%%
lithosphere.Rock.Amphibolite.felsic.Abundance.U = Generate_Random_Log_Normal(1.37,1.03,0.59,iteration,Cor.MC.End.Abundance)*ppm;
lithosphere.Rock.Amphibolite.felsic.Abundance.Th = Generate_Random_Log_Normal(8.27,8.12,4.10,iteration,Cor.MC.End.Abundance)*ppm;
lithosphere.Rock.Amphibolite.felsic.Abundance.K = Generate_Random_Log_Normal(2.89,1.81,1.11,iteration,Cor.MC.End.Abundance)*wt;
lithosphere.Rock.Amphibolite.mafic.Abundance.U = Generate_Random_Log_Normal(0.37,0.39,0.19,iteration,Cor.MC.End.Abundance)*ppm; %U
lithosphere.Rock.Amphibolite.mafic.Abundance.Th = Generate_Random_Log_Normal(0.58,0.57,0.29,iteration,Cor.MC.End.Abundance)*ppm; %Th
lithosphere.Rock.Amphibolite.mafic.Abundance.K = Generate_Random_Log_Normal(0.50,0.41,0.23,iteration,Cor.MC.End.Abundance)*wt; %K

lithosphere.Rock.Amphibolite.felsic.Vp = Generate_Random_Normal(6.34,0.16,iteration,Cor.MC.End.Vp); % (km/s) (normal dist.)
lithosphere.Rock.Amphibolite.mafic.Vp = Generate_Random_Normal(6.98,0.20,iteration,Cor.MC.End.Vp); % (km/s) (normal dist.)
%%%%%%%%%%%%%% Lower crust %%%%%%%%%%%%
lithosphere.Rock.Granulite.felsic.Abundance.U = Generate_Random_Log_Normal(0.42,0.41,0.21,iteration,Cor.LC.End.Abundance)*ppm;
lithosphere.Rock.Granulite.felsic.Abundance.Th = Generate_Random_Log_Normal(3.87,7.35,2.54,iteration,Cor.LC.End.Abundance)*ppm;
lithosphere.Rock.Granulite.felsic.Abundance.K = Generate_Random_Log_Normal(2.71,2.05,1.17,iteration,Cor.LC.End.Abundance)*wt;
lithosphere.Rock.Granulite.mafic.Abundance.U = Generate_Random_Log_Normal(0.10,0.14,0.06,iteration,Cor.LC.End.Abundance)*ppm;
lithosphere.Rock.Granulite.mafic.Abundance.Th = Generate_Random_Log_Normal(0.30,0.46,0.18,iteration,Cor.LC.End.Abundance)*ppm;
lithosphere.Rock.Granulite.mafic.Abundance.K = Generate_Random_Log_Normal(0.39,0.31,0.17,iteration,Cor.LC.End.Abundance)*wt; 

lithosphere.Rock.Granulite.felsic.Vp = Generate_Random_Normal(6.52,0.19,iteration,Cor.LC.End.Vp); % (km/s) (normal dist.)
lithosphere.Rock.Granulite.mafic.Vp = Generate_Random_Normal(7.21,0.20,iteration,Cor.LC.End.Vp); % (km/s) (normal dist.) 

clear Logical CC temp_Logical_U temp_Logical_Th temp_Logical_K temp_sed_U temp_sed_Th temp_sed_K Cor ppm wt