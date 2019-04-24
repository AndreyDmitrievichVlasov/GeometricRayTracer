function [PSF] = getPSFData( Rays,Quad,m,n )
%GETPSFDATA Summary of this function goes here
%   Detailed explanation goes here
PSF=struct();%('PSFLayers',{}, 'SpotDiagrammLayers',{},'WaveLengths',{},'RMS',{},'AvgR',{},'Centroid',{});
[raysMap, waveLngthKeys]= getRaysSeparatedByWaveLength(Rays);
 

for i=1:length(waveLngthKeys)
[ intensity, xyCol ] = quadIntencity( Quad, raysMap(waveLngthKeys{i}),m,n);
    PSF.WaveLengths{i}=waveLngthKeys{i}; 
    PSF.PSFLayers{i}=intensity;
%     PSF.SpotDiagrammLayers{i}=xyCol;
    PSF.XSpot{i}=xyCol(:,1);
    PSF.YSpot{i}=xyCol(:,2);
    PSF.SpotColor{i}=xyCol(:,3:5);
    Rho=sqrt(sum((xyCol(:,1:2).*xyCol(:,1:2)),2));
    PSF.AvgR{i}=sum(Rho)/size(xyCol,1);
    PSF.RMS{i}=sqrt(sum((PSF.AvgR{i}-Rho).^2/size(xyCol,1)));
    PSF.Centroid{i}=[sum(xyCol(:,1)), sum(xyCol(:,2))]/size(xyCol,1);
end

end

