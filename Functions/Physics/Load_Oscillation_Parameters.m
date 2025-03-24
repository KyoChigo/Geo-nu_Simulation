function Physics = Load_Oscillation_Parameters(Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 加载震荡参数 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Constant == 0: randomly generate oscillation parameters
%%% Constant == 1: use mean values form PDG %%%%%%%%%%%%%%%

Constant = Physics.Oscillation.Constant;
% From Table 14.7 in https://pdg.lbl.gov/2024/reviews/rpp2024-rev-neutrino-mixing.pdf
if(Constant == 0)
% Mixing angles
    Physics.Oscillation.Parameters.sin_theta12_square = 1e-1 * Generate_Random_Normal(3.03, 0.12, 1);
    Physics.Oscillation.Parameters.sin_theta13_square = 1e-2 * Generate_Random_Normal(2.203, 0.059, 1);
    Physics.Oscillation.Parameters.sin_theta23_square = 1e-1 * Generate_Random_Normal(5.72, 0.23, 1);
% Mass
    Physics.Oscillation.Parameters.delta_m21_square = 1e-5 * Generate_Random_Normal(7.41, 0.21, 1); % Unit: eV^2
    Physics.Oscillation.Parameters.delta_m31_square = 1e-3 * Generate_Random_Normal(2.437, 0.028, 1); % Unit: eV^2
    Physics.Oscillation.Parameters.delta_m32_square = 1e-3 * Generate_Random_Normal(2.437, 0.028, 1); % Unit: eV^2
elseif(Constant == 1)
% Mixing angles
    Physics.Oscillation.Parameters.sin_theta12_square = 1e-1 * 3.03;
    Physics.Oscillation.Parameters.sin_theta13_square = 1e-2 * 2.203;
    Physics.Oscillation.Parameters.sin_theta23_square = 1e-1 * 5.72;
    %%%%%%%%%%%%%%%%% Test %%%%%%%%%%%%%%%%%%%
    % Physics.Oscillation.Parameters.delta_m21_square = 1e-5 * 7.37; % Unit: eV^2
    % Physics.Oscillation.Parameters.delta_m32_n_square = 1e-3 * 2.56; % Unit: eV^2
    % Physics.Oscillation.Parameters.delta_m32_i_square = 1e-3 * -2.54; % Unit: eV^2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mass
    Physics.Oscillation.Parameters.delta_m21_square = 1e-5 * 7.41; % Unit: eV^2
    Physics.Oscillation.Parameters.delta_m31_square = 1e-3 * 2.437; % Unit: eV^2
    Physics.Oscillation.Parameters.delta_m32_square = 1e-3 * 2.437; % Unit: eV^2
end

% cos^2(A) = 1 - sin^2(A)
Physics.Oscillation.Parameters.cos_theta12_square = 1 - Physics.Oscillation.Parameters.sin_theta12_square;
Physics.Oscillation.Parameters.cos_theta13_square = 1 - Physics.Oscillation.Parameters.sin_theta13_square;
Physics.Oscillation.Parameters.cos_theta23_square = 1 - Physics.Oscillation.Parameters.sin_theta23_square;
% sin^2(2A) = 4 sin^2(A) cos^2(A)
Physics.Oscillation.Parameters.sin_2theta12_square = 4 * Physics.Oscillation.Parameters.sin_theta12_square * Physics.Oscillation.Parameters.cos_theta12_square;
Physics.Oscillation.Parameters.cos_2theta12_square = 1 - Physics.Oscillation.Parameters.sin_2theta12_square;

Physics.Oscillation.Parameters.sin_2theta13_square = 4 * Physics.Oscillation.Parameters.sin_theta13_square * Physics.Oscillation.Parameters.cos_theta13_square;
Physics.Oscillation.Parameters.cos_2theta13_square = 1 - Physics.Oscillation.Parameters.sin_2theta13_square;

Physics.Oscillation.Parameters.sin_2theta23_square = 4 * Physics.Oscillation.Parameters.sin_theta23_square * Physics.Oscillation.Parameters.cos_theta23_square;
Physics.Oscillation.Parameters.cos_2theta23_square = 1 - Physics.Oscillation.Parameters.sin_2theta23_square;
% Coefficients for Pee
sin_2theta12_square = Physics.Oscillation.Parameters.sin_2theta12_square;
cos_theta13_square = Physics.Oscillation.Parameters.cos_theta13_square;
sin_2theta13_square = Physics.Oscillation.Parameters.sin_2theta13_square;
cos_theta12_square = Physics.Oscillation.Parameters.cos_theta12_square;
sin_theta12_square = Physics.Oscillation.Parameters.sin_theta12_square;
%%%%%%%%%%%%%%%%% Survival Probability %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pee = 1 - sin^2(2\theta_12)cos^4(theta_13)sin^2(1.27m_12^2L/E)
% - sin^2(2\theta_13)cos^2(theta_12)sin^2(1.27m_13^2L/E)
% - sin^2(2\theta_13)sin^2(\theta_12)sin^2(1.27m_23^2L/E)
% = 1 + p1 * sin^2(1.27m_12^2L/E) + p2 * sin^2(1.27m_13^2L/E) + p3 * sin^2(1.27m_23^2L/E)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Physics.Oscillation.Coefficients.p1 = - sin_2theta12_square * cos_theta13_square^2;
Physics.Oscillation.Coefficients.p2 = - sin_2theta13_square * cos_theta12_square;
Physics.Oscillation.Coefficients.p3 = - sin_2theta13_square * sin_theta12_square;
clear sin_2theta12_square cos_theta13_square sin_2theta13_square cos_theta12_square sin_theta12_square;
% Output message
disp('[Physics::Load_Oscillation_Parameters] Oscillation parameters is complete');
end