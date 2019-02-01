
function  MainGUI( )
%MAINGUI Summary of this function goes here
%   Detailed explanation goes here
close all; clc; clear all;
addpath([cd '\UIinitilazers'])
% global Scema;
% % Scema{1}='Empty';
% 
% global choosenTableRow;
% 
% choosenTableRow = 1;
% Scema{1} = flatQuad( 0.25,0.25,[0 0 0],[0.25 0 17]);
% scrsize= get( 0, 'Screensize' );



GlobalSet('ActiveTableRow',1);
GlobalSet('ElementsList',{});
% GlobalSet('RightPannel',rightButtonsPannel);

scrsize = get( groot, 'Screensize' );
scrsizefloat=scrsize;
scrsizefloat(3:4)=[scrsize(3)/scrsize(4) 1];
% disp(scrsize)
fig_handler=figure('Units', 'pixels', 'pos', scrsize,'ToolBar','none' );
% get(fig_handler)
set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');

GlobalSet('LeftPannel',uipanel(fig_handler,'Title','Scene edit', 'Position',[0.005 0.005 0.127 0.995].*scrsizefloat));

GlobalSet('RightPannel',uipanel(fig_handler,'Title','Trace results', 'Position',[0.23 0.005 0.4325 0.995].*scrsizefloat));

%% Optical elements table % TODO : do optimisation in folowing functions

ElementsDataTableInit( GlobalGet('LeftPannel') );

%% right buttons gorup

DataTableButtonsInit( GlobalGet('LeftPannel') );
%% Tracing results windows

ResultsDisplayInit( GlobalGet('RightPannel') );


end
% 
% function buildSpotAxes()
% %     global tracingResultsTabulatedPannel;
% %     
% %    
% %     tarcingAxis = subplot(1,1, 1, 'Parent', tracingView);
% %     p = plot(tarcingAxis, [1:2]);
% %     hold(tarcingAxis, 'on'); 
% %     set(tarcingAxis, 'XGrid','on');set(tarcingAxis, 'YGrid','on'); 
% %     set(p, 'XData', 5:50, 'YData', cos(5:50));
% 
% %     get(tarcingAxis,'Parent')
%     
% %     set(tarcingAxis,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman');
% % 
% %     set(tarcingAxis,'ZGrid','on');set(tarcingAxis,'YGrid','on');set(tarcingAxis,'XGrid','on');
% % 
% %      get(tarcingAxis)
% end

