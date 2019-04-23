function [PSF] = getPSFData( Rays,Quad,m,n )
%GETPSFDATA Summary of this function goes here
%   Detailed explanation goes here
PSF=struct();%('PSFLayers',{}, 'SpotDiagrammLayers',{},'WaveLengths',{},'RMS',{},'AvgR',{},'Centroid',{});
[raysMap, waveLngthKeys]= getRaysSeparatedByWaveLength(Rays);
 

for i=1:length(waveLngthKeys)
[ intensity, xyCol ] = quadIntencity( Quad, raysMap(waveLngthKeys{i}),m,n);
    PSF.WaveLengths{i}=waveLngthKeys{i}; 
    PSF.PSFLayers{i}=intensity;
    PSF.SpotDiagrammLayers{i}=xyCol;
    Rho=sqrt(sum((PSF.SpotDiagrammLayers{i}(:,1:2).*PSF.SpotDiagrammLayers{i}(:,1:2)),2));
    PSF.AvgR{i}=sum(Rho)/size(PSF.SpotDiagrammLayers{i},1);
    PSF.RMS{i}=sqrt(sum((PSF.AvgR{i}-Rho).^2/size(PSF.SpotDiagrammLayers{i},1)));
    PSF.Centroid{i}=[sum(xyCol(:,1)), sum(xyCol(:,2))]/size(xyCol,1);
end

end

