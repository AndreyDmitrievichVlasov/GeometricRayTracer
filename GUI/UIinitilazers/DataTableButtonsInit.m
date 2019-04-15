function  DataTableButtonsInit( parent )
%DATATABLEBUTTONSINIT Summary of this function goes here
%   Detailed explanation goes here
scrsize = get( groot, 'Screensize' );
% scrsizefloat(3:4)=[scrsize(3)/scrsize(4) 1];
h=scrsize(4)*0.86;

saveButton =  uicontrol(parent,'Style','pushbutton','String','Save','Position',[20 h+20 133 20]);
set(saveButton,'Callback',@saveButtonCallBack);

saveAsButton =  uicontrol(parent,'Style','pushbutton','String','Save as','Position',[153.6 h+20 133 20]);
set(saveAsButton,'Callback',@saveAsButtonCallBack);

loadButton =  uicontrol(parent,'Style','pushbutton','String','Load','Position',[286.7 h+20 133 20]);
set(loadButton,'Callback',@loadButtonCallBack);

appendButton =  uicontrol(parent,'Style','pushbutton','String','Append element','Position',...
    ([20 h 200 20]));
set(appendButton,'Callback',@appendButtonCallBack);


removeButton = uicontrol(parent,'Style','pushbutton','String', 'Remove element','Position',...
    [220 h 200 20]);%removeButtonCallbacfnc
set(removeButton,'Callback',@removeButtonCallBack);

traceButton = uicontrol(parent,'Style','pushbutton','String', 'Trace!','Position',...
    [20 h-40 400 20]);

sequenseEditButton = uicontrol(parent,'Style','pushbutton','String', 'Edit Sequence','Position',...
    [20 h-20 200 20]);

sequenseUseButton = uicontrol(parent,'Style','togglebutton','String', 'Use Sequence','Position',...
    [220 h-20 200 20]);
% get(a);
end

function saveButtonCallBack(sender, event)

end

function saveAsButtonCallBack(sender, event)
 
end

function loadButtonCallBack(sender, event)
[fileName,path] = uigetfile('*.mat');
file=load([path fileName]);
GlobalSet('ElementsList',file.Elements);
GlobalSet('ElementsSequence', file.ElementsSequense);
GlobalSet('WorkspaceDirectory',path);
% запись данных в таблицу и ее обновление
for i=1:length(file.Elements)
    type = file.Elements{i}.type;
  
    if ~strcmp('lens',type)
        position=[num2str(file.Elements{i}.position(1)),' ',num2str(file.Elements{i}.position(2)),' ',num2str(file.Elements{i}.position(3))];
        orientation=[num2str(file.Elements{i}.angles(1)),' ',num2str(file.Elements{i}.angles(2)),' ',num2str(file.Elements{i}.angles(3))];
        material='none';
    else
        position=[num2str(file.Elements{i}.frontSurface.position(1)),' ',num2str(file.Elements{i}.frontSurface.position(2)),' ',num2str(file.Elements{i}.frontSurface.position(3))];
        orientation=[num2str(file.Elements{i}.frontSurface.angles(1)),' ',num2str(file.Elements{i}.frontSurface.angles(2)),' ',num2str(file.Elements{i}.frontSurface.angles(3))];
        material=file.Elements{i}.material.Desciption;
    end
       assignTableElementDescription(GlobalGet('ElementsDataTable'), i, tableRowAsHTML([{type} {position} {orientation} {material} {'Edit'}]));
end
 displayUpdate(1);
GlobalSet('ActiveTableRow',i);
end


function appendButtonCallBack(sender, event)
  
   l=length(GlobalGet('ElementsList'));
    if l==0
         assignTableElementDescription(GlobalGet('ElementsDataTable'), 1, tableRowAsHTML([{'Empty'} {'-'} {'-'} {'none'} {'-'}]));
         set(GlobalGet('ElementsDataTable'),'ColumnEditable', [false, false, false, false, false]);
         El=GlobalGet('ElementsList');
         El{l+1}='Empty';
         GlobalSet('ElementsList',El);
         GlobalSet('ActiveTableRow',1);
    else
         assignTableElementDescription(GlobalGet('ElementsDataTable'), l+1, tableRowAsHTML([{'Empty'} {'-'} {'-'} {'none'} {'-'}]));
         set(GlobalGet('ElementsDataTable'),'ColumnEditable', [false, false, false, false, false]);
         El=GlobalGet('ElementsList');
         El{l+1}='Empty';
         GlobalSet('ElementsList',El);
         GlobalSet('ActiveTableRow',l+1);
    end
    displayUpdate(1);
end

function removeButtonCallBack(sender, event)
Scema=GlobalGet('ElementsList');
Table=GlobalGet('ElementsDataTable');
chosenTableRow=GlobalGet('ActiveTableRow');

% size(Scema);

data=get(Table,'Data');

if isempty(data)
    displayUpdate(1);
    return;
end
if 1 == size(data,1)
    set(GlobalGet('ElementsDataTable'),'Data',[]);
    GlobalSet('ElementsList',{});
    displayUpdate(1)
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
    set(GlobalGet('ElementsDataTable'),'Data',data_);
    GlobalSet('ElementsList',Scema);
    GlobalSet('ActiveTableRow',chosenTableRow-1);
    
    displayUpdate(1);   
    
end

function editSequenseCallBack(sender, event)
% Callback
end

function useSequenseCallBack(sender, event)
% Callback
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
