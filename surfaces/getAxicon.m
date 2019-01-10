%% ���������� ��������� ����������� �����

%% aperture - �������� �������� ������� ��������

%% tickness - ������� ����� 

%% r_1 � r_2 ���������� ������ � ������ ����������� �����. 

%% ��� �� ���������� ����������� �����������, ��������� �������� ������ ������, �.�.:
%% length(r_1) ��� length(r_2) = 1

%% ��� �� ���������� �������������� �����������, ��������� �������� ��� ���������, ������������ ��������, �.�.:
%% length(r_1) ��� length(r_2) = 2

%% ��� �� ���������� ����������� �����������, ��������� �������� ��� ����� ��������, �.�.:
%% length(r_1) ��� length(r_2) = 3

%% ����������� ����� �������������. 


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

