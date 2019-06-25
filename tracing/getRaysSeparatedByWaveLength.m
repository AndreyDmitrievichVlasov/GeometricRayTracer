function [raysMap, waveLngthKeys] = getRaysSeparatedByWaveLength( rays )
%GETRAYSSEPARATEDBYWAVELENGTH Summary of this function goes here
%   Detailed explanation goes here
raysMap= containers.Map('KeyType','double','ValueType','any');
 
    for i=1:size(rays,1)
        if ~isKey(raysMap,rays(i,9));
            raysMap(rays(i,9))=rays(i,:);
            continue;
        end
        raysMap(rays(i,9))=[raysMap(rays(i,9));rays(i,:)];
   end
    waveLngthKeys=keys(raysMap);

end

