close all; clear all; clc;
n_hiral=10;
m_hiral=10;
r_tybe=sqrt(3)/pi*sqrt(n_hiral^2+m_hiral^2+n_hiral*m_hiral)/2;
r_1=r_tybe-0.5;
r_2=r_1+0.5;
m_e=1/2;
h_Plank=1;
E=10^7;
translationT=sqrt(3);
N_s=100;
M_s=100;
% k_c_s=linspace(-2*pi/translationT,2*pi/translationT,256);
ks=linspace(0,100,10000);
J=@(m,x)(besselj(m,x));
Y=@(m,x)((J(m,x)*cos(pi*m)-J(-m,x))/sin(pi*m));

K_rho=@(n,k_c)(sqrt(2*m_e/h_Plank^2*E-(2*pi/translationT*n+k_c).^2));
besselDifference=@(n,m,k_c)(besselj(m,K_rho(n,k_c)*r_2)*bessely(m,K_rho(n,k_c)*r_1)-...
                            besselj(m,K_rho(n,k_c)*r_1)*bessely(m,K_rho(n,k_c)*r_2));
besselDifference_=@(m,k_c)(besselj(m,k_c*r_2).*bessely(m,k_c*r_1)-...
                           besselj(m,k_c*r_1).*bessely(m,k_c*r_2));

                         
                         
                         
                         
figure(1);
differense=zeros(100,size(ks,2));
hold on;
m=100;
col=hsv(m+1);
for i=0:m
plot(ks,besselDifference_(i,ks),'Color',col(i+1,:))
end     
grid on;
hold off;
ylim([-0.08 0.02]);
% imagesc(differense);
% colorbar;
% besselDifference=@(n,m,k_c)(bessely(m,r_1*K_rho(n,k_c)));
% k_c_s=linspace(-2*pi/translationT,2*pi/translationT,1000);
% k_c_y=linspace(0.1,2*pi/translationT,1000);
% 
% figure(1)
% subplot(1,2,1)
% hold on;
% for i=0:5
%     plot(k_c_y,bessely(i,20*k_c_y));
% end
% 
% grid on;
% hold off;
% % axis equal;
% 
% subplot(1,2,2)
% hold on;
% for i=0:5
%     plot(k_c_s,J(i,5*k_c_s));
% end
% grid on;
% hold off;
% axis equal;




% besselDifferenceMap=zeros(N_s+1,M_s+1,length(k_c_s));
% 
% for i=0:N_s
%     for j=0:M_s
%         for k=1:length(k_c_s)
% %             besselDifferenceMap(i+1,j+1,k)=K_rho(i,k_c_s(k));%besselDifference(i,j,k_c_s(k));
%             besselDifferenceMap(i+1,j+1,k)=besselDifference(i,j,k_c_s(k))^2 ;
%         end
%     end
% end

%  writeGif('besselsDiff.gif',besselDifferenceMap,1/30);
% figure(1)
% square=sqrt(length(k_c_s));
% for i=1:length(k_c_s)
% subplot(square,square,i);
% title(['K_c = ',num2str(k_c_s(i))])
% imagesc(real(besselDifferenceMap(:,:,i)));
% colorbar;
% colormap hot;
% end
% 
% 
% figure(2)
% square=sqrt(length(k_c_s));
% for i=1:length(k_c_s)
% subplot(square,square,i);
% title(['K_c = ',num2str(k_c_s(i))])
% imagesc(imag(besselDifferenceMap(:,:,i)));
% colorbar;
% colormap winter;
% end