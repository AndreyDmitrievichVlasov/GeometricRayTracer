function [ x_spot,y_spot,colors,angleSize] = drawSpotDiagram(fig_handler,quad_,rays)
%DRAWSPOTDIAGRAM Summary of this function goes here
%   Detailed explanation goes here
%     fig_handler=figure('Units', 'centimeters', 'pos',  [0 0 dimension(1) dimension(2)]);
%     axis vis3d 
%     set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
%     set(fig_handler,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman');
tic
[x_spot,y_spot,colors,angleSize,waveLngthKeys,RMS,AverageGeo]=spotDiagram(quad_,rays);
toc


DrawSpot(x_spot{1},y_spot{1},colors{1},waveLngthKeys{1},RMS{1},AverageGeo{1},{3 ,3, 1},quad_);   
DrawQuadSpotDiagramm(quad_);
DrawSpot(x_spot{2},y_spot{2},colors{2},waveLngthKeys{2},RMS{1},AverageGeo{1},{3 ,3, 2},quad_);   
DrawQuadSpotDiagramm(quad_);
DrawSpot(x_spot{3},y_spot{3},colors{3},waveLngthKeys{3},RMS{1},AverageGeo{1},{3 ,3, 3},quad_);   
DrawQuadSpotDiagramm(quad_);
DrawSpot(x_spot,y_spot,colors,waveLngthKeys,RMS,AverageGeo,{3 ,3, 4:9},quad_);   
DrawQuadSpotDiagramm(quad_);

end
function DrawQuadSpotDiagramm(quad_)
  hold on;
 if quad_.apertureType==1 % rectangular aperture
     L2=quad_.apertureData(1);
     H2=quad_.apertureData(2);
     plot(0.5*[-L2 L2   L2 -L2 -L2]+quad_.position(1),...
            0.5*[H2 H2 -H2 -H2  H2]+quad_.position(2),'k','LineWidth',1.5);
     xlim([-0.51*L2 0.51*L2]+quad_.position(1));
     ylim([-0.51*H2 0.51*H2]+quad_.position(2));
    end % we don't plot the boundaries if the quad is not rectangular. To be fixed
hold off;
end

function DrawSpot(x_spot,y_spot,colors,wLength,RMS,AverageGEO,position,quad)
subplot(position{1},position{2},position{3})
hold on;
wl='';
legend_map={};

if length(wLength)~=1
    for i=1:length(wLength)
        wl = [wl,'  \lambda = ',num2str(wLength{i}),' \mum'];
        legend_map{i}=['  \lambda = ',num2str(wLength{i}),' \mum', ' RMS = ',num2str(RMS{i}),' GEO = ',num2str(AverageGEO{i})];
    end
else
   wl = [wl,'  \lambda = ',num2str(wLength),' \mum']; 
%    legend_map={['  \lambda = ',num2str(wLength),' \mum'],[ ' RMS = ',num2str(RMS)],[' GEO = ',num2str(AverageGEO)]};
end


title(['Spot diagramm for ',wl]);

if iscell(x_spot)
        if length(x_spot)~=length(y_spot)
              disp('error in spot diagram drawning');return;
        end
    for j=1:length(x_spot)
            if length(x_spot{j})>5500
            for i=1:5500
                idx=1+randi(length(x_spot{j})-1);
                if~(norm(colors{j}(idx,:)-[0.05 0.05 0.05])<=0.05)
                plot(x_spot{j}(idx),y_spot{j}(idx),'.','color',1-colors{j}(idx,:));
                end
           end

            else
                for i=1:length(x_spot{j})
                    if~(norm(colors{j}(i,:)-[0.05 0.05 0.05])<=0.05)
                    plot(x_spot{j}(i),y_spot{j}(i),'.','color',1-colors{j}(i,:));
                    end
                end
            end
    end
else
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
end
 L2=quad.apertureData(1)/2;
 H2=quad.apertureData(2)/2;
 col=[[1 0 0];[0 1 0];[0 0 1]];
 
 
  for i=1:length(legend_map) 
      text(-4,1+(i-1)*0.75,legend_map{i},'Color',col(length(legend_map)-i+1,:));
  end

 
    hold off;
    grid on;
    axis equal;
    xlabel('x, [ mm ]');
    ylabel('y, [ mm ]');  
end
