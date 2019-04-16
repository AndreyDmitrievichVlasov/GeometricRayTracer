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
    if length(x_spot)>5500
        for i=1:5500
            idx=1+randi(length(x_spot)-1);
            if~(norm(colors(idx,:)-[0.05 0.05 0.05])<=0.05)
            plot(x_spot(idx),y_spot(idx),'.','color',1-colors(idx,:));
            end
       end
    
    else
        for i=1:length(x_spot)
            if~(norm(colors(i,:)-[0.05 0.05 0.05])<=0.05)
            plot(x_spot(i),y_spot(i),'.','color',1-colors(i,:));
            end
        end
    end
%    plot([-quad_.L/2 quad_.L/2   quad_.L/2 -quad_.L/2 -quad_.L/2]+quad_.position(1),...
%           [quad_.H/2 quad_.H/2 -quad_.H/2 -quad_.H/2  quad_.H/2]+quad_.position(2),'k','LineWidth',1.5);
    if quad_.apertureType==1 % rectangular aperture
     L2=quad_.apertureData(1);
     H2=quad_.apertureData(2);
     plot(0.5*[-L2 L2   L2 -L2 -L2]+quad_.position(1),...
            0.5*[H2 H2 -H2 -H2  H2]+quad_.position(2),'k','LineWidth',1.5);
     xlim([-0.51*L2 0.51*L2]+quad_.position(1));
     ylim([-0.51*H2 0.51*H2]+quad_.position(2));
    end % we don't plot the boundaries if the quad is not rectangular. To be fixed
    hold off;
    grid on;
    axis equal;
    xlabel('x, [ mm ]');
    ylabel('y, [ mm ]');
end

