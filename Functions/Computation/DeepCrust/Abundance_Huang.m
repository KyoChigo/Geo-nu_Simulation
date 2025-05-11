function abundance = Abundance_Huang(Abundance_Fel_Element, Abundance_Maf_Element, fraction)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Abundance_Huang.m
% Description     : Compute abundance for one kind of HPEs in Huang method
%
% Adapted from    : Abund_And_Flux() by Scott A. Wipperfurth
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - Abundance_Fel_Element     : Abundance of X in felsic
%   - Abundance_Maf_Element     : Abundance of X in mafic
%   - fraction                  : Fraction of felsic
%
% Output Parameters:
%   - abundance (g/g)   : Abundance of one kind of HPEs
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

abundance = Abundance_Fel_Element .* fraction + (1 - fraction) .* Abundance_Maf_Element;
end