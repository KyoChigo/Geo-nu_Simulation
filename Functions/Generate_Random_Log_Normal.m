function [distribution, log_mu, log_sigma] = Generate_Random_Log_Normal(mu,plusError,minusError,int,locate)
%%%%%%%%%%%%% Corrsponding logdist.m %%%%%%%%%%%%%%%%%%%%%%%
% Log-normal distribution is X = exp( mu + sigma * Z), where Z is standard normal distribution, i.e. Z~N(0, 1)
% X~log-normal(mu, sigma). 
% However the expection and standard variation of log-normal distribution aren't mu and sigma !!!!!!!!

% I doubt whether Wipperfurth really understands log-normal dirstribution

% if int == 1, this function returns mu;
% if int == 0, this function returns a number of log-normal distribution
% if int > 1, this function returns a array (int * 1 or length(locate) * 1) of log-normal distribution, all elements are randomly generated

% if nargin == 4, this funciton uses N(0,1) to generate log-normal distribution
% if nargin == 5, this function uses locate to generate log-normal distribution

if nargin == 4 
% nargin is defined by MATLAB, which records the number of input parameters

    if int == 1 % CENTRAL Value
              distribution = mu;



    elseif int >1% MONTE CARLO 
            log_mu = log(mu);
            log_plus = log(mu + plusError) - log_mu;
            log_minus = log_mu - log(mu - minusError);
            log_sigma = (log_plus+log_minus)/2;
    
            distribution = exp(randn(int,1).*log_sigma(:)+log_mu(:));




    elseif int ==0 %(i.e. you want 1 random value from the distribution)

            log_mu = log(mu);
            log_plus = log(mu + plusError) - log_mu;
            log_minus = log_mu - log(mu - minusError);
            log_sigma = (log_plus+log_minus)/2;

            distribution = exp(randn(1,1).*log_sigma(:)+log_mu(:));


    end
    
elseif nargin == 5
    % Find random numbers when specified random distribution
    if int == 1 % CENTRAL Value
              distribution = mu;



    elseif int >1% MONTE CARLO 
            log_mu = log(mu);
            log_plus = log(mu + plusError) - log_mu;
            log_minus = log_mu - log(mu - minusError);
            log_sigma = (log_plus+log_minus)/2;

            distribution = exp(locate.*log_sigma(:)+log_mu(:)); %single outputs in single precision




    elseif int ==0 %(i.e. you want 1 random value from the distribution)

            log_mu = log(mu);
            log_plus = log(mu + plusError) - log_mu;
            log_minus = log_mu - log(mu - minusError);
            log_sigma = (log_plus+log_minus)/2;

            distribution = exp(locate.*log_sigma(:)+log_mu(:));%single outputs in single precision

    else
        warning('You entered %d input(s). You need 4 or 5.',nargin);
    end  
end
