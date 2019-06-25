function [PSF] = getPSFData( Rays,Quad,m,n )
%GETPSFDATA Summary of this function goes here
%   Detailed explanation goes here
PSF=struct();%('PSFLayers',{}, 'SpotDiagrammLayers',{},'WaveLengths',{},'RMS',{},'AvgR',{},'Centroid',{});
[raysMap, waveLngthKeys]= getRaysSeparatedByWaveLength(Rays);
 
idx=1;
for i=1:length(waveLngthKeys)
[ intensity, xyCol ] = quadIntencity( Quad, raysMap(waveLngthKeys{i}),m,n);
  
  if ~isempty(xyCol)
        PSF.WaveLengths{idx}=waveLngthKeys{i}; 
        PSF.PSFLayers{idx}=intensity;
        PSF.XSpot{idx}=xyCol(:,1);
        PSF.YSpot{idx}=xyCol(:,2);
        PSF.SpotColor{idx}=xyCol(:,3:5);
        Rho=sqrt(sum((xyCol(:,1:2).*xyCol(:,1:2)),2));
        PSF.AvgR{idx}=sum(Rho)/size(xyCol,1);
        PSF.RMS{idx}=sqrt(sum((PSF.AvgR{idx}-Rho).^2/size(xyCol,1)));
        PSF.Centroid{idx}=[sum(xyCol(:,1)), sum(xyCol(:,2))]/size(xyCol,1);
        idx=1+idx;
    end
end

end

