function GeoPhys = Get_GeoPhys(lithosphere)

name = lithosphere.Model_Name;

if strcmp(name,'Litho1')
    GeoPhys = lithosphere.Model_Data.Litho1;
elseif strcmp(name, 'Crust1')
    GeoPhys = lithosphere.Model_Data.Crust1;
elseif strcmp(name, 'Crust2')
    GeoPhys = lithosphere.Model_Data.Crust2;
elseif strcmp(name, 'ECM1')
    GeoPhys = lithosphere.Model_Data.ECM1;
end