clear all; close all;clc;initEnvio();
%%����� ������� � ����������� �������,���������� ��������� ������ ����� ����� ����� ���� ������� � ������ ctrl+D 
[ detector] =  flatQuad( 0.25,0.25,[0 0 0],[0.25 0 17]);

Axicon=getAxicon( 2,2,2,2,1);

LED_source = paraxialSpot([0 0 -5],1);

% [  LED_source ] = quadIntersect( conus, LED_source);
[ LED_source, rays_middle, rays_out] = traceThroughtLens( Axicon, LED_source);

fig_handler=figure(1);
%TODO
% ������������ � ���������� ������������
% ������� � ���� �����������
% ��������� �� � ����� ������� ���������
 drawLens(fig_handler,Axicon);
 drawRays(fig_handler,[LED_source; rays_middle; rays_out]);
%  drawRays(fig_handler,LED_source);
 axis equal;
 grid on;