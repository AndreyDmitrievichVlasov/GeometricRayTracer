function [ rays ] = paraxialSpot( r0, R)
%LED Summary of this function goes here
%   Detailed explanation goes here
% R=1;
N=10;
M=1024;
RGB=[630 510 450]/1000;%wavelength in micrometers

RGB_colors=[[0 1 1];
            [1 0 1];
            [1 1 0]];
        
if length(R)==1
x=-R:2*R/(N-1):R;
y=-R:2*R/(N-1):R;
rays=[];
intensity=1;
for i=1:N
   for j=1:N
    rho=x(i)^2+y(j)^2;
    if  rho<=R^2
     for k=1:3
      rays=[rays; [r0+[x(i) y(j) 0],[0 0 1],0,1.0,RGB(k), intensity,RGB_colors(k,:)*intensity]];
     end
    end
   end
end
else
    phi=linspace(0,2*pi*(M-1)/M,M);
%     size(phi)
    rho=linspace(R(1),R(2),N);
%     size(rho)
    rays=[];
    for k=1:3
        for i=1:N
            for j=1:M
                   % ������������� ����� ������� ������ �� ��������� ���������
                   % ��������������, ��� ��� ������� ������������� ����� -80 ���� �
                   % 80 ����.
%                    rho=sqrt(x(i)^2+y(j)^2);
%                    if rho>=R(1)&&rho<=R(2)
                     
                     rays=[rays; [r0+rho(i)*[cos(phi(j)) sin(phi(j)) 0],...
                                  [0 0 1],0,1.0,RGB(k),0,RGB_colors(k,:)]];
                     rays(size(rays,1),10) = checkerPattern(12,12,rays(size(rays,1),1),rays(size(rays,1),2));
                     rays(size(rays,1),11:13) = rays(size(rays,1),11:13)*rays(size(rays,1),10);
                     
%                   end
            end
        end
    end
end


end

function intencity = checkerPattern(T_x,T_y,pos_X,pos_Y)
intencity = 0.5*(1+sign(sin(T_x*pos_X).*cos(T_y*pos_Y)));
end

