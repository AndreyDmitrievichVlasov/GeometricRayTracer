function [fwhmIm]=fwhm_allargs(x,raysOut,size,N)
detector=flatQuad(size,size,[0 0 0],[0 0 x]);
raysOutInt = quadIntersect(detector,raysOut);
[intensity,x,y]=quadIntencity(detector,raysOutInt,N,N);
l=length(intensity);
fwhmx=fwhm(intensity(l/2,:));
fwhmy=fwhm(intensity(:,l/2));
fwhmIm=0.5*(fwhmx+fwhmy)*initSize/l;  
end