function [ lens ] = getLens( aperture,tickness,r_1,r_2 )
%GETLENS Summary of this function goes here
%   Detailed explanation goes here
front_surf = flatQuad( 2*aperture,2*aperture,[0 0 0],[0 0 0]);

if length(r_1)==1
    front_surf = convertQuad2Sphere(front_surf,r_1);
end
if length(r_1)==2
    front_surf = convertQuad2Paraboloid(front_surf,r_2(1),r_2(2));
end
if length(r_1)==3
    front_surf = convertQuad2Ellipsoid( front_surf,r_1(1),r_1(2),r_1(3));
end


back_surf  = flatQuad( 2*aperture,2*aperture,[0 0 0],[0 0 tickness]);

if length(r_2)==1
   back_surf  = convertQuad2Sphere(back_surf,r_2);
end
if length(r_2)==2
   back_surf  = convertQuad2Paraboloid(back_surf,r_2(1),r_2(2));
end
if length(r_2)==3
   back_surf = convertQuad2Ellipsoid( back_surf,r_2(1),r_2(2),r_2(3));
end


lens=struct('frontSurface',front_surf,'backSurface',back_surf,'tickness',tickness,'aperture',aperture,'material',...
                'silica','materialDispersion',@(lam)(1.44),'type','lens');


end

