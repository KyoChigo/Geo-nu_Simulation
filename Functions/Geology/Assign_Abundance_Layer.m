function Geology = Assign_Abundance_Layer(Geology, Name_Layer, abund_U, abund_Th, abund_K)
%%% 指定U、Th和K的丰度；注意K包括所有K元素而非K40
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 加载Detector数据 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% abundance_element: g/g
logical_oc = Geology.Lithosphere.Model.Logical.OC;
logical_cc = Geology.Lithosphere.Model.Logical.CC;
layers = {'null'};
if strcmp(Name_Layer, 'OC')
    layers = {'UC', 'MC', 'LC'};
    for i = 1 : length(layers)
        layer = layers{i};
        for j = 1 : length(logical_cc)
            if(logical_oc(j) == true)
            Geology.Lithosphere.Model.Abundance.(layer).U(j, :) = abund_U;
            Geology.Lithosphere.Model.Abundance.(layer).Th(j, :) = abund_Th;
            Geology.Lithosphere.Model.Abundance.(layer).K(j, :) = abund_K;
        end
        end
    end
elseif strcmp(Name_Layer, 'UC_CC')
    for i = 1 : length(logical_oc)
        if(logical_cc(i) == true)
            Geology.Lithosphere.Model.Abundance.UC.U(i, :) = abund_U;
            Geology.Lithosphere.Model.Abundance.UC.Th(i, :) = abund_Th;
            Geology.Lithosphere.Model.Abundance.UC.K(i, :) = abund_K;
        end
    end
elseif strcmp(Name_Layer, 'LM_CC')
    for i = 1 : length(logical_oc)
        if(logical_cc(i) == true)
            Geology.Lithosphere.Model.Abundance.LM.U(i, :) = abund_U;
            Geology.Lithosphere.Model.Abundance.LM.Th(i, :) = abund_Th;
            Geology.Lithosphere.Model.Abundance.LM.K(i, :) = abund_K;
        end
    end
elseif strcmp(Name_Layer, 'Sed')
    layers = {'s1', 's2', 's3'};
    for i = 1 : length(layers)
        layer = layers{i};
        for j = 1 : length(logical_cc)
            Geology.Lithosphere.Model.Abundance.(layer).U(j, :) = abund_U;
            Geology.Lithosphere.Model.Abundance.(layer).Th(j, :) = abund_Th;
            Geology.Lithosphere.Model.Abundance.(layer).K(j, :) = abund_K;
        end
    end
end
clear logical_oc logical_cc layers layer i;
end