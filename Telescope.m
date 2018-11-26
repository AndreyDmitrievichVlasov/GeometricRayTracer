clear all; close all;clc;initEnvio();

opticalElements=[];
Lens_in = getLens( 45, 7,  -250,-400 );
% l = getLens( 30, 6.17,  162, 215 );
% [ l ] = moveLens( l,[0 0 2]);
bigMirror= flatQuad( 90,90,[0 0 0],[0 0 150]);
smalMirror = flatQuad( 30,30,[0 0 0],[0 0 7]);
bigMirror=convertQuad2Sphere(bigMirror,-700);
smalMirror = convertQuad2Sphere(smalMirror,-400);
detector = flatQuad( 10,10,[0 0 0],[0 0 230]);
raysIn=paraxialSpot([0 0 -10],[30 45]);

[ raysIn, rays_middle, raysOut ] = traceThroughtLens( Lens_in, raysIn);
[ raysReflected1, raysOut ] = reflectFormQuad( bigMirror, raysOut);
[ raysReflected2, raysReflected1  ] = reflectFormQuad( smalMirror, raysReflected1);


raysReflected2=quadIntersect(detector,raysReflected2);
% allRays=[raysIn; rays_middle; raysOut; raysReflected1; raysReflected2];



fig_1=figure();

axis vis3d 
view([0 0])
% drawRays(fig_1,rays_in);
% drawRays(fig_1,rays_middle);
% drawRays(fig_1,rays_out );
% drawRays(fig_1,LED_source);
% drawRays(fig_1,LED_source_1);
drawRays(fig_1,raysIn);
drawRays(fig_1,rays_middle);
drawRays(fig_1,raysOut);
drawRays(fig_1,raysReflected1);
drawRays(fig_1,raysReflected2);
% drawRays(fig_1,raysIn);

drawLens(fig_1,Lens_in);
drawQuad(fig_1,bigMirror);
drawQuad(fig_1,smalMirror);
drawQuad(fig_1,detector);
grid on;
% opticalElements(2)=struct('element',getLens([13.03 0 0],30,0,6.17,162,215,[1 0 0],'silica'));
% %% first mirror
% opticalElements(3)=struct('element',getMirror([115.9 0 0],40,300,-1,[1 0 0]));
% %% second mirror
% opticalElements(4)=struct('element',getMirror([19.2 0 0],15,215,-1,[1 0 0]));
% %% collimator
% opticalElements(5)=struct('element',getLens([98.77 0 0],8,0,9,75,120,[1 0 0],'silica'));
% opticalElements(6)=struct('element',getLens([112.56 0 0],8,0,7.5,-42.7, -39.5,[1 0 0],'silica'));
% % последовательность обхода схемы
% sequence=[1 2 3 4 5 6 ];