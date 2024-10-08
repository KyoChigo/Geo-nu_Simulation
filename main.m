%%%%%%%%%%%%%%%%% 指定头文件路径 %%%%%%%%%%%%%%%%%%%%%%%%%
addpath("Functions\");
addpath("Functions\Math\");
addpath("Functions\Physics\");
addpath("Physics\");
addpath('Data_Structures\');
addpath("Input_Files\");
addpath("Input_Files\LithosphereModels\");
%%%%%%%%%%%%%%%%% 加载必要的头文件 %%%%%%%%%%%%%%%%%%%%%%%
run("Physics\Constants_Physics.m");
run("Data_Structures\Structure_Geology.m");

%%%%%%%%%%%%%%%%% Lithosphere part %%%%%%%%%%%%%%%%%%%%%%
Geology.Lithosphere.Model.Name = 

