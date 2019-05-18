function drawSpotDiagram(PSFData,quad_)
          %DRAWSPOTDIAGRAM Summary of this function goes here
%   Detailed explanation goes here
%     fig_handler=figure('Units', 'centimeters', 'pos',  [0 0 dimension(1) dimension(2)]);
%     axis vis3d 
%     set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
%     set(fig_handler,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman');
% tic
% [x_spot,y_spot,colors,angleSize,waveLngthKeys,RMS,AverageGeo]=spotDiagram(quad_,rays);
% toc
spacing = [3 length(PSFData.WaveLengths)/3];

modSpacing=(spacing(2))-floor(spacing (2));

if modSpacing~=0
    spacing(2)=floor(spacing(2))+1;
end

fig_1=figure(1);

allSpotsIdx=[length(PSFData.WaveLengths)+1 length(PSFData.WaveLengths)+6];

spacing(2)=spacing(2)+2;

%% Drawning spot diagramm 
for i=1:length(PSFData.WaveLengths)
DrawSpot(PSFData.XSpot{i},PSFData.YSpot{i},...
         PSFData.SpotColor{i},PSFData.WaveLengths{i},...
         PSFData.RMS{i},PSFData.AvgR{i},{spacing(1) ,spacing(2), i},quad_);
DrawQuadSpotDiagramm(quad_);

end
 DrawSpot(PSFData.XSpot,PSFData.YSpot,...
          PSFData.SpotColor,PSFData.WaveLengths,...
          PSFData.RMS,PSFData.AvgR,{spacing(1) ,spacing(2), allSpotsIdx},quad_);
 DrawQuadSpotDiagramm(quad_);
%% Drawning intencity diagramm
fig_2=figure(2);

for i=1:length(PSFData.WaveLengths)
DrawIntencity(PSFData.WaveLengths{i},...
         PSFData.RMS{i},PSFData.AvgR{i},PSFData.PSFLayers{i},{spacing(1) ,spacing(2), i},quad_);
DrawQuadSpotDiagramm(quad_);
end
DrawIntencity(PSFData.WaveLengths ,...
         PSFData.RMS ,PSFData.AvgR ,PSFData.PSFLayers ,{spacing(1) ,spacing(2), allSpotsIdx},quad_);
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
%          for j=1:length(x_spot)
%             patch([x_spot{j} ;0],[y_spot{j}; nan],'EdgeColor','none','Marker','o','MarkerFaceColor','flat');
%         end
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
    
%     a = [[0 1 1];[1 0 1];[1 1 0]];
%     
%     cMap(:,1,1)=1-colors(:,1);
%     cMap(:,1,2)=1-colors(:,2);
%     cMap(:,1,3)=1-colors(:,3);
%     
% % size(cMap)v
% % imagesc(cMap)
%     [cMap, map]=rgb2ind((cMap),a);
% color
% %     cMap
%     
% p = patch([x_spot ;0],[y_spot; nan],[cMap(:,1); 0],'EdgeColor','none','Marker','o','MarkerFaceColor','flat');
% % get(p)
% colormap(a);
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





function DrawIntencity(wLength,RMS,AverageGEO,PSFLayers,position,quad_)
subplot(position{1},position{2},position{3})
hold on;
wl='';
legend_map={};
%% Legend init
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


if iscell(PSFLayers)
x_s=linspace(-quad_.apertureData(1)/2,quad_.apertureData(1)/2,size(PSFLayers{1},2));
y_s=linspace(-quad_.apertureData(2)/2,quad_.apertureData(2)/2,size(PSFLayers{1},1));
intencityMap=zeros(size(PSFLayers{1}));
    for i=1:length(PSFLayers)
        intencityMap=intencityMap+PSFLayers{i};
    end
    imagesc(x_s,y_s,intencityMap);
    xlim([-quad_.apertureData(1)/2,quad_.apertureData(1)/2]);
    
    ylim([-quad_.apertureData(2)/2,quad_.apertureData(2)/2]);

else
    x_s=linspace(-quad_.apertureData(1)/2,quad_.apertureData(1)/2,size(PSFLayers,2));
    y_s=linspace(-quad_.apertureData(2)/2,quad_.apertureData(2)/2,size(PSFLayers,1));
   
    imagesc(x_s,y_s,PSFLayers);
    xlim([-quad_.apertureData(1)/2,quad_.apertureData(1)/2]);
    
    ylim([-quad_.apertureData(2)/2,quad_.apertureData(2)/2]);
end


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
