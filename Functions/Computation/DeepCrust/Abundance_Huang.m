function abundance = Abundance_Huang(Abundance_Fel_Element, Abundance_Maf_Element, fraction)
abundance = Abundance_Fel_Element .* fraction + (1 - fraction) .* Abundance_Maf_Element;
end