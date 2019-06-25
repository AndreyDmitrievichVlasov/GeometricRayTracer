close all
clear all
clc
% f=figure('Units','centimeters','Position',[0 0 50 100]); 
f=figure('Units','centimeters'); 
set(get(f,'CurrentAxes'),'name','Контрольная работа С-М.');
for i=1:20
    subplot(5,4,i);
    title(['Задание №', num2str(i)])
    DrawPoints();
end
