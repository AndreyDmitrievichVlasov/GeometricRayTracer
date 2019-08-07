close all; clc; clear all;
%2D example
f_1 = figure('Units', 'centimeters', 'OuterPosition', [1 1 17 10]);

set(f_1,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');

set(f_1,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 

t = linspace(-1,1,1000)*pi;
f_t = @(t)(cos(t*10).*exp(-t.^2/pi^2));
y=f_t(t);
hold on;
    plot(t,y,'r','LineWidth',1.5,'LineSmooth','on');% LineSmooth only for ver lower than 2014 
    plot(t,y.^2,'Color',[0.5 0.6 1],'LineWidth',0.5,'LineSmooth','on');
    plot(t,y.^3,'g','LineWidth',1,'LineSmooth','on');
    hold off;
    grid on;
    xlim([t(1), t(length(t))]);
    
axis equal   
    
xlabel('x, \mum');%\mum - кодировка Tex для микрометров остальные греческие
% фимволы по такому же принципу берутся из таблицы кодировок для Tex
ylabel('y, \mum','Rotation',0);
redot();% меняет точки на запятые
title('Trololo');
plot2svg('2dGraphEample.svg',f_1);






f_2 = figure('Units', 'centimeters', 'OuterPosition', [1 1 17 17]);

set(f_2,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');

set(f_2,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 

[x,y]=meshgrid(t,t);
f_t = @(x,y)(cos(x*10).*cos(y*10).*exp(-y.^2/pi^2).*exp(-x.^2/pi^2));

imagesc(t,t,f_t(x,y));

xlabel('x, \mum');%\mum - кодировка Tex для микрометров остальные греческие
% фимволы по такому же принципу берутся из таблицы кодировок для Tex
ylabel('y, \mum','Rotation',0);

grid on;
colorbar_handler = colorbar;

set(get(f_2,'CurrentAxes'),'xtick',linspace(t(1),t(length(t)),7))
set(get(f_2,'CurrentAxes'),'ytick',linspace(t(1),t(length(t)),7))

redot();% меняет точки на запятые

axis equal;

title('Trololo');

plot2svg('2dSurfEample.svg',f_2);

