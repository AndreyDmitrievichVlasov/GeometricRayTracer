function [ rays ] = paraxialSpot( r0, R)
%LED Summary of this function goes here
%   Detailed explanation goes here
% R=1;
N=16;
RGB=[630 510 450]/1000;%wavelength in micrometers
RGB_colors=[[1 0 0];
                   [0 1 0];
                   [0 0 1]];
if length(R)==1
x=-R:2*R/(N-1):R;
y=-R:2*R/(N-1):R;
rays=[];

    for k=1:3
        for i=1:N
            for j=1:N
                h=((x(i)^2+y(j)^2));
%                      r0=[x(i)*0.5 y(j)*0.5 0.5*sqrt(R-h)];
                   % интенсивность будем считать исходя из гауссовой диаграммы
                   % направленности, где вся энергия сосредоточена между -80 град и
                   % 80 град.
                   rho=x(i)^2+y(j)^2;
                   if  rho<=R^2
                       intensity=1;%exp( -(rho)/(pi/16)^2);
                       rays=[rays; [r0+[x(i) y(j) 0],[0 0 1],0,1.0,RGB(k), intensity,RGB_colors(k,:)*intensity]];
                   end
           end
        end
    end
else
    x=-R(2):2*R(2)/(N-1):R(2);%linspace(R(1),R(2),N);
    y=x;
    phi=linspace(0,2*pi*(N-1)/N,N);
    rays=[];
    for k=1:3
        for i=1:N
            for j=1:N
                   % интенсивность будем считать исходя из гауссовой диаграммы
                   % направленности, где вся энергия сосредоточена между -80 град и
                   % 80 град.
                   rho=sqrt(x(i)^2+y(j)^2);
                   if rho>=R(1)&&rho<=R(2)
                       rays=[rays; [r0+[x(i) y(j) 0],...
                                   [0 0 1],0,1.0,RGB(k), 1,RGB_colors(k,:)]];
                  end
            end
        end
    end
end


end

