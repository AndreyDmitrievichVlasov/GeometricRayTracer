function golGetFigs(raysOut,detPos,detSize,Npix,matlab,str)
%str is a string which is appended to the output
detector = flatQuad(detSize,detSize,[0 0 0],[0 0 detPos]);
raysOutInt = quadIntersect(detector,raysOut);
% allRays=[raysIn; rays_middle; raysOut; raysReflected1; raysReflected2];
%
if false
 fig_1=figure(1);
 axis vis3d;
 view([0 0]);
 DrawElements(schema,fig_1);
 drawQuad(fig_1,detector);
 grid on;
end

curt=clock();

defstring=sprintf('%s_%.1f_%.1f_%d_%d_%d',str,detPos,detSize,Npix,curt(4),curt(5));
% This is a string which is appended to all filenames
% detPos - detector position, b - vynos,detSize - detectorSize, Npix - number of pixels, minutes

if(true)
 filename2=sprintf('images/%s_SDI.eps',defstring);
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

filename3=sprintf('images/%s_INT.eps',defstring);

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
% raysOut,detPos,detSize,Npix,matlab,str
printf('detPos=%.1f, str=%s, width=%.f\n',detPos,str,optWidth(raysOutInt,detPos,detSize))

end
