function  ElementsDataTableInit( parent )
%ELEMENTSDATATABLEINIT Summary of this function goes here
%   Detailed explanation goes here

scrsize = get( groot, 'Screensize' );

Table = uitable('Parent', parent, 'Position', [10 10 410 scrsize(4)*0.79]);

headers = {'Element type', ...
               '<html><center>Position<br /></center></html>', ...
               '<html><center>Rotation<br /></center></html>', ...
               '<html><center>Aperture<br /></center></html>', ...
               '<html><center>Edit<br /></center></html>'};

% headers = {'Element type','Position','Rotation','Aperture','Edit'};
       
% The color changing solution below
       
% uitable('Data',{'<HTML><table border=0 width=400 bgcolor=#FF0000><TR><TD>Hello</TD></TR> </table></HTML>' })
       
       
set(Table,'ColumnName', headers);


% '<HTML><table border=0 width=400 bgcolor=#FF0000><TR><TD> 1 </TD></TR> </table></HTML>'

ElementsTypes={'<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> Surface </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> Mirror </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> TransparentDG </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> ReflectiveDG </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> Lens </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> Empty </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> SpotLight </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> PointLight </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> CustomLight </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> TestRay </TD></TR> </table></HTML>'...
               };
GlobalSet('ElementsTypes',ElementsTypes);

set(Table,'ColumnFormat',{[], [], [], [],[] })

% set(Table,'ColumnFormat',{{'Surface','Mirror','TransparentDG','ReflectiveDG','Lens','Empty','SpotLight','PointLight','CustomLight','TestRay'}, [], [], [],[] })

set(Table,'ColumnWidth', {'auto', 'auto', 'auto', 'auto','auto'});

set(Table,'ColumnEditable', [false, false, false, false]);


set(Table,'CellEditCallback',@(s,e)CellEditCallBack(s,e));

set(Table,'CellSelectionCallback',@(s,e)CellSelectionCallback(s,e));

set(Table,'KeyPressFcn',@(s,e)ButtonDownFcn(s,e))

GlobalSet('ElementsDataTable',Table);


% get(Table)
% set(Table,'BackgroundColor',[0.8 0.8 1]);

% uitable('Data',{'<HTML><table border=0 width=400 bgcolor=#FF0000><TR><TD>Hello</TD></TR> </table></HTML>' })
end


function ButtonDownFcn(sender, event)
% disp('button was pressed')
end


function CellSelectionCallback(sender, event)

if numel(event.Indices)==0
    return
end

data = get(sender,'Data');
ActiveTableRow=GlobalGet('ActiveTableRow');

   for i=1:5
            element=data{ActiveTableRow,i};
            k = strfind(element,'#');
            element(k:k+6)='#CCECFE';
            data{ActiveTableRow,i}=element;
        
            element=data{event.Indices(1),i};
            k = strfind(element,'#');
            element(k:k+6)='#FFEA19';
            data{event.Indices(1),i}=element;
            
   end
    GlobalSet('ActiveTableRow',event.Indices(1)); 
    ElementFieldEditForm(event.Indices(2));
    set(sender,'Data',data);
end

function CellEditCallBack(sender, event)%%src-table// eventdata
% global Scema;
% global chosenTableRow;
% GlobalSet('ActiveTableRow',1);
% GlobalSet('ElementsList',{});
% chosenTableRow =

% if numel(event.Indices)==0
%     return
% end
%      if    event.Indices(2) == 1               
%            elementTypeAssign(sender,event);
%            displayUpdate(1);
%      end
%      
%      if  event.Indices(2) == 2
%          elementPositionAssign(sender,event);
%          displayUpdate(1);
%      end
%      if  event.Indices(2) == 3               
%         elementRotationAssign(sender,event);
%            displayUpdate(1);
%      end
%      if  event.Indices(2) == 4              
%         elementMaterialAssign(sender,event);
%      end
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

% function elementTypeAssign(sender,event)
%  Scema = GlobalGet('ElementsList');
%  ElementsTypes=GlobalGet('ElementsTypes');
% %  description=
%       if  event.Indices(2) == 1               % check if column 2
%         if    strcmp(event.NewData,ElementsTypes{1})
%               assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'Surface'} {'0 0 0'} {'0 0 0'} {'10 10'} {'Edit'}]));
%               Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
%              
%         elseif strcmp(event.NewData,ElementsTypes{2})
%                assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'Mirror'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]))
%                Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
%                Scema{event.Indices(1)}.extraDataType = strcat(Scema{event.Indices(1)}.extraDataType,'_mirror') ;
%               
%         elseif strcmp(event.NewData,ElementsTypes{3})
%                assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'TransparentDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]));
%                Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
%                Scema{event.Indices(1)}=convertQuad2DG( Scema{event.Indices(1)},0.032, 1, 0, 10^10);
%              
%         elseif strcmp(event.NewData,ElementsTypes{4})
%                assignTableElementDescription(sender, event.Indices(1), tableRowAsHTML([{'ReflectiveDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]));
%                Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
%                Scema{event.Indices(1)}=convertQuad2DG( Scema{event.Indices(1)},0.032, 1, 0, 10^10);
%              
%         elseif strcmp(event.NewData,ElementsTypes{5})
%                assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'Lens'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]));
%                Scema{event.Indices(1)}= getLens( 10, 5, 50, -50,'silica');
%              
%         elseif strcmp(event.NewData,ElementsTypes{6})
%                assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'Empty'} {'-'} {'-'} {'-'} {'-'}]));
%                Scema{event.Indices(1)}='Empty';
%         end
%         GlobalSet('ElementsList',Scema);
%    end
% end


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
