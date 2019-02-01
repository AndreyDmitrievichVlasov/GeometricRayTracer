function  FigureAccsessTest( )
%FIGUREACCSESSTEST Summary of this function goes here
%   Detailed explanation goes here
close all; clear all; clc;
fig = figure(1);
ax = subplot(1,1, 1, 'Parent', fig);
p = plot(ax, [1:2]);
hold(ax, 'on'); 
set(ax, 'XGrid','on');set(ax, 'YGrid','on'); 
set(p, 'XData', 5:50, 'YData', cos(5:50));
get(p)
end

