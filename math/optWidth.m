function width = optWidth(rays_arg,z,size)
%detector=flatQuad(size,size,[0 0 0],[0 0 z]);
detector=flatQuad([size,size,0],1,[0 0 0],[0 0 z]);
rays=quadIntersect(detector,rays_arg);
% flatQuad(detSize,detSize,[0 0 0],[0 0 detPos]);
[ x,y,colors,angleSize]=spotDiagram(detector,rays);
lx=length(x);
ly=length(y);
xc=sum(x)/lx;
yc=sum(y)/ly;
d2=[];
for i=1:lx
 d2=[d2;(x(i)-xc)^2+(y(i)-yc)^2];  
end
width=sqrt(median(d2));
end % function
