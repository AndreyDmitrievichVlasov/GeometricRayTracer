clear all; close all;clc;initEnvio();
%all distances are expressed in mm

% graphics_toolkit gnuplot;

telescope=getMaksTel(90,-700,-400,-250,20,200,-200,10,-200);
% function [ telmaks ] = getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,distsec,secaprad,rsec,n)

detector = flatQuad( 0.25,0.25,[0 0 0],[0 0 telescope.b]);
raysIn=paraxialSpot([0 0 -10],[0 45]);

[ raysIn, raysOut ] = traceThroughMaksTel( telescope, raysIn);

raysOut = quadIntersect(detector,raysOut);
% allRays=[raysIn; rays_middle; raysOut; raysReflected1; raysReflected2];

%fig_1=figure(1);

%axis vis3d 
%view([0 0])

% ���������� ����� 121^2 �������� ������ �� ���� ����� � ����
% drawRays(fig_1,raysIn);
% drawRays(fig_1,rays_middle);
% drawRays(fig_1,raysOut);
% drawRays(fig_1,raysReflected1);
% drawRays(fig_1,raysReflected2);

%drawLens(fig_1,Lens_in);
%drawQuad(fig_1,bigMirror);
%drawQuad(fig_1,smalMirror);

%drawMaksTel(fig_1,telescope);
%drawQuad(fig_1,detector);
%grid on;

fig_2=figure(2,"visible","off");

[~,~,~,~]=drawSpotDiagram(fig_2,detector,raysOut);
print(fig_2,"-deps","-color",'images/MaksTelf2.eps');


fig_3 = figure(3,"visible","off");
[ intensity,x ,y ] = quadIntencity(detector,raysOut,100,100);
imagesc(x,y,intensity);
colorbar;
axis equal;
print(fig_3,"-deps","-color","images/MaksTelfig3.eps");
