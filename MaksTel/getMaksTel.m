% returns Maksutov telescope
function [ schema_makstel, b ] = getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec)
% origin is at the center of main mirror
%getMaksTel - returns Maksutov telescope
%  maprad - menisc aperture radius, rmm - radius of main mirror
% r1m, r2m - radii of menisc (r1m - external), 
% dist - distance between main mirror and menisc
% distsec - distance between primary mirror and secondary mirror. 
%   If zero or negative, secondary mirror is assumed to be coated inner side of menisc
% secaprad - secondary aperture radius
% rsec - radius of curvature of secondary mirror. if distsec<=0, this value is ignored and r2m is used for this purpose
% n - index of refraction of menisc glass 

%if n<=1 || n>5
% print "Suspicious n=",n,"was supplied. n should be >1 and <=5";
% exit;
%end

if argdistsec>0
 napyl=false;
 distsec=argdistsec;
 rsec=argrsec;
else
 napyl=true;
% that would mean that secondary mirror is at the top of menisc
 distsec=dist;
 rsec=r2m;
end

lam=550/1000; % wavelength in micrometers

rI=Materials('silica');
rI2=rI;
n=dispersionLaw(lam, rI2.refractionIndexData); % let's hope it works...

fm = 1/((n-1.)*(1./r1m-1./r2m));
% focal length of the menisc
distmfm=dist-fm;
mmaprad = -distmfm*maprad/fm; % this doesn't take into account vignetting
rim=abs(rmm)*distmfm/(2*distmfm-abs(rmm));
% distance from mm image to mm
if rim<0
 fprintf('Error: 2*distmfm=%.3f<abd(rmm)=%.3f \n',2*distmfm,abs(rmm));
end
rimd=rim-distsec;
b=abs(rsec)*rimd/(abs(rsec)-2*rimd)-distsec;
% vynos teleskopa
if abs(rsec)<2*rimd
 fprintf('Error: abs(rsec)=%.2f<2*rimd=%.2f \n',abs(rsec),2*rimd)
end

menisc=getLens(maprad,mthick,r1m,r2m);
menisc=moveLens(menisc,[0 0 -dist-mthick]);

mm=getMirror(mmaprad,rmm,[0 0 0],[0 0 0]);
% getMirror(aperture,r,orient,pos)

% sm is a secondary mirror
sm=getMirror(secaprad,rsec,[0 0 0],[0 0 -distsec]);

schema_makstel{1}=menisc;
schema_makstel{2}=mm;
schema_makstel{3}=sm;

% telmaks=struct(maprad,rmm,r1m,r2m,mthick,dist,distsec,secaprad,rsec,n);
%telmaks=struct('menisc',menisc,'mmirror',mm,'smirror',sm,'b',b, ...
%    'napyl',napyl,'type','MaksTel');

end
