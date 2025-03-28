function Physics = SPECTRUM_Load_Oscillation_Parameters(Physics)
% ~~~~~~~~~~~~~~~~~~~~ Load Oscillation Parameters ~~~~~~~~~~~~~~~~~~~~ %
% This function will reprocess all variables in oscillation structure and
% only works in SPECTRUM version                                        %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

% % ~~~~~~~~~~~~~~~~~~~~ Computation Parameters ~~~~~~~~~~~~~~~~~~~~ %
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

end