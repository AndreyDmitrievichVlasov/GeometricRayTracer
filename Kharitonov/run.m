clear all; close all; clc;
a = 0.005;

% delta=40*10^-6;

delta=2*10^-5;

phiAngle=pi/4;

focalLength=0.4;

waveLength=10.6*10^-6;

fclSptSize=waveLength*focalLength/a;

pixels = floor(a/delta);

x=linspace(-a/2,a/2,pixels);

sigma=a/6;
figure(1)

[ w ] = W_func_distrebution( x,x,64,64, sigma, waveLength, focalLength );
%  w  =lam/2/cos(theta)*Bi(mod(Phi(x*cos(theta),x,1,lam),2*pi));
%  w  = Bi(mod(Phi(x*cos(theta),x,1,lam),2*pi));

% w=mod(Phi(x*cos(theta),x,1,lam),2*pi);
%  w=Phi(x*cos(theta),x,1,lam);
imagesc(x,x,w.*conj(w));
hold on
t=linspace(0,2*pi,100);
plot(cos(t)*fclSptSize,sin(t)*fclSptSize,'r');

hold off;
colorbar;
colormap gray;
% grid on;
axis equal;
