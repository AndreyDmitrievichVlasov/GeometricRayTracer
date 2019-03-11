function [quad_ ] = convertQuad2Paraboloid(quad_,A,B)
%CONVERT2PARABOLOID Summary of this function goes here
%   Detailed explanation goes here
% sign A define x^2/A^2+y^2/B^2 or x^2/A^2-y^2/B^2
% sign A define curvature direction
% 
parabolod=@(x,y,A,B)(sign(A)*x.^2/A^2+sign(B)*y.^2/B^2);
quad_.extraDataType=paraboloidType();
quality=64;
% if quad_.L>abs(2*A)
quad_.L=abs(2*A);
% end
% if quad_.H>abs(2*B)
quad_.H=abs(2*B);
% end


x_s = 0.5*quad_.L*cos(linspace(0,2*pi,quality));
y_s = 0.5*quad_.H*sin(linspace(0,2*pi,quality));

arc_xy=[x_s;y_s;parabolod(x_s,y_s,A,B)];

x_s=linspace(-quad_.L/2,quad_.L/2,quality);y_s=x_s*abs(1/A*B);
arc_x=real([x_s;x_s-x_s;parabolod(x_s,y_s-y_s,A,B)]);
arc_y=real([x_s-x_s;y_s;parabolod(y_s-y_s,y_s,A,B)]);

quad_.extraData=struct('arc_x',arc_x,'arc_y',arc_y,'arc_xy',arc_xy,...
                        'A',A,'B',B,'C',0,'aperture',[A B],'refractionIndex',1,'drawQuality',quality,...
                        'surfaceMatrix',[[1/A^2 0             0   0  ];...
                                              [0     sign(B)*1/B^2 0   0  ];...
                                              [0     0             0   0.5];...
                                              [0     0             0.5 0   ]]);
end
