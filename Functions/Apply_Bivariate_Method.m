function lithosphere = Apply_Bivariate_Method(lithosphere, iteration)

simple2 = lithosphere.Deepcrust;

%%%%%%%%%% From the comments from the original codes, prob is the PDF os SiO2(row) v.s. Vp(column)

%Granulite: Data from granulite facies rocks is used as a lower crust compositional proxy.
for i = 1:length(simple2.Bivar.seis.gran.prob(1,:)) % loop through Vp bins
    % loop as columns
    P = simple2.Bivar.seis.gran.prob(:,i); %probability of each SiO2 bin (row) for each Vp bin (column)
    % P is the array of i-th colum
%%%%%%%%%% Normalize P array
    P_normalized = P(:)/ sum(P(:));
%%%%%%%%%% Add a zero at the beginning to make sure the P_comulative starts from zero
    P_with_zero = [0; P_normalized];
%%%%%%%%%% Get cumulative distribution
    P_comulative = cumsum(P_with_zero);%cumulative sum of # of samples for givin Vp bin
    P_comulative(end) = 1e3*eps + P_comulative(end); % sets end value slightly larger than 1 (why?)
%%%%%%%%%% ChatGPT: Make sure rand() gives random number withi [0, 1)
    % The following code creates a matrix of length = iter of randomly
    % selected (based on probability from P) SiO2 bins. The syntax
    % "[~,~,X] = histcounts"returns the bin edges (really SiO2 bin) 
    % which we will use later for indexing SiO2 fit parameters. 
    [~,~,lithosphere.Cor.LC.Bivar.SiO2(:,i)] = histcounts(rand(iteration,1),P_comulative); % provides length = iter of bins to 
%%%%%%%%%% rand(iteration,1): generate random matrix (iteration *1), where elements in [0, 1)
%%%%%%%%%% P_comulative has N elements, and define N-1 bins
%%%%%%%%%% histcounts(): put random matrix in P_comulative, and count the entries of each bin
%%%%%%%%%% [~,~, xxx]: the first two ~ represent the number of data points, and the bins; xxx is a iteration * 1 array and record the index of bin in P_comulative where the element locates
end
%Amphibolite: Data from amphibolite facies rocks is used as a middle crust compositional proxy.
for i = 1:length(simple2.Bivar.seis.amp.prob(1,:))
    P = simple2.Bivar.seis.amp.prob(:,i); 
%%%%%%%%%% Normalize P array
    P_normalized = P(:)/ sum(P(:));
%%%%%%%%%% Add a zero at the beginning to make sure the P_comulative starts from zero
    P_with_zero = [0; P_normalized];
%%%%%%%%%% Get cumulative distribution
    P_comulative = cumsum(P_with_zero);%cumulative sum of # of samples for givin Vp bin
    P_comulative(end) = 1e3*eps + P_comulative(end); % sets end value slightly larger than 1 (why?)
    [~,~,lithosphere.Cor.MC.Bivar.SiO2(:,i)] = histcounts(rand(iteration,1),P_comulative);% sorted so there is correlation, ok since no other correlation is sorted
end
clear P P_normalized P_with_zero P_comulative i simple2
%%%%%%%%%% Finally sio2 is a iteration * 9 array. But I don't know what's the meaning of 9 columns