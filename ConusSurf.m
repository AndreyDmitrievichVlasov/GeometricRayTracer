clear all; close all;clc;initEnvio();
%%чтобы перейти к определению функции,необходимо поставить курсор сразу после имени этой функции и нажать ctrl+D 
[ detector] =  flatQuad( 0.25,0.25,[0 0 0],[0.25 0 17]);

[conus] =  convertQuad2Conus(flatQuad( 4,4,[0 0 0],[0 0 2]), 2,2,-3);

LED_source=paraxialSpot([0 0 -5],1);

fig_handler=figure(1);
%TODO
% персесечение с конической поверхностью
% нормаль к этой поверхности
% упаковать всё в общую функцию трейсинга
 drawQuad(fig_handler,conus);
 axis equal;
 grid on;