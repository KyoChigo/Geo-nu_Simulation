function abundance = Abundance_Equation(abundance_fel, abundance_maf, fraction)
%%%% Have no idea what's meaning of these tree parameters. One said this is from Huang et al. 2013, eq.3

abundance = abundance_fel .* fraction + abundance_maf .* ( 1 - fraction);

end