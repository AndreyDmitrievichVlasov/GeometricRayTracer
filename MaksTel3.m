clear all; close all;clc;
windows=true;
initEnvio(windows);
%all distances are expressed in mm
% graphics_toolkit gnuplot;

% getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec)
[schema,b]=getMaksTel(45,-435,-150,-300,20,200,-200,10,-200);
fprintf('Vynos teleskopa %.3f mm\n',b);

%detPos=b-27;
detPos=0
detector = flatQuad(5,5,[0 0 0],[0 0 detPos]);
raysIn=paraxialSpot([0 0 -400],[10 45]);

[ raysIn,raysMiddle,raysOut ] = traceThroughSystem(raysIn, schema);

raysOut = quadIntersect(detector,raysOut);
% allRays=[raysIn; rays_middle; raysOut; raysReflected1; raysReflected2];

if false
 fig_1=figure(1);
 axis vis3d;
 view([0 0]);

% ���������� ����� 121^2 �������� ������ �� ���� ����� � ����
% drawRays(fig_1,raysIn);
% drawRays(fig_1,rays_middle);
% drawRays(fig_1,raysOut);
% drawRays(fig_1,raysReflected1);
% drawRays(fig_1,raysReflected2);

%drawLens(fig_1,Lens_in);
%drawQuad(fig_1,bigMirror);
%drawQuad(fig_1,smalMirror);

 DrawElements(schema,fig_1);
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
 [ intensity,x ,y ] = quadIntencity(detector,raysOut,300,300);
 imagesc(x,y,intensity);
 colorbar;
 axis equal;
 if ~windows
  print(fig_3,'-deps','-color',filename3);
 end 