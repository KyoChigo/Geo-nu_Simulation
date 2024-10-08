function Physics = Load_Detector(Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 加载Detector数据 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 加载或定义需要用到的变量 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% %%% 经度、纬度、深度、探测效率、质子数、探测器最近的一个cell的经纬度
set_detectors={137.31, 36.43, 1000, 0.7, 5.98*10^31,[134,34];... %KamLAND - Araki etal. (2005) 
                     13.57, 42.45, 1400, 0.842, 9.76E+30,[10,40];...   %Borexino - Wikipedia LNGS
                     -81.201, 46.475, 2092, 0.8, 5.76E+31,[-84,44];...  %SNO+ - Chen (2007), Andringa etal. (2016)
                     112.518, 22.118, 700, 0.8, 1.29E+33,[109,20];...   %JUNO - An etal. (2016) JUNO Yellowbook
                     101.71, 28.15, 2400, 0.8, 2.16E+32,[99,26];...    %Jinping - Beacom etal. (2016) letter of intent
                     -156.32, 19.72, 0, 0.8, 0,[-160,18];         %Hawaii
               };
detector_index = Physics.Detector.Index;
detector = set_detectors(detector_index, :);
%%% 加载 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Physics.Detector.Longitude = detector(1);
Physics.Detector.Latitude = detector(2);
Physics.Detector.Depth = detector(3);
Physics.Detector.Selection_Efficiency = detector(4);
Physics.Detector.Proton_Number = detector(5);
Physics.Detector.Clostest_Cell = detector(6);
%%% Output message %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('[Physics::Load_Detector] Detector is complete');
end