clear all; close all;clc;
windows=1;
initEnvio(windows);
%all distances are expressed in mm

% graphics_toolkit gnuplot;

%telescope=getMaksTel(90,-700,-400,-250,20,200,-200,10,-200);
ttelescope=getMaksTel(90,-435,-150,-300,20,200,-200,10,-200);
telescope=ttelescope; % this is to ensure Matlab compatibility
% function [ telmaks ] = getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,distsec,secaprad,rsec)
fprintf('Vynos teleskopa %.3f mm\n',telescope.b);

detector = flatQuad(0.25,0.25,[0 0 0],[0 0 telescope.b]);
raysIn=paraxialSpot([0 0 -10],[0 45]);

[ raysIn, raysOut ] = traceThroughMaksTel( telescope, raysIn);

raysOut = quadIntersect(detector,raysOut);
% allRays=[raysIn; rays_middle; raysOut; raysReflected1; raysReflected2];

if windows

 fig_1=figure(1);
 axis vis3d 
 view([0 0])

% ���������� ����� 121^2 �������� ������ �� ���� ����� � ����
% drawRays(fig_1,raysIn);
% drawRays(fig_1,rays_middle);
% drawRays(fig_1,raysOut);
% drawRays(fig_1,raysReflected1);
% drawRays(fig_1,raysReflected2);

%drawLens(fig_1,Lens_in);
%drawQuad(fig_1,bigMirror);
%drawQuad(fig_1,smalMirror);

 drawMaksTel(fig_1,telescope);
 drawQuad(fig_1,detector);
 grid on;
end

curt=clock();

if(true)
 if windows 
  fig_2=figure(2);
   [~,~,~,~]=drawSpotDiagram(fig_2,detector,raysOut);
 else   
  fig_2=figure(2,'visible','off');
  filename2=sprintf('images/MTf2_%d_%d_%d_%d.eps',curt(2),curt(3),curt(4),curt(5));
  print(fig_2,'-deps','-color',filename2);
 end
end 
 
 if windows 
  fig_3 = figure(3);
 else    
  fig_3 = figure(3,'visible','off');
  filename3=sprintf('images/MTf3_%d_%d_%d_%d.eps',curt(2),curt(3),curt(4),curt(5));
 end 
 [ intensity,x ,y ] = quadIntencity(detector,raysOut,100,100);
 imagesc(x,y,intensity);
 colorbar;
 axis equal;
 if ~windows
  print(fig_3,'-deps','-color',filename3);
 end