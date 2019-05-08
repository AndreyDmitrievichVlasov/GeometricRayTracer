% закрытие всех открытых файловых дескрипторов/очистка переменных/очистка
% консоли
close all; clear all; clc;
%% параметры для ввода
a=0.04;

delta=50*10^-6;

phiAngle=pi/4;

focalLength=1;

waveLength=10^-5;

%%
xPixels = floor(a/delta);

b=a/cos(phiAngle);

yPixels =floor(b/delta);

x=linspace(-a/2,a/2,xPixels);

y=linspace(-b/2,b/2,yPixels);

phasePatternMap  = Bi(mod(Phi(x,y*cos(phiAngle),focalLength,waveLength),2*pi));

mask  = getGaussMask( x, y, a/6, phiAngle );

phasePatternMapMasked = phasePatternMap +(phasePatternMap.*mask==1);

figure(1);
subplot(1,2,1)

imagesc(x,y,(phasePatternMap));

colorbar;

colormap gray;

grid on;

axis equal;

subplot(1,2,2)

imagesc(x,y,(phasePatternMapMasked));

colorbar;

colormap gray;

grid on;

axis equal;


cmap = [[0 0 0]; [1 1 1]; [1 0. 0.]];

imwrite(phasePatternMap+1,cmap,'lensLayout_.png');

% imwrite(phasePatternMap+1,cmap,'lensLayout_.bmp');


imwrite(phasePatternMapMasked+1,cmap,'lensLayout_masked.png');

% imwrite(phasePatternMapMasked+1,cmap,'lensLayout_masked.bmp');


