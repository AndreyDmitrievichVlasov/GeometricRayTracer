function  ResultsDisplayInit( parent )
%RESULTSDISPLAYINIT Summary of this function goes here
%   Detailed explanation goes here
GlobalSet('ResultsTabPannel',uitabgroup(parent,'Position',[0.01 0.01 0.99 0.99]));
GlobalSet('TracingResutsPannel',uitab(GlobalGet('ResultsTabPannel'),'Title','Tracing'))
GlobalSet('SpotsResutsPannel',uitab(GlobalGet('ResultsTabPannel'),'Title','Spot diagramm'));
GlobalSet('IlluninationResutsPannel',uitab(GlobalGet('ResultsTabPannel'),'Title','Illumination'));


end

