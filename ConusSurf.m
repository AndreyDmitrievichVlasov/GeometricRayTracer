clear all; close all;clc;initEnvio();
%%чтобы перейти к определению функции,необходимо поставить курсор сразу после имени этой функции и нажать ctrl+D 
[ detector] =  flatQuad( 0.25,0.25,[0 0 0],[0.25 0 17]);

Axicon=getAxicon( 2,2,2,2,1);

LED_source = paraxialSpot([0 0 -5],1);

% [  LED_source ] = quadIntersect( conus, LED_source);
[ LED_source, rays_middle, rays_out] = traceThroughtLens( Axicon, LED_source);

fig_handler=figure(1);
%TODO
% персесечение с конической поверхностью
% нормаль к этой поверхности
% упаковать всё в общую функцию трейсинга
 drawLens(fig_handler,Axicon);
 drawRays(fig_handler,[LED_source; rays_middle; rays_out]);
%  drawRays(fig_handler,LED_source);
 axis equal;
 grid on;