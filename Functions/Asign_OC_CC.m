function lithosphere = Asign_OC_CC(lithosphere)


model = lithosphere.Model_Name;

if strcmp(model,'Crust1') 
    % 提前声明一些变量
    GeoPhys = lithosphere.Model_Data.Crust1;
    len = length(GeoPhys.type);
    lithosphere.Logical.OC = false(len, 1); % 提前声明，定义长度

    % Assign a value of 1 if the cell has a crust type that we designate as CC, OC, stable, or Archean crust.  Designation as part of one of these 4 broad 
    % categories is performed by us based on the names given by LITHO1.0 (actually CRUST1.0). All other values are 0. 

    % Oceanic Crust: 
    % 26 = A1 normal oceanic
    % 27 = A0 oceans 3 Myrs and younger
    % 28 = B- melt affected o.c. and oceanic plateaus
    % 31 = V1 Inactive Ridge, Alpha ridge
    % 36 = Y3 Caspian Sea Oceanic

    OC_types = [26,27,28,31,36];  %Crust1.0 data types
    len_types = length(OC_types);
    % lithosphere.Logical.OC = any(bsxfun(@eq,OC_types,GeoPhys.type(:,3)),2); clear OC_types
    
    for i = 1:len
        type_value = GeoPhys.type(i, 3);
        for j = 1:len_types
            if type_value == OC_types(j)
                lithosphere.Logical.OC(i) = true;
                break;
            end
        end
    end

    lithosphere.Logical.CC = ~lithosphere.Logical.OC; 

elseif strcmp(model,'ECM1')|| strcmp(model,'Litho1')
    disp('Oceanic and continental crust locations already defined in input file')

elseif strcmp(model,'Crust2')
   % ----------  Logically index CC, Logical, stable, and Archean crust  --------
    %{ 

    Oceanic Crust = A and B types
    A = normal oceanic 
    B = melt affected o.c. and oceanic plateaus
    %}

    oceanic = {'A0';'A1';'A2';'A3';'A4';'A5';'A6';'A7';'A8';'A9';'AA';'AB';...
        'AC';'BO';'B1';'B2';'B3';'B4';'B5';'B6';'B7';'B8';'B9';'BA';'BB';'BC';'BD'}; 
    idx = zeros(length(GeoPhys.latlon),1);
    for i = 1:length(oceanic)
        x= strcmp(GeoPhys.type,oceanic{i}); 
        idx = idx+x; 
    end
    lithosphere.Logical.OC = any(idx,2); %convert to logical
    lithosphere.Logical.CC = ~lithosphere.Logical.OC; 
end

clear GeoPhys len model

