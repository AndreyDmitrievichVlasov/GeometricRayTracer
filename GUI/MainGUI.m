
function  MainGUI( )
%MAINGUI Summary of this function goes here
%   Detailed explanation goes here
close all; clc; clear all;

global Scema;
% Scema{1}='Empty';
global Table;
global choosenTableRow;
choosenTableRow = 1;
% Scema{1} = flatQuad( 0.25,0.25,[0 0 0],[0.25 0 17]);
% scrsize= get( 0, 'Screensize' );
scrsize = get( groot, 'Screensize' );
fig_handler=figure('Units', 'pixels', 'pos',scrsize );
set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(fig_handler,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman');
% set(fig_handler,'MenuBar',[]);
% set(fig_handler,'ResizeFcn','on');


% get(fig_handler)
axis square 
axis off;
hold on;

% f = figure('Position', [10 10 900 250]);

Table = uitable('Parent', fig_handler, 'Position', [10 10 410 scrsize(4)*0.8],'CellSelectionCallback', @(s,e)callback(e));

appendButton =  uicontrol(fig_handler,'Style','pushbutton','String','Append element','Position',...
    ([10 scrsize(4)*0.845 205 40]));
set(appendButton,'Callback',@appendButtonCallbacfnc);


removeButton = uicontrol(fig_handler,'Style','pushbutton','String', 'Remove element','Position',...
    [215 scrsize(4)*0.845 205 40]);%removeButtonCallbacfnc
set(removeButton,'Callback',@removeButtonCallbacfnc);

traceButton = uicontrol(fig_handler,'Style','pushbutton','String', 'Trace!','Position',...
    [10 scrsize(4)*0.845+40 410 40]);

secuenseEditButton = uicontrol(fig_handler,'Style','pushbutton','String', 'Edit Sequence','Position',...
    [10 scrsize(4)*0.845-40 205 40]);

secuenseEditButton = uicontrol(fig_handler,'Style','togglebutton','String', 'Use Sequence','Position',...
    [215 scrsize(4)*0.845-40 205 40]);

% get(apendButton)

% data = expandElementToCell(Scema);

set(Table,'ColumnFormat',{{'Surface','Mirror','TransparentDG','ReflectiveDG','Lens','Empty','SpotLight','PointLight','CustomLight','TestRay'}, [], [], [],[] })

set(Table,'ColumnWidth', {'auto', 'auto', 'auto', 'auto','auto'});

set(Table,'ColumnEditable', [true, false, false, false]);

set(Table,'ColumnName', {'Element type','Position','Rotation','Aperture','          '});

set(Table,'CellEditCallback',@(s,e)elementTypeCB(s,e));

% set(Table,'Data',data); 

end


function data = expandElementToCell(element)

    if strcmp(element,'Empty')
         data=[{'Empty'} {'-'} {'-'} {'-'} {'-'}];
    return;
    end
    
    if isempty(element.extraData)
        data=[{element.type} {num2str(element.position)} {num2str(element.angles)} {'-'} ];
    end
end

function callback(eventData)
 
if ~isempty(eventData.Indices)
    if eventData.Indices(2) == 5
        fprintf('Clicked Row %d\n', eventData.Indices)
    end
end

end
function appendButtonCallbacfnc(s,e)
    global Scema;
    global Table;
    global chosenTableRow;

    l=length(Scema);
    
    if l==0
        assignTableElementDescription(Table, 1, [{'Empty'} {'-'} {'-'} {'-'} {'-'}]);
        set(Table,'ColumnEditable', [true, false, false, false, false]);
        Scema{1}='Empty';
        chosenTableRow = 1;
    else
        assignTableElementDescription(Table, l+1, [{'Empty'} {'-'} {'-'} {'-'} {'-'}]);
        set(Table,'ColumnEditable', [true, false, false, false, false]);
        Scema{l+1}='Empty';
        chosenTableRow =l+1;
    
    end
end

function removeButtonCallbacfnc(s,e)
global Scema;
global Table;
global chosenTableRow;

% size(Scema);

data=get(Table,'Data');

if isempty(data)
    return;
end
if 1 == size(data,1)
    set(Table,'Data',[]);
    Scema={};
    return;
end

if chosenTableRow==size(data,1)
    data_=data(1:size(data,1)-1,:);
    Scema(chosenTableRow)=[];
elseif chosenTableRow==1
    data_=data(2:size(data,1),:);
    Scema= Scema(2:length(Scema));
else
    data_=[data(1:chosenTableRow-1,:);data(chosenTableRow+1:size(data,1),:) ];
    Scema=[Scema(1:chosenTableRow-1) Scema(chosenTableRow+1:length(Scema))];
end
    set(Table,'Data',data_);
%     Scema{chosenTableRow}='Empty';
    chosenTableRow=chosenTableRow-1;
end

function editSequenseCallbacfnc(hObject, eventdata, handles)
% Callback
end
function useSequenseCallbacfnc(hObject, eventdata, handles)
% Callback
end

function elementTypeCB(src, eventdata)%%src-table// eventdata

global Scema
global chosenTableRow ;
chosenTableRow = eventdata.Indices(1);

    if  eventdata.Indices(2) == 1               % check if column 2
        if    strcmp(eventdata.NewData,'Surface')
              set(src,'ColumnEditable', [true, true, true, true, false]);
              assignTableElementDescription(src, eventdata.Indices(1), [{'Surface'} {'0 0 0'} {'0 0 0'} {'10 10'} {'Edit'}]);
              Scema{eventdata.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
             
        elseif strcmp(eventdata.NewData,'Mirror')
               set(src,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(src, eventdata.Indices(1), [{'Mirror'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}])
               Scema{eventdata.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{eventdata.Indices(1)}.extraDataType = strcat(Scema{eventdata.Indices(1)}.extraDataType,'_mirror') ;
              
        elseif strcmp(eventdata.NewData,'TransparentDG')
               set(src,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(src, eventdata.Indices(1), [{'TransparentDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]);
               Scema{eventdata.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{eventdata.Indices(1)}=convertQuad2DG( Scema{eventdata.Indices(1)},0.032, 1, 0, 10^10);
             
        elseif strcmp(eventdata.NewData,'ReflectiveDG')
               set(src,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(src, eventdata.Indices(1), [{'ReflectiveDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]);
               Scema{eventdata.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{eventdata.Indices(1)}=convertQuad2DG( Scema{eventdata.Indices(1)},0.032, 1, 0, 10^10);
             
        elseif strcmp(eventdata.NewData,'Lens')
               set(src,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(src, eventdata.Indices(1), [{'Lens'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]);
               Scema{eventdata.Indices(1)}= getLens( 10, 5, 20, -20,'silica');
             
        elseif strcmp(eventdata.NewData,'Empty')
               assignTableElementDescription(src, eventdata.Indices(1), [{'Empty'} {'-'} {'-'} {'-'} {'-'}]);
               set(src,'ColumnEditable', [true, false, false, false, false]);
               Scema{eventdata.Indices(1)}='Empty';
        end
    end
%     disp(Scema);
end

function assignTableElementDescription(tableHandle, row, description)
        data=get(tableHandle,'Data');
      
        if size(data,1)==0
             data = description;
             set(tableHandle,'Data',data);
        else
             data(row ,:) = description;
             set(tableHandle,'Data',data);    
        end
end

function pos=positionConvert(xyLH)
pos=[xyLH(1)-xyLH(3)/2 xyLH(2)-xyLH(4)/2 xyLH(1)+xyLH(3)/2 xyLH(2)+xyLH(4)/2];
end