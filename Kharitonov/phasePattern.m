% закрытие всех открытых файловых дескрипторов/очистка переменных/очистка
% консоли
close all; clear all; clc;
%% параметры для ввода
a=0.02;

% delta=40*10^-6;

delta=25*10^-6;

phiAngle=pi/4;

focalLength=0.4;

waveLength=10.6*10^-6;

%%
xPixels = floor(a/delta);

b=a/cos(phiAngle);

yPixels =floor(b/delta);

x=linspace(-a/2,a/2,xPixels);

y=linspace(-b/2,b/2,yPixels);

phasePatternMap  = Bi(mod(Phi(x,y*cos(phiAngle),focalLength,waveLength),2*pi));

mask  = getGaussMask( x, y, 35*10^-4, phiAngle );

phasePatternMapMasked = phasePatternMap +(phasePatternMap.*mask==1);

figure(1);
subplot(1,2,1)

imagesc(x,y,(phasePatternMap));

colorbar;

colormap gray;

grid on;

xlabel('x, [mm]'),ylabel('y, [mm]')

axis equal;

subplot(1,2,2)

imagesc(x,y,(phasePatternMapMasked));

colorbar;

colormap gray;

grid on;

xlabel('x, [mm]'),ylabel('y, [mm]')

axis equal;

cmap = [[0 0 0]; [1 1 1]; [1 0. 0.]];

imwrite(phasePatternMap+1,cmap,'lensLayout_.png');

% imwrite(phasePatternMap+1,cmap,'lensLayout_.bmp');


imwrite(phasePatternMapMasked+1,cmap,'lensLayout_masked.png');

% imwrite(phasePatternMapMasked+1,cmap,'lensLayout_masked.bmp');


