function [fwhmIm]=fwhm_allargs(x,raysOut,size,N)
detector=flatQuad(size,size,[0 0 0],[0 0 x]);
raysOutInt = quadIntersect(detector,raysOut);
[intensity,x,y]=quadIntencity(detector,raysOutInt,N,N);
l=length(intensity);
[maxval,maxis]=max(intensity); 
% maxval is an array of maximum values,
% maxis - their indices
% max searches maximum on the first index. That is, maxis are the first
% indices of intensity. 
% maxmaxi is the second index of intensity
[maxmaxval,maxmaxi]=max(maxval);
fwhmx=fwhm(intensity(maxis(maxmaxi),:));
fwhmy=fwhm(intensity(:,maxmaxi));
fwhmIm=0.5*(fwhmx+fwhmy)*initSize/l;  
end