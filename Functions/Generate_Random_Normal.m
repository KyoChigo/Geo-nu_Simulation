function [dist] = Generate_Random_Normal(mu,error,int,locate)
% if int == 0, this fucntion returns one value
% if int == 1, this function returns mean value
% inf int > 1, this function return an array (int * 1 or length(locate) * 1) of Gaussian distribution

% if nargin == 3, this funciton uses N(0,1) to generate log-normal distribution
% if nargin == 4, this function uses locate to generate log-normal distribution 




if nargin == 3 
% nargin is defined by MATLAB, which records the number of input parameters
    if int == 1   % returns central value

                dist = mu;


    elseif int > 1% returns distribution of "int" length 

                dist = randn(int,1).*error + mu;


    elseif int == 0 %returns 1 random value from the distribution 

                dist = randn(1,1).*error + mu;


    end
    
elseif nargin == 4 % Find random numbers when specified random distribution
     if int == 1   % returns central value

                dist = mu;


    elseif int > 1% returns distribution of "int" length 

                dist = locate.*error + mu;


    elseif int == 0 %returns 1 random value from the distribution 

                dist = locate.*error + mu;

     end   
else
    warning('You entered %d input(s). You need 3 or 4.',nargin);
end