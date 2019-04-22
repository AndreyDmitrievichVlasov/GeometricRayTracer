clear all; close all; clc;
x=linspace(-0.025,0.025,4096);
figure(1)
lam=10^-5;
theta=pi/4;
% [ w ] = W_func_distrebution( x,x, 1, 10, 100 );
%  w  =lam/2/cos(theta)*Bi(mod(Phi(x*cos(theta),x,1,lam),2*pi));
 w  = Bi(mod(Phi(x*cos(theta),x,1,lam),2*pi));

% w=mod(Phi(x*cos(theta),x,1,lam),2*pi);
%  w=Phi(x*cos(theta),x,1,lam);
imagesc(x,x,real(w));
colorbar;
colormap gray;
grid on;
% set(gca,'xtick',[0 pi 2*pi]);
% set(gca,'ytick',[0 pi 2*pi]);

axis equal;
figure(2)
plot(x,w(2048,:));
grid on;

cmap = [[0 0 0];[1 1 1]];

imwrite(w+1,cmap,'lensLayout.png');
imwrite(w+1,cmap,'lensLayout.bmp');