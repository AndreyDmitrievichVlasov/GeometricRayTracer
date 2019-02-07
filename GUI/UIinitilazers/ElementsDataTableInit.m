function  ElementsDataTableInit( parent )
%ELEMENTSDATATABLEINIT Summary of this function goes here
%   Detailed explanation goes here

scrsize = get( groot, 'Screensize' );

% scrsizefloat(3:4)=[scrsize(3)/scrsize(4) 1];

Table = uitable('Parent', parent, 'Position', [10 10 410 scrsize(4)*0.79]);

set(Table,'ColumnFormat',{{'Surface','Mirror','TransparentDG','ReflectiveDG','Lens','Empty','SpotLight','PointLight','CustomLight','TestRay'}, [], [], [],[] })

set(Table,'ColumnWidth', {'auto', 'auto', 'auto', 'auto','auto'});

set(Table,'ColumnEditable', [true, false, false, false]);

set(Table,'ColumnName', {'Element type','Position','Rotation','Aperture','          '});

set(Table,'CellEditCallback',@(s,e)CellEditCallBack(s,e));

set(Table,'CellSelectionCallback',@(s,e)CellSelectionCallback(s,e));
GlobalSet('ElementsDataTable',Table);

end


function CellSelectionCallback(sender, event)

if numel(event.Indices)==0
    return
end
 GlobalSet('ActiveTableRow',event.Indices(1));
 col=ones(size(get(sender,'Data'),1),3);
 col(event.Indices(1),:)=[0.8 0.8 1];
 a=get(sender,'ColumnFormat')%ForegroundColor
%  set(sender,'BackgroundColor',col);

 %  set(sender,'BackgroundColor',[0.8 0.8 1;0.8 0.1 1]);
end
function CellEditCallBack(sender, event)%%src-table// eventdata
% global Scema;
% global chosenTableRow;
% GlobalSet('ActiveTableRow',1);
% GlobalSet('ElementsList',{});
% chosenTableRow =


   
 
     if  event.Indices(2) == 1               
        elementTypeAssign(sender,event);
           displayUpdate(1);
     end
     if  event.Indices(2) == 2               
        elementPositionAssign(sender,event);
           displayUpdate(1);
     end
     if  event.Indices(2) == 3               
        elementRotationAssign(sender,event);
           displayUpdate(1);
     end
     if  event.Indices(2) == 4              
        elementMaterialAssign(sender,event);
     end
% drawElementsFunction();     
end

function elementPositionAssign(sender,event)
    Scema = GlobalGet('ElementsList');
    
    data = get(sender,'Data');
    
    if  strcmp(event.PreviousData,data{event.Indices(1),event.Indices(2)})
        return;
    end
         data{event.Indices(1),event.Indices(2)}=event.NewData;
         set(sender,'Data',data);
         if strcmp( Scema{event.Indices(1)}.type,'lens')
             Scema{event.Indices(1)}=moveLens(Scema{event.Indices(1)},str2num(event.NewData));
         else
             Scema{event.Indices(1)}= moveQuad(Scema{event.Indices(1)},str2num(event.NewData));
         end
    GlobalSet('ElementsList',Scema);
end

function elementRotationAssign(sender,event)
  
    Scema = GlobalGet('ElementsList');
    
    data = get(sender,'Data');
    
    if  strcmp(event.PreviousData,data{event.Indices(1),event.Indices(2)})
         return;
    end
         data{event.Indices(1),event.Indices(2)}=event.NewData;
         set(sender,'Data',data);
         if strcmp( Scema{event.Indices(1)}.type,'lens')
             Scema{event.Indices(1)}= rotateLens(Scema{event.Indices(1)},str2num(event.NewData));
         else
             Scema{event.Indices(1)}= rotateQuad(Scema{event.Indices(1)},str2num(event.NewData));
         end
    GlobalSet('ElementsList',Scema);
end

function elementMaterialAssign(sender,event)
disp('material');
end

function elementTypeAssign(sender,event)
 Scema = GlobalGet('ElementsList');
      if  event.Indices(2) == 1               % check if column 2
        if    strcmp(event.NewData,'Surface')
              set(sender,'ColumnEditable', [true, true, true, true, false]);
              assignTableElementDescription(sender, event.Indices(1), [{'Surface'} {'0 0 0'} {'0 0 0'} {'10 10'} {'Edit'}]);
              Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
             
        elseif strcmp(event.NewData,'Mirror')
               set(sender,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(sender, event.Indices(1), [{'Mirror'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}])
               Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{event.Indices(1)}.extraDataType = strcat(Scema{event.Indices(1)}.extraDataType,'_mirror') ;
              
        elseif strcmp(event.NewData,'TransparentDG')
               set(sender,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(sender, event.Indices(1), [{'TransparentDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]);
               Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{event.Indices(1)}=convertQuad2DG( Scema{event.Indices(1)},0.032, 1, 0, 10^10);
             
        elseif strcmp(event.NewData,'ReflectiveDG')
               set(sender,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(sender, event.Indices(1), [{'ReflectiveDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]);
               Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{event.Indices(1)}=convertQuad2DG( Scema{event.Indices(1)},0.032, 1, 0, 10^10);
             
        elseif strcmp(event.NewData,'Lens')
               set(sender,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(sender, event.Indices(1), [{'Lens'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]);
               Scema{event.Indices(1)}= getLens( 10, 5, 50, -50,'silica');
             
        elseif strcmp(event.NewData,'Empty')
               assignTableElementDescription(sender, event.Indices(1), [{'Empty'} {'-'} {'-'} {'-'} {'-'}]);
               set(sender,'ColumnEditable', [true, false, false, false, false]);
               Scema{event.Indices(1)}='Empty';
        end
        GlobalSet('ElementsList',Scema);
   end
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