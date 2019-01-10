clear all; close all;clc;initEnvio();
%%����� ������� � ����������� �������,���������� ��������� ������ ����� ����� ����� ���� ������� � ������ ctrl+D 
[ detector] =  flatQuad( 0.25,0.25,[0 0 0],[0.25 0 17]);

[conus] =  convertQuad2Conus(flatQuad( 4,4,[0 0 0],[0 0 2]), 2,2,-1);

LED_source=paraxialSpot([0 0 -5],1);

[  LED_source ] = quadIntersect( conus, LED_source);

fig_handler=figure(1);
%TODO
% ������������ � ���������� ������������
% ������� � ���� �����������
% ��������� �� � ����� ������� ���������
 drawQuad(fig_handler,conus);
 drawRays(fig_handler,LED_source);
 axis equal;
 grid on;