function Geology = Generate_Correlations_DeepCrust(Geology, iteration)
%%%%%%%%%% MC %%%%%%%%%%%%%%%%%%%%%
data = Geology.Lithosphere.Model.Data.Bivar.seis.amp.prob;
for i = 1 :length(data(1, :))
    probability = data(:, i); % 第i列
    probability_normalize = probability(:) / sum(probability(:)); % 每列相对归一化
    probability_with_zero = [0; probability_normalize]; % 让0成为第一个元素
    probability_comulative = cumsum(probability_with_zero); % 得到累积分布函数
    probability_comulative(end) = 1e3*eps + probability_comulative(end); % 数值程序小技巧，变成双浮点型数据？
    [~, ~, Geology.Lithosphere.Model.Correlation.MC.DeepCrust.Bivar.SiO2(:, i)] = histcounts(rand(iteration, 1), probability_comulative);
    % histcounts(data, bins):  将data填进bins中；第三个参数是索引，即第i个data落在了哪个bin中
end
%%%%%%%%% LC %%%%%%%%%%%%%%%%%%%%%
%%% Granulite的关于xxx的PDF
data = Geology.Lithosphere.Model.Data.Bivar.seis.gran.prob;
for i = 1 :length(data(1, :))
    probability = data(:, i); % 第i列
    probability_normalize = probability(:) / sum(probability(:)); % 每列相对归一化
    probability_with_zero = [0; probability_normalize]; % 让0成为第一个元素
    probability_comulative = cumsum(probability_with_zero); % 得到累积分布函数
    probability_comulative(end) = 1e3*eps + probability_comulative(end); % 数值程序小技巧，变成双浮点型数据？
    [~, ~, Geology.Lithosphere.Model.Correlation.LC.DeepCrust.Bivar.SiO2(:, i)] = histcounts(rand(iteration, 1), probability_comulative);
    % histcounts(data, bins): 将data填进bins中；第三个参数是索引，即第i个data落在了哪个bin中
end
clear data i probability probability_normalize probability_with_zero probability_comulative
%%%
end