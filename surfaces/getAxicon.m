%% Возврашает структуру описывающую линзу

%% aperture - значение диаметра входной апертуры

%% tickness - толщина линзы 

%% r_1 и r_2 определяют первую и вторую поверхности линзы. 

%% что бы опредилить сферическую поверхность, небходимо передать только радиус, т.е.:
%% length(r_1) или length(r_2) = 1

%% что бы опредилить параболическую поверхность, небходимо передать два параметра, определяющих параболу, т.е.:
%% length(r_1) или length(r_2) = 2

%% что бы опредилить сферическую поверхность, небходимо передать три длины полуосей, т.е.:
%% length(r_1) или length(r_2) = 3

%% Поверхности можно комбинировать. 


function [ lens ] = getAxicon( aperture,tickness,A,B,C)
%GETLENS Summary of this function goes here
%   Detailed explanation goes here
front_surf = flatQuad( 2*aperture,2*aperture,[0 0 0],[0 0 0]);
front_surf=convertQuad2Sphere(front_surf, 10^10);
back_surf  = flatQuad( 2*aperture,2*aperture,[0 0 0],[0 0 tickness]);

back_surf=convertQuad2Conus(back_surf, A,B,C);

rI=Materials('silica');
lens=struct('frontSurface',front_surf,'backSurface',back_surf,'tickness',tickness,'aperture',aperture,'material',...
                rI,'materialDispersion',@(lam)(dispersionLaw(lam, rI.refractionIndexData)),'type','lens');


end
function n = dispersionLaw(lam, Ndata)

n    =    sqrt(1  +    Ndata(1)*lam.^2./(lam.^2-Ndata(2)^2)...
                      +    Ndata(3)*lam.^2./(lam.^2-Ndata(4)^2)+...
                            Ndata(5)*lam.^2./(lam.^2-Ndata(6)^2));

end

