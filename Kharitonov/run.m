clear all; close all; clc;
x=linspace(0,2*pi,256);
figure(1)

[ w ] = W_func_distrebution( x,x, 1, 10, 100 );

imagesc(x,x,real(w));
colorbar;
colormap jet;
grid on;
set(gca,'xtick',[0 pi 2*pi]);
set(gca,'ytick',[0 pi 2*pi]);

axis equal;