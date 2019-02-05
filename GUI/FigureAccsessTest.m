function  FigureAccsessTest( )
%FIGUREACCSESSTEST Summary of this function goes here
%   Detailed explanation goes here
close all; clear all; clc;
fig = figure(1);
uiTabGrup_1=uitabgroup(fig,'Position',[0.1 0.1 0.5 0.5]);
uiTab_1=uitab(uiTabGrup_1,'Title','Spot diagramm');
uiTab_2=uitab(uiTabGrup_1,'Title','Spot diagramm');
uiTab_2=uitab(uiTabGrup_1,'Title','Spot diagramm');
a=axes('parent',uiTab_2);
get(a)
end

