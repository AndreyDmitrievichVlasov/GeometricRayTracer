function [ rays ] = paraxialSpot( r0, R, varargin)
%LED Summary of this function goes here
%   Detailed explanation goes here
% R=1;
N=1;
M=1000;
RGB=[750 650 550]/1000;%wavelength in micrometers

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
   if isempty(varargin)
       for k=1:3
            for i=1:N
                for j=1:M
                       % ������������� ����� ������� ������ �� ��������� ���������
                       % ��������������, ��� ��� ������� ������������� ����� -80 ���� �
                       % 80 ����.
                       RHO = rho(i)*[cos(phi(j)) sin(phi(j)) 0];
                       rays=[rays; [r0+RHO,[0 0 1],0,1.0,RGB(k),0,RGB_colors(k,:)]];
                       intence=sqrt(sum(RHO.*RHO))/R(2);
                       if intence>1
                           intence=1;
                       end
                       rays(size(rays,1),10) =intence*checkerPattern(5,5,rays(size(rays,1),1),rays(size(rays,1),2));
                       rays(size(rays,1),11:13) = rays(size(rays,1),11:13)*rays(size(rays,1),10);

                end
            end
        end
   else
      picture = imread(varargin{1})+1;
        for k=1:3
            for i=1:N
                for j=1:M
                       % ������������� ����� ������� ������ �� ��������� ���������
                       % ��������������, ��� ��� ������� ������������� ����� -80 ���� �
                       % 80 ����.
                       RHO=rho(i)*[cos(phi(j)) sin(phi(j)) 0];
                       idx=1+fix([R(2)+RHO(1),R(2)+RHO(2)]/2/R(2).*(size(picture)-1));
                       idx=(idx==0)+idx;
%                        idx=(idx>=picture())+idx;
                       
                       idx = picture(idx(1),idx(2));
                       rays=[rays; [r0+RHO,[0 0 1],0,1.0,RGB(idx),1,RGB_colors(idx,:)]];
                         
                         
                      
%                          
%                          rays(size(rays,1),10) = 1;%checkerPattern(5,5,rays(size(rays,1),1),rays(size(rays,1),2));
%                          
%                          rays(size(rays,1),11:13) = RGB_colors(idx);%rays(size(rays,1),11:13)*rays(size(rays,1),10);

                end
            end
        end
   end
end


end

function intencity = checkerPattern(T_x,T_y,pos_X,pos_Y)
% intencity = 0.5*(1+sign(sin(T_x*pos_X).*cos(T_y*pos_Y)));
intencity = 1;%0.5*(1+sign(cos(T_y*pos_Y)));
% intencity = 0.5*(1+sign(sin(T_x*pos_X)));

end

