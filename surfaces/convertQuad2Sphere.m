function [ quad_ ] = convertQuad2Sphere(quad_,R)
%CONVERTQUAD2SPHERE Summary of this function goes here
%   Detailed explanation goes here
quad_.extraDataType='sphere';
quality=64;
if quad_.L>abs(2*R)
    quad_.L=abs(2*R);
end
if quad_.H>abs(2*R)
    quad_.H=abs(2*R);
end
R_ =0.25*(quad_.L+quad_.H);
x_s = R_*cos(linspace(0,2*pi,quality));
y_s = R_*sin(linspace(0,2*pi,quality));
arc_xy=[x_s;y_s;x_s-x_s];
x_s=linspace(-R_,R_,quality);y_s=x_s;
arc_x=[x_s;x_s-x_s;R-sign(R)*sqrt(R^2-x_s.^2)];
arc_y=[x_s-x_s;y_s;R-sign(R)*sqrt(R^2-y_s.^2)];
if R>0
    arc_xy(3,:)=arc_xy(3,:)+max(arc_x(3,:));
else
    arc_xy(3,:)=arc_xy(3,:)+min(arc_x(3,:));
end

quad_.extraData=struct('arc_x',arc_x,'arc_y',arc_y,'arc_xy',arc_xy,...
                                  'R',R,'A',R,'B',R,'C',R,'aperture',R_,'refractionIndex',1,'drawQuality',quality,...
                                   'surfaceMatrix',[[1/R^2 0     0      0];...
                                                         [0     1/R^2 0      0];...
                                                         [0     0     1/R^2  0];...
                                                         [0     0     0       -1];]);

end

