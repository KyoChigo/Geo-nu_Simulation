function cross_section = Compute_IBD_Cross_Section(Energy)

me = 0.5109989461; %mass electron (MeV)
delta = 939.5654133 - 938.2720813; %Mass_Neutron - Mass_Proton (MeV)

Energy = Energy/1000; % Unit: MeV

if(Energy <= 1.806)
    cross_section = 0.0;
elseif(Energy > 1.806)
    cross_section = 9.52*((Energy-delta).^2).*sqrt(1-(me^2./(Energy-delta).^2))*(10^-44); % Unit: cm^22
end