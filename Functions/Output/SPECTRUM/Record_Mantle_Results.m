% ~~~~~~~~~~~~~~~~~~~~ Record ~~~~~~~~~~~~~~~~~~~~ %
Output.Mantle.Geonu_Spectrum.Depleted.U238 = SPECTRUM_U_DM;
Output.Mantle.Geonu_Spectrum.Depleted.Th232 = SPECTRUM_TH_DM;
Output.Mantle.Geonu_Spectrum.Depleted.Total = Output.Mantle.Geonu_Spectrum.Depleted.U238 + Output.Mantle.Geonu_Spectrum.Depleted.Th232;
Output.Mantle.Geonu_Spectrum.Enriched.U238 = SPECTRUM_U_EM;
Output.Mantle.Geonu_Spectrum.Enriched.Th232 = SPECTRUM_TH_EM;
Output.Mantle.Geonu_Spectrum.Enriched.Total = Output.Mantle.Geonu_Spectrum.Enriched.U238 + Output.Mantle.Geonu_Spectrum.Enriched.Th232;
Output.Mantle.Geonu_Spectrum.Total.U238 = Output.Mantle.Geonu_Spectrum.Depleted.U238 + Output.Mantle.Geonu_Spectrum.Enriched.U238;
Output.Mantle.Geonu_Spectrum.Total.Th232 = Output.Mantle.Geonu_Spectrum.Depleted.Th232 + Output.Mantle.Geonu_Spectrum.Enriched.Th232;
Output.Mantle.Geonu_Spectrum.Total.Total = Output.Mantle.Geonu_Spectrum.Total.U238 + Output.Mantle.Geonu_Spectrum.Total.Th232;

Output.Mantle.Geonu_Signal.Depleted.U238 = sum(SPECTRUM_U_DM, 2);
Output.Mantle.Geonu_Signal.Depleted.Th232 = sum(SPECTRUM_TH_DM, 2);
Output.Mantle.Geonu_Signal.Depleted.Total = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Depleted.Th232;
Output.Mantle.Geonu_Signal.Enriched.U238 = sum(SPECTRUM_U_EM, 2);
Output.Mantle.Geonu_Signal.Enriched.Th232 = sum(SPECTRUM_TH_EM, 2);
Output.Mantle.Geonu_Signal.Enriched.Total = Output.Mantle.Geonu_Signal.Enriched.U238 + Output.Mantle.Geonu_Signal.Enriched.Th232;
Output.Mantle.Geonu_Signal.Total.U238 = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Enriched.U238;
Output.Mantle.Geonu_Signal.Total.Th232 = Output.Mantle.Geonu_Signal.Depleted.Th232 + Output.Mantle.Geonu_Signal.Enriched.Th232;
Output.Mantle.Geonu_Signal.Total.Total = Output.Mantle.Geonu_Signal.Total.U238 + Output.Mantle.Geonu_Signal.Total.Th232;