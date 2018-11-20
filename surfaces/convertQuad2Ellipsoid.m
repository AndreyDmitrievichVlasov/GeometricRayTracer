function [ quad_ ] = convertQuad2Ellipsoid( quad_,A,B,C)
%CONVERTQUAD2ELLIPSOID Summary of this function goes here
%   Detailed explanation goes here
quad_.extraDataType='ellipsoid';
quality=64;
if quad_.L>2*A
quad_.L=2*A;
end
if quad_.H>2*B
    quad_.H=2*B;
end


x_s = A*cos(linspace(0,2*pi,quality));
y_s = B*sin(linspace(0,2*pi,quality));
arc_xy=[x_s;y_s;x_s-x_s];
x_s=linspace(-A,A,quality);y_s=x_s/A*B;
arc_x=real([x_s;x_s-x_s;C-sign(C)*sqrt(C^2-(C/A)^2*x_s.^2)]);
arc_y=real([x_s-x_s;y_s;C-sign(C)*sqrt(C^2-(C/B)^2*y_s.^2)]);
if C>0
    arc_xy(3,:)=arc_xy(3,:)+max(arc_x(3,:));
else
    arc_xy(3,:)=arc_xy(3,:)+min(arc_x(3,:));
end
quad_.extraData=struct('arc_x',arc_x,'arc_y',arc_y,'arc_xy',arc_xy,...
                        'A',A,'B',B,'C',C,'focusesX',sqrt(A^2-C^2),'focusCoord',[sqrt(A^2-C^2) 0 0],'aperture',[A B],'refractionIndex',1,'drawQuality',quality,...
                        'surfaceMatrix',[[1/A^2 0     0      0];...
                                              [0     1/B^2 0      0];...
                                              [0     0     1/C^2  0];...
                                              [0     0     0     -1]]);
end

