function [ PSF] = getPSFData( Rays,Quad,m,n )
%GETPSFDATA Summary of this function goes here
%   Detailed explanation goes here
PSF=struct('PSFLayers',[], 'SpotDiagrammLayers',[],'WaveLengths', [],'RMS',[],'AvgR',[],'Centroid',[]);
[raysMap, waveLngthKeys]= getRaysSeparatedByWaveLength(Rays);
 
end

