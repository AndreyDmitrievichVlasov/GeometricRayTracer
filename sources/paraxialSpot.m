function [ rays ] = paraxialSpot( r0, R)
%LED Summary of this function goes here
%   Detailed explanation goes here
% R=1;
N=8;
 asStructOrArray =2;
RGB=[630 510 450]*10^-6;
RGB_colors=[[1 0 0];
            [0 1 0];
            [0 0 1]];
x=-R:2*R/(N-1):R;
y=-R:2*R/(N-1):R;
lightDir=[0 0 1];
rays=[];
if asStructOrArray==1
       for k=1:3 
       for i=1:N
            for j=1:N
                   % интенсивность будем считать исходя из гауссовой диаграммы
                   % направленности, где вся энергия сосредоточена между -80 град и
                   % 80 град.
                   rho=x(i)^2+y(j)^2;
                   if  rho<=R^2
                       intensity=exp( -(rho)/(pi/16)^2);
                       rays=[rays struct('r0',r0+[x(i) y(j) 0],'e',[0 0 1],'tStart',0,'tEnd',1.0,'lam',RGB(k),'wieght', intensity,'color',RGB_colors(k,:)*intensity,'internal',0)];
                   end    
            end
        end
       end
else
    for k=1:3
        for i=1:N
            for j=1:N
                h=((x(i)^2+y(j)^2));
                if h<R^2
%                    r0=[x(i)*0.5 y(j)*0.5 0.5*sqrt(R-h)];
                   % интенсивность будем считать исходя из гауссовой диаграммы
                   % направленности, где вся энергия сосредоточена между -80 град и
                   % 80 град.
                   rho=x(i)^2+y(j)^2;
                   if  rho<=R^2
                       intensity=exp( -(rho)/(pi/16)^2);
                       rays=[rays; [r0+[x(i) y(j) 0],[0 0 1],0,1.0,RGB(k), intensity,RGB_colors(k,:)*intensity]];
                   end
                end
            end
        end
    end
end



end

