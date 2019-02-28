function EditElementGUI( Element )
%EDITELEMENTGUI Summary of this function goes here
%   Detailed explanation goes here

s_size=GlobalGet('Screensize');

% L=300;
% 
% padding=10;


if strcmp(Element.type,'lens')
    
    fig_handler=figure('Units', 'pixels', 'pos',[s_size(3)/2-300 s_size(4)/2-250 600 500],'MenuBar','None','NumberTitle','Off');

    GlobalSet('TableCellEditForm',fig_handler);

    surf_1_handler = uipanel(fig_handler,'Position',[0.005 0.005 0.5 0.99]);
    surf_2_handler = uipanel(fig_handler,'Position',[0.50  0.005 0.5 0.99]);

    set(surf_1_handler,'Title','Front lens surface data');

    set(surf_2_handler,'Title','Back lens surface data');


    set(fig_handler,'Name',['Element ',num2str(GlobalGet('ActiveTableRow')),' properties edit']);    

    expandSurfData2GUI(surf_1_handler,Element.frontSurface);

    expandSurfData2GUI(surf_2_handler,Element.backSurface);


else
    fig_handler=figure('Units', 'pixels', 'pos',[s_size(3)/2-150 s_size(4)/2-50 600 500],'MenuBar','None','NumberTitle','Off');

    GlobalSet('TableCellEditForm',fig_handler);

    surf_1_handler = uipanel(fig_handler,'Position',[0.005 0.005 0.5 0.99]);

    set(surf_1_handler,'Title','Surface data');

    set(fig_handler,'Name',['Element ',num2str(GlobalGet('ActiveTableRow')),' properties edit']);    

    expandSurfData2GUI(surf_1_handler,Element);

end

end

function expandSurfData2GUI(handlerUI,surfData)
positionPannel = uipanel(handlerUI,'Position',[0.0  0.88 1 0.12],'Title','Suface position');
[textFields,~] = initFields(surfData.position,{' X, [mm]',' Y, [mm]',' Z, [mm]'},positionPannel,0.6,300,10);
GlobalSet('ElementPositionX',textFields(1));
GlobalSet('ElementPositionY',textFields(2));
GlobalSet('ElementPositionZ',textFields(3));

orientationPannel = uipanel(handlerUI,'Position',[0.0  0.76 1 0.12],'Title','Suface orientation');
[textFields,~] = initFields(surfData.angles,{'A, [grad]','B, [grad]','C, [grad]'},orientationPannel,0.6,300,10);
GlobalSet('ElementAngleX',textFields(1));
GlobalSet('ElementAngleY',textFields(2));
GlobalSet('ElementAngleZ',textFields(3));

aperturePannel = uipanel(handlerUI,'Position',[0.0  0.64 1 0.12],'Title','Suface aperture');
[textFields,~] = initFields([surfData.L surfData.H],{'L, [mm]','W, [mm]'},aperturePannel,0.5,300,10);
GlobalSet('ElementL',textFields(1));
GlobalSet('ElementW',textFields(2));
ExtraDataPannel = uipanel(handlerUI,'Position',[0 0 1 0.64],'Title',[surfData.extraDataType,' extra data']);
s = uicontrol(ExtraDataPannel,'Style','slider','Min',0,'Max',1,'Value',1,...
                'SliderStep',[0.05 0.2],'Position',[274 0 20 296]);
dataFiels = fieldnames(surfData.extraData);            
% getfield(surfData.extraDataType,dataFiels(i));
for i=1:length(dataFiels)
p = uipanel(ExtraDataPannel,'Position',[0 0.1*(i-1) 0.8 0.1],'Title',dataFiels{i});
end
            
%             get(s)

%  mirror=struct('XYZ',xyz,'ABCD',[normal' normal'*r'],'angles',e,'position',r,...
%                   'L',L,'H',H,'TextureHeight',@()(0),'invTBN',TBN^-1,...
%                   'TBN',TBN,'TextureNormal',@()(normal'),...
%                   'extraDataType','','extraData',[],'rotationMatrix',...
%                   xRotMat(e(1)/180*pi)*yRotMat(e(2)/180*pi)*zRotMat(e(3)/180*pi)...
%                   ,'type','surface');

end

function [textFields,labelFields] = initFields(Data,FieldsNames,parentUI,aspect,sizeX,padding)
text_plus_label=sizeX/length(FieldsNames)-padding;

text_length   = aspect*text_plus_label;

label_length = (1-aspect)*text_plus_label;

for i=1:length(FieldsNames)
    labelFields(i) = uicontrol('parent', parentUI ,'pos',[1+ ( i-1)*(label_length + text_length+padding) 11 label_length 30],'String', FieldsNames{i},'style','text');
    textFields(i)=  uicontrol('parent', parentUI ,'pos', [1+ i*label_length + ( i-1)*(text_length+padding) 11 text_length 30],'style','edit','String',num2str(Data(i)));
end

end