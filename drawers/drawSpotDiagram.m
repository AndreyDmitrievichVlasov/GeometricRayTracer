function drawSpotDiagram(PSFData, quad_, varargin)
          %DRAWSPOTDIAGRAM Summary of this function goes here
%   Detailed explanation goes here
%     fig_handler=figure('Units', 'centimeters', 'pos',  [0 0 dimension(1) dimension(2)]);
%     axis vis3d 
%     set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
%     set(fig_handler,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman');
% tic
% [x_spot,y_spot,colors,angleSize,waveLngthKeys,RMS,AverageGeo]=spotDiagram(quad_,rays);
% toc




if ~checkInputVars(varargin{:})
    disp('incorrect list of input vars');
%     return;
else
    path2psf = parseInputVars( 'savePSF2',varargin{:} );
    if isempty(path2psf)
       path2psf='';
    end

    path2spot = parseInputVars( 'saveSpot2',varargin{:} );
    if isempty(path2spot)
    path2spot='';
    end
end

% aperture,tickness,r_1,r_2 






spacing = [length(PSFData.WaveLengths)/3 3];

spacing(1)=floor(spacing(1))+1;

allSpotsIdx=[length(PSFData.WaveLengths)+1 length(PSFData.WaveLengths)+3];


fig_1 = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);

set(fig_1,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');

set(fig_1,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 

% spacing(2)=spacing(2)+2;

%% Drawning spot diagramm 
for i=1:length(PSFData.WaveLengths)
DrawSpot(PSFData.XSpot{i},PSFData.YSpot{i},...
         PSFData.SpotColor{i},PSFData.WaveLengths{i},...
         PSFData.RMS{i},PSFData.AvgR{i},{spacing(1) ,spacing(2), i},quad_);
% DrawQuadSpotDiagramm(quad_);

end
 DrawSpot(PSFData.XSpot,PSFData.YSpot,...
          PSFData.SpotColor,PSFData.WaveLengths,...
          PSFData.RMS,PSFData.AvgR,{spacing(1) ,spacing(2), allSpotsIdx},quad_);
%  DrawQuadSpotDiagramm(quad_);
%% Drawning intencity diagramm
if ~isempty(path2spot)
    plot2svg(path2spot,fig_1);
end


fig_2 = figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);

set(fig_2,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');

set(fig_2,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 

for i=1:length(PSFData.WaveLengths)
DrawIntencity(PSFData.WaveLengths{i},...
         PSFData.RMS{i},PSFData.AvgR{i},PSFData.PSFLayers{i},{spacing(1) ,spacing(2), i},quad_);
% DrawQuadSpotDiagramm(quad_);
end
DrawIntencity(PSFData.WaveLengths ,...
         PSFData.RMS ,PSFData.AvgR ,PSFData.PSFLayers ,{spacing(1) ,spacing(2), allSpotsIdx},quad_);
% DrawQuadSpotDiagramm(quad_);

if ~isempty(path2psf	)
    plot2svg(path2psf,fig_2);
end

end

function DrawQuadSpotDiagramm(quad_)
%   hold on;
%  if quad_.apertureType==1 % rectangular aperture
%      L2=quad_.apertureData(1);
%      H2=quad_.apertureData(2);
%      plot(0.5*[-L2 L2   L2 -L2 -L2]+quad_.position(1),...
%             0.5*[H2 H2 -H2 -H2  H2]+quad_.position(2),'k','LineWidth',1.5);
%      xlim([-0.51*L2 0.51*L2]+quad_.position(1));
%      ylim([-0.51*H2 0.51*H2]+quad_.position(2));
%     end % we don't plot the boundaries if the quad is not rectangular. To be fixed
% hold off;
end

function DrawSpot(x_spot,y_spot,colors,wLength,RMS,AverageGEO,position,quad)
subplot(position{1},position{2},position{3})
hold on;
wl='';
legend_map={};

if length(wLength)~=1
    for i=1:length(wLength)-1
        wl = [wl,'  \lambda = ',num2str(wLength{i}),' \mum,'];
        legend_map{i}=['  \lambda = ',num2str(wLength{i}),' \mum', ' RMS = ',num2str(RMS{i}),' GEO = ',num2str(AverageGEO{i})];
    end
    wl = [wl,'  \lambda = ',num2str(wLength{length(wLength)}),' \mum.'];
        legend_map{length(wLength)}=['  \lambda = ',num2str(wLength{length(wLength)}),' \mum', ' RMS = ',num2str(RMS{i}),' GEO = ',num2str(AverageGEO{length(wLength)})];
else
   wl = [wl,'  \lambda = ',num2str(wLength),' \mum']; 
%    legend_map={['  \lambda = ',num2str(wLength),' \mum'],[ ' RMS = ',num2str(RMS)],[' GEO = ',num2str(AverageGEO)]};
end
x_lims=[inf,-inf];
y_lims=[inf,-inf];

title(['Spot diagramm for ',wl]);

if iscell(x_spot)
        if length(x_spot)~=length(y_spot)
              disp('error in spot diagram drawning');return;
        end
        
        %          for j=1:length(x_spot)
%             patch([x_spot{j} ;0],[y_spot{j}; nan],'EdgeColor','none','Marker','o','MarkerFaceColor','flat');
%         end
    for j=1:length(x_spot)
        
        x_lims=[min(x_lims(1),min(x_spot{j})),max(x_lims(2),max(x_spot{j}))];
        y_lims=[min(y_lims(1),min(y_spot{j})),max(y_lims(2),max(y_spot{j}))];
        
            if length(x_spot{j})>5500
            for i=1:5500
                idx=1+randi(length(x_spot{j})-1);
                if~(norm(colors{j}(idx,:)-[0.05 0.05 0.05])<=0.05)
                plot(x_spot{j}(idx),y_spot{j}(idx),'.','color',colors{j}(idx,:));
                end
           end

            else
                for i=1:length(x_spot{j})
                    if~(norm(colors{j}(i,:)-[0.05 0.05 0.05])<=0.05)
                    plot(x_spot{j}(i),y_spot{j}(i),'.','color',colors{j}(i,:));
                    end
                end
            end
    end
    x_lims=1.25*(x_lims-sum(x_lims)/2)+sum(x_lims)/2;
    y_lims=1.25*(y_lims-sum(y_lims)/2)+sum(y_lims)/2;
    xlim(x_lims);
    ylim(y_lims);
    axis equal;
     col=[];
     for i=1:length(colors)
         col = [col;min(colors{i})];
     end
else
        
        x_lims=[min(x_spot),max(x_spot)];
        y_lims=[min(y_spot),max(y_spot)];
      
    if length(x_spot)>5500
        
        for i=1:5500
            idx=1+randi(length(x_spot)-1);
            if~(norm(colors(idx,:)-[0.05 0.05 0.05])<=0.05)
            plot(x_spot(idx),y_spot(idx),'.','color',colors(idx,:));
            end
       end
    
    else
        for i=1:length(x_spot)
            if~(norm(colors(i,:)-[0.05 0.05 0.05])<=0.05)
            plot(x_spot(i),y_spot(i),'.','color',colors(i,:));
            end
        end
    end
      x_lims=1.25*(x_lims-sum(x_lims)/2)+sum(x_lims)/2;
    y_lims=1.25*(y_lims-sum(y_lims)/2)+sum(y_lims)/2;
    xlim(x_lims);
    ylim(y_lims);
     
     col=[];
%      for i=1:length(colors)
     col = [min(colors)];
%      end
end
%  L2=quad.apertureData(1)/2;
%  H2=quad.apertureData(2)/2;
 
  for i=length(legend_map):-1:1 
      text(x_lims(2)*1.25,y_lims(1)*0.85+(i-1)*(x_lims(2)-x_lims(1))/length(legend_map),legend_map{i},'Color',col(i,:));
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


%   col=[[1 0 0];[0 1 0];[0 0 1]];
    

  
%   for i=1:length(legend_map) 
%       text(-4,1+(i-1)*0.75,legend_map{i},'Color',col(length(legend_map)-i+1,:));
%   end

 
    hold off;
    grid on;
    axis equal;
    xlabel('x, [ mm ]');
    ylabel('y, [ mm ]');  
end
