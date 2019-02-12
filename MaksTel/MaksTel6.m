clear all; close all;clc;
matlab=false;
initEnvio(matlab);
%all distances are expressed in mm

% getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec)
[schema,b]=getMaksTel(45,-435,-150,-300,20,200,-200,10,-200);
fprintf('Vynos teleskopa %.3f mm\n',b);

%detPos=b-27;
detPos=15.5;
detSize=5;
detector = flatQuad(detSize,detSize,[0 0 0],[0 0 detPos]);
raysIn=paraxialSpotHom([0 0 -400],[10 45],20);

[ raysIn,raysMiddle,raysOut ] = traceThroughSystem(raysIn, schema);

raysOutInt = quadIntersect(detector,raysOut);
% allRays=[raysIn; rays_middle; raysOut; raysReflected1; raysReflected2];

if false
 fig_1=figure(1);
 axis vis3d;
 view([0 0]);
 DrawElements(schema,fig_1);
 drawQuad(fig_1,detector);
 grid on;
end

curt=clock();

Npix=300
defstring=sprintf('%.1f_%.1f_%.1f_%d_%d_%d',detPos,b,detSize,Npix,curt(4),curt(5));
% This is a string which is appended to all filenames
% detPos - detector position, b - vynos,detSize - detectorSize, Npix - number of pixels, minutes

if(true)
 filename2=sprintf('images/MTf2_%s.eps',defstring);
 if matlab 
  fig_2=figure(2);
 else   
  fig_2=figure(2,'visible','off');
 end
 [~,~,~,~]=drawSpotDiagram(fig_2,detector,raysOutInt);
 if matlab
  saveas(fig_2,filename2,'epsc');
 else    
  print(fig_2,'-deps','-color',filename2);
 end
end 

filename3=sprintf('images/MTf3_%s.eps',defstring);

if matlab 
 fig_3 = figure(3);
else    
 fig_3 = figure(3,'visible','off');
end 
[ intensity,x ,y ] = quadIntencity(detector,raysOutInt,Npix,Npix);
imagesc(x,y,intensity);
colorbar;
axis equal;
if matlab
 saveas(fig_3,filename3,'epsc');   
else    
 print(fig_3,'-deps','-color',filename3);
end
