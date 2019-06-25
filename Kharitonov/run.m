clear all; close all; clc;
a = 0.005;
addpath([cd,'\figureSaveExample'])
% delta=40*10^-6;

delta=2*10^-5;

phiAngle=pi/4;

focalLength=0.4;

waveLength=10.6*10^-6;

fclSptSize=waveLength*focalLength/a;

pixels = floor(a/delta);

x=linspace(-a/2,a/2,pixels);

sigma=a/6;

[ w ] = W_func_distrebution( x,x,64,64, sigma, waveLength, focalLength );
%  w  =lam/2/cos(theta)*Bi(mod(Phi(x*cos(theta),x,1,lam),2*pi));
%  w  = Bi(mod(Phi(x*cos(theta),x,1,lam),2*pi));

% w=mod(Phi(x*cos(theta),x,1,lam),2*pi);
%  w=Phi(x*cos(theta),x,1,lam);

FIG_HANDLER = figure('Units', 'centimeters', 'OuterPosition', [0 0 17 17]./[0.13 0.11 0.775 0.79991]);
    
set(FIG_HANDLER,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');

set(FIG_HANDLER,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 

imagesc(x*1000,x*1000,w.*conj(w));
hold on
t=linspace(0,2*pi,100);
plot(cos(t)*fclSptSize*1000,sin(t)*fclSptSize*1000,'r');

hold off;
colorbar;
colormap gray;
axis equal;
ylabel('y,\mum');
xlabel('x,\mum');
ylim([min(x) max(x)]*1000);
xlim([min(x) max(x)]*1000);
redot();
% plot2svg('Intence(Kirhgoff_integral).svg');