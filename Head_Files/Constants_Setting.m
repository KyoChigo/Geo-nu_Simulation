%%%%%%%%%%%%%%%%%%%%%%%%%%% Detector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
detector.Index = 0;
detector.Note = {'经度(degree)','纬度(degree)','深度(m)','探测效率(%)','质子数','最近的cell经纬度'};
detector.Data = 0;
%名字、精度、维度、深度、探测效率、质子数、探测器最近的一个cell的经纬度
set_detectors={137.31, 36.43, 1000, 0.7, 5.98*10^31,[134,34];... %KamLAND - Araki etal. (2005) 
                     13.57, 42.45, 1400, 0.842, 9.76E+30,[10,40];...   %Borexino - Wikipedia LNGS
                     -81.201, 46.475, 2092, 0.8, 5.76E+31,[-84,44];...  %SNO+ - Chen (2007), Andringa etal. (2016)
                     112.518, 22.118, 700, 0.8, 1.29E+33,[109,20];...   %JUNO - An etal. (2016) JUNO Yellowbook
                     101.71, 28.15, 2400, 0.8, 2.16E+32,[99,26];...    %Jinping - Beacom etal. (2016) letter of intent
                     -156.32, 19.72, 0, 0.8, 0,[-160,18];         %Hawaii
               };
%%%%%%%%%%%%%%%%%%%%%%%%%%% Lithosphere %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lithosphere.Index = 0;
lithosphere.Model_Name = 0; % 记录模型名字
lithosphere.Model_Data = 0; % 加载模型数据
lithosphere.Logical.CC = 0; % Bool型数组，标记哪块cell是 continental crust
lithosphere.Logical.OC = 0; % Bool型数组，标记哪块cell是 oceanic crust
set_lithosphere_models = {'Litho1','Crust1','Crust2','ECM1'};
%%%%%%%%%%%%%%%%%%%%%%%%%%% Elements Setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Elements.Potassium.K39.Mass.Atom = 39.0983; % Unit: amu; from Wiki
Elements.Potassium.K40.Mass.Atom = 39.96399848; % Unit: amu; from Wiki
Elements.Potassium.K39.Mass_Ratio = (2*Elements.Potassium.K39.Mass.Atom)/((2*Elements.Potassium.K39.Mass.Atom)+(15.999)); % mass ratio of K2O, where K is K39;
Elements.Potassium.K40.Relative_Abundance.Atom_Number = 0.000117; % The number of K40 in potassium; from Wiki
Elements.Potassium.K40.Relative_Abundance.Mass = 0.000119; % Formular: 0.0117% * K40 / (93.2581% * K39 + 0.0117% * K40 + 6.73% * K41)

Elements.Heat_Power.Unit = 'Watt/kg';
Elements.Heat_Power.U238 = 94.936*10^-6;  %(Watt/kg)
Elements.Heat_Power.U235 = 561.65*10^-6; %(Watt/kg)
Elements.Heat_Power.U = 98.293*10^-6;  %(Watt/kg)
Elements.Heat_Power.Th = 26.180*10^-6;  %(Watt/kg)
Elements.Heat_Power.K40 = 29.029*10^-6;  %(Watt/kg)
%%%%%% Molar(or number) ratio
Elements.Relative_Abundance.Note = 'TBD';
Elements.Relative_Abundance.U238 = 0.992740;
Elements.Relative_Abundance.U235 = 1 - Elements.Relative_Abundance.U238;
Elements.Relative_Abundance.Th232 = 1.00;
Elements.Relative_Abundance.K40 = 0.0001167;
%%%%%% Atomic mass 
Elements.Atomic_Mass.Unit = 'amu';
Elements.Atomic_Mass.U238 = 238.0507826; % Unit: amu
Elements.Atomic_Mass.U235 = 235.0439231; % Unit: amu
Elements.Atomic_Mass.Th232 = 232.0380504; % Unit: amu
Elements.Atomic_Mass.K40 = 39.9639987; % Unit: amu
Elements.Atomic_Mass.amu_kg = 1.660539040*10^-27; % Convert amu to kg
Elements.Avogadro = 6.022140857*10^23; % http://physics.nist.gov/cgi-bin/cuu/Value?na
%%%%%% Decay Constant
Elements.Decay_Constants.Unit = '1/s';
Elements.Decay_Constants.U238 = log(2)/(4.4683e9*3.15569e7);  % Unit: 1/s
Elements.Decay_Constants.U235 = log(2)/(0.70348e9*3.15569e7); % Unit: 1/s
Elements.Decay_Constants.Th232 = log(2)/(14.1e9*3.15569e7); % Unit: 1/s
Elements.Decay_Constants.K40 = log(2)/(1.262e9*3.15569e7); % Unit: 1/s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Oscillation Parameters
%%% All valures come from Table 14.7 in PDG 2024:https://pdg.lbl.gov/2024/reviews/rpp2024-rev-neutrino-mixing.pdf
%%% Use largest uncentainty as sigma in Gaussian distribution
Oscillation.Parameters.Unit = 'eV^2';
Oscillation.Parameters.Delta_m21 = (1e-5) * Generate_Random_Normal(7.41, 0.21, 0); % Unit:eV^2
Oscillation.Parameters.Delta_m32_normal = (1e-3) * Generate_Random_Normal(2.437, 0.028, 0); % Unit: eV^2
Oscillation.Parameters.Delta_m32_inverse = (1e-3) * Generate_Random_Normal(-2.498, 0.032, 0); %Unit:eV^2
Oscillation.Parameters.sin_theta12_square = 0.1 * Generate_Random_Normal(3.03, 0.12, 0);
Oscillation.Parameters.cos_theta12_square = 1 - Oscillation.Parameters.sin_theta12_square;
Oscillation.Parameters.sin_theta23_square = 0.1 * Generate_Random_Normal(5.721, 0.23, 0);
Oscillation.Parameters.cos_theta23_square = 1 - Oscillation.Parameters.sin_theta23_square;
Oscillation.Parameters.sin_theta13_square = 0.01 * Generate_Random_Normal(2.203, 0.059, 0);
Oscillation.Parameters.cos_theta13_square = 1 - Oscillation.Parameters.sin_theta13_square;
%%% Survival probability of anti-electron neutrino
sin_2theta12_square = 4 * Oscillation.Parameters.sin_theta12_square * Oscillation.Parameters.cos_theta12_square;
cos_2theta12_square = 1 -sin_2theta12_square;
sin_2theta13_square = 4 * Oscillation.Parameters.sin_theta13_square * Oscillation.Parameters.cos_theta13_square;
cos_2theta13_square = 1 - sin_2theta13_square;


Oscillation.Pee.part1 = Oscillation.Parameters.cos_theta13_square^2 * sin_2theta12_square;
Oscillation.Pee.part2 = sin_2theta13_square * cos_2theta12_square;
Oscillation.Pee.part3 = sin_2theta13_square;

clear sin_2theta13_square sin_2theta12_square cos_2theta13_square cos_2theta12_square