close all
clear all
clc
% f=figure('Units','centimeters','Position',[0 0 50 100]); 
f=figure('Units','centimeters'); 
set(get(f,'CurrentAxes'),'name','����������� ������ �-�.');
for i=1:20
    subplot(5,4,i);
    title(['������� �', num2str(i)])
    DrawPoints();
end
