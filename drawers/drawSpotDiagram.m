function [ x_spot,y_spot,colors,angleSize] = drawSpotDiagram(fig_handler,quad_,rays)
%DRAWSPOTDIAGRAM Summary of this function goes here
%   Detailed explanation goes here
%     fig_handler=figure('Units', 'centimeters', 'pos',  [0 0 dimension(1) dimension(2)]);
%     axis vis3d 
%     set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
%     set(fig_handler,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman');
   tic
    [x_spot,y_spot,colors,angleSize]=spotDiagram(quad_,rays);
   toc
    hold on;
    if length(x_spot)>1500
        for i=1:2500
            idx=1+randi(length(x_spot)-1);
            plot(x_spot(idx),y_spot(idx),'.','color',colors(idx,:));
        end
    
    else
        for i=1:length(x_spot)
            plot(x_spot(i),y_spot(i),'.','color',colors(i,:));
        end
    end
    plot([-quad_.L/2 quad_.L/2   quad_.L/2 -quad_.L/2 -quad_.L/2]+quad_.position(1),...
           [quad_.H/2 quad_.H/2 -quad_.H/2 -quad_.H/2  quad_.H/2]+quad_.position(2),'k','LineWidth',1.5);
    xlim([-1.1*quad_.L/2 1.1*quad_.L/2]+quad_.position(1));
    ylim([-1.1*quad_.H/2 1.1*quad_.H/2]+quad_.position(2));
    hold off;
    grid on;
    axis equal;
    xlabel('x, [ m ]');
    ylabel('y, [ m ]');
end

