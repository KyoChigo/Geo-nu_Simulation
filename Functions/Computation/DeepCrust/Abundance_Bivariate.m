function abundance = Abundance_Bivariate(center_vp, layer_vp, param, cor_sio2, cor_abund)
% - Find index of closest bin for Vp - 
for i = 1:length(center_vp(:, 1))
[~,index(i,1)] = min(abs(center_vp(i,:)-layer_vp(i))); % 找到最小值对应的索引
probability(i,1) = cor_sio2(i,index(i));  % extract probability of SiO2 for "index" Vp bin；我不理解
end
% -- Calculate abundance from extracted log-normal parameters -- (exp brings into normal space)
mean = exp(param(probability,1)); 
eplus = exp(param(probability,1)+param(probability,2)); % convert log-values to normal
eminus = exp(param(probability,1)-param(probability,2));

abundance = Generate_Random_Log_Normal(mean,eplus,eminus,0,cor_abund); 
abundance = abundance'; % Row Vector %

end