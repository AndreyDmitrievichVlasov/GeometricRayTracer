clear all; close all;clc;initEnvio();
%всё в миллиметрах
opticalElements=[];
Lens_in = getLens( 45, 7,  -250,-400 );
% l = getLens( 30, 6.17,  162, 215 );
% [ l ] = moveLens( l,[0 0 2]);
bigMirror= flatQuad( 90,90,[0 0 0],[0 0 150]);
smalMirror = flatQuad( 30,30,[0 0 0],[0 0 7]);
bigMirror=convertQuad2Sphere(bigMirror,-700);
smalMirror = convertQuad2Sphere(smalMirror,-400);
detector = flatQuad( 0.25,0.25,[0 0 0],[0 0 234.5]);
raysIn=paraxialSpot([0 0 -10],[30 45]);

[ raysIn, rays_middle, raysOut ] = traceThroughtLens( Lens_in, raysIn);
[ raysReflected1, raysOut ] = reflectFormQuad( bigMirror, raysOut);
[ raysReflected2, raysReflected1  ] = reflectFormQuad( smalMirror, raysReflected1);


raysReflected2=quadIntersect(detector,raysReflected2);
% allRays=[raysIn; rays_middle; raysOut; raysReflected1; raysReflected2];



fig_1=figure(1);

axis vis3d 
view([0 0])
% количество лучей 121^2 рисовать только на свой страх и риск
drawRays(fig_1,raysIn);
% drawRays(fig_1,rays_middle);
% drawRays(fig_1,raysOut);
% drawRays(fig_1,raysReflected1);
% drawRays(fig_1,raysReflected2);

drawLens(fig_1,Lens_in);
drawQuad(fig_1,bigMirror);
drawQuad(fig_1,smalMirror);
drawQuad(fig_1,detector);
grid on;

fig_2=figure(2);

[~,~,~,~]=drawSpotDiagram(fig_2,detector,raysReflected2);

fig_3 = figure(3);
[ intensity,x ,y ] = quadIntencity(detector,raysReflected2,200,200);
imagesc(x,y,intensity);
colorbar;
axis equal;