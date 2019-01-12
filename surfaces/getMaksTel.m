function [ mir ] = getMirror(aperture,r,orient,pos)
% getZer - orient - orientation, pos - position
surf = flatQuad( 2*aperture,2*aperture,orient,pos);

if length(r)==1
    surf = convertQuad2Sphere(surf,r);
end
if length(r)==2
    surf = convertQuad2Paraboloid(surf,r(1),r(2));
end
if length(r)==3
    surf = convertQuad2Ellipsoid( surf,r(1),r(2),r(3));
end

mir=struct('Surface',surf,'aperture',aperture,'type','mirror');

end


% returns Maksutov telescope
function [ telmaks ] = getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,distsec,secaprad,rsec)
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

lam=550/1000; % wavelength in micrometers

n=dispersionLaw(lam, rI.refractionIndexData); % let's hope it works...

fm = 1/((n-1)*(1/r1m-1/r2m));
% focal length of the menisc
distmfm=dist-fm;
mmaprad = -distmfm*maprad/fm; % this doesn't take into account vignetting
rim=rmm*distmfm/(2*distmfm-rmm);
% distance from mm image to mm
rimd=rim-distsec;
b=rsec*rimd/(rsec-2*rimd)-distsec;
% vynos teleskopa

menisc=getLens(maprad,mthick,r1m,r2m);
menisc=moveLens(menisc,[0 0 dist]);

mm=getMirror(mmaprad,rmm,[0 0 0],[0 0 0]);
% getMirror(aperture,r,orient,pos)

% sm is a secondary mirror
if distsec>0 
 sm=getMirror(secaprad,rsec,[0 0 0],[0 0 -distsec]);
else
 sm=getMirror(secaprad,r2m,[0 0 0],[0 0 -dist]);
% in this case, secondary mirror is right on top of the second surface of the menisc
end

%bigMirror= flatQuad( 90,90,[0 0 0],[0 0 150]);
%smalMirror = flatQuad( 30,30,[0 0 0],[0 0 7]);
%bigMirror=convertQuad2Sphere(bigMirror,-700);
% smalMirror = convertQuad2Sphere(smalMirror,-400);
%detector = flatQuad( 0.25,0.25,[0 0 0],[0 0 b]);
% detector is not a part of the telescope. In the telescope structure, we
% have b - where detector should be placed

% telmaks=struct(maprad,rmm,r1m,r2m,mthick,dist,distsec,secaprad,rsec,n);
telmaks=struct('menisc',menisc,'mmirror',mm,'smirror',sm,'vynos',b, ...
    'type','MaksTel');

end
