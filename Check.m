%%%%%%%%%%%% s1 %%%%%%%%%%%%%%%%%
%%% Mass %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load("./s1.mat");
total_mass = data.s1.Mass;
U_mass = sum(total_mass .* data.s1.Abundance.U, 1)';
Th_mass = sum(total_mass .* data.s1.Abundance.Th, 1)';
K_mass = sum(total_mass .* data.s1.Abundance.K, 1)';
Layer_mass = sum(total_mass, 1)';
s1.Mass = zeros(length(U_mass), 4);
s1.Mass(:, 1) = Layer_mass(:, 1);
s1.Mass(:, 2) = U_mass(:, 1);
s1.Mass(:, 3) = Th_mass(:, 1);
s1.Mass(:, 4) = 0.00011959 .* K_mass(:, 1);

data = load('./s2.mat');
total_mass = data.s2.Mass;
U_mass = sum(total_mass .* data.s2.Abundance.U, 1)';
Th_mass = sum(total_mass .* data.s2.Abundance.Th, 1)';
K_mass = sum(total_mass .* data.s2.Abundance.K, 1)';
Layer_mass = sum(total_mass, 1)';
s2.Mass = zeros(length(U_mass), 4);
s2.Mass(:, 1) = Layer_mass(:, 1);
s2.Mass(:, 2) = U_mass(:, 1);
s2.Mass(:, 3) = Th_mass(:, 1);
s2.Mass(:, 4) = 0.00011959 .* K_mass(:, 1);

data = load('./s3.mat');
total_mass = data.s3.Mass;
U_mass = sum(total_mass .* data.s3.Abundance.U, 1)';
Th_mass = sum(total_mass .* data.s3.Abundance.Th, 1)';
K_mass = sum(total_mass .* data.s3.Abundance.K, 1)';
Layer_mass = sum(total_mass, 1)';
s3.Mass = zeros(length(U_mass), 4);
s3.Mass(:, 1) = Layer_mass(:, 1);
s3.Mass(:, 2) = U_mass(:, 1);
s3.Mass(:, 3) = Th_mass(:, 1);
s3.Mass(:, 4) = 0.00011959 .* K_mass(:, 1);

Total.Mass = s3.Mass .* 0;
Total.Mass = s1.Mass + s2.Mass + s3.Mass;
%%%%%%%%%%%% Crust %%%%%%%%%%%%%%%%%
data = load("./UC.mat");
total_mass = data.UC.Mass;
U_mass = sum(total_mass .* data.UC.Abundance.U, 1)';
Th_mass = sum(total_mass .* data.UC.Abundance.Th, 1)';
K_mass = sum(total_mass .* data.UC.Abundance.K, 1)';
Layer_mass = sum(total_mass, 1)';
UC.Mass = zeros(length(U_mass), 4);
UC.Mass(:, 1) = Layer_mass(:, 1);
UC.Mass(:, 2) = U_mass(:, 1);
UC.Mass(:, 3) = Th_mass(:, 1);
UC.Mass(:, 4) = 0.00011959 .* K_mass(:, 1);

data = load("./MC.mat");
total_mass = data.MC.Mass;
U_mass = sum(total_mass .* data.MC.Abundance.U, 1)';
Th_mass = sum(total_mass .* data.MC.Abundance.Th, 1)';
K_mass = sum(total_mass .* data.MC.Abundance.K, 1)';
Layer_mass = sum(total_mass, 1)';
MC.Mass = zeros(length(U_mass), 4);
MC.Mass(:, 1) = Layer_mass(:, 1);
MC.Mass(:, 2) = U_mass(:, 1);
MC.Mass(:, 3) = Th_mass(:, 1);
MC.Mass(:, 4) = 0.00011959 .* K_mass(:, 1);

data = load("./LC.mat");
total_mass = data.LC.Mass;
U_mass = sum(total_mass .* data.LC.Abundance.U, 1)';
Th_mass = sum(total_mass .* data.LC.Abundance.Th, 1)';
K_mass = sum(total_mass .* data.LC.Abundance.K, 1)';
Layer_mass = sum(total_mass, 1)';
LC.Mass = zeros(length(U_mass), 4);
LC.Mass(:, 1) = Layer_mass(:, 1);
LC.Mass(:, 2) = U_mass(:, 1);
LC.Mass(:, 3) = Th_mass(:, 1);
LC.Mass(:, 4) = 0.00011959 .* K_mass(:, 1);

Total.Mass = LC.Mass .* 0;
Total.Mass = UC.Mass + MC.Mass + LC.Mass;

%%%%%%%%%%%% Sediment + Crust
Total.Mass = UC.Mass + MC.Mass + LC.Mass + s1.Mass + s2.Mass + s3.Mass;

%%%%%%%%%%%% LM
data = load("./LM.mat");
total_mass = data.LM.Mass;
U_mass = sum(total_mass .* data.LM.Abundance.U, 1)';
Th_mass = sum(total_mass .* data.LM.Abundance.Th, 1)';
K_mass = sum(total_mass .* data.LM.Abundance.K, 1)';
Layer_mass = sum(total_mass, 1)';
LM.Mass = zeros(length(U_mass), 4);
LM.Mass(:, 1) = Layer_mass(:, 1);
LM.Mass(:, 2) = U_mass(:, 1);
LM.Mass(:, 3) = Th_mass(:, 1);
LM.Mass(:, 4) = 0.00011959 .* K_mass(:, 1);

Total.Mass = LM.Mass;
%%%%%%%%%%%%% Lithosphere
Total.Mass = LM.Mass + UC.Mass + MC.Mass + LC.Mass + s1.Mass + s2.Mass + s3.Mass;