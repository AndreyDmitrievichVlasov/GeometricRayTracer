% it returns 0.5*(fwhmx+fwhmy) in mm
function [fwhmIm]=fwhm_schema(x)
global raysOutMin;
initSize=5;
N=300;
bigN=1000;
minNormFwhm=2;
factor=3;
detector=flatQuad(initSize,initSize,[0 0 0],[0 0 x]);
raysOut = quadIntersect(detector,raysOutMin);
[intensity,x,y]=quadIntencity(detector,raysOut,N,N);
l=length(intensity);
fwhmx=fwhm(intensity(l/2,:));
fwhmy=fwhm(intensity(:,l/2));
if(fwhmx<minNormFwhm || fwhmy<minNormFwhm)
 detector=flatQuad(initSize/factor,initSize/factor,[0 0 0],[0 0 x]);
 raysOut = quadIntersect(detector,raysOutMin);
 [intensity,x,y]=quadIntencity(detector,raysOut,N,N);
 l=length(intensity);
 fwhmx=fwhm(intensity(l/2,:));
 fwhmy=fwhm(intensity(:,l/2));
end
fwhmIm=0.5*(fwhmx+fwhmy)*initSize/l;
end