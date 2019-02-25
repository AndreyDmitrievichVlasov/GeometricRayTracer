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

ElementsTypes={'<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Surface </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Mirror </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> TransparentDG </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> ReflectiveDG </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Lens </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Empty </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> SpotLight </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> PointLight </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> CustomLight </TD></TR> </table></HTML>',...
                        '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> TestRay </TD></TR> </table></HTML>'...
                        };
GlobalSet('ElementsTypes',ElementsTypes);

set(Table,'ColumnFormat',{ElementsTypes, [], [], [],[] })

% set(Table,'ColumnFormat',{{'Surface','Mirror','TransparentDG','ReflectiveDG','Lens','Empty','SpotLight','PointLight','CustomLight','TestRay'}, [], [], [],[] })

set(Table,'ColumnWidth', {'auto', 'auto', 'auto', 'auto','auto'});

set(Table,'ColumnEditable', [true, false, false, false]);


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
   
    if ~strcmp(data{event.Indices(1),1}(58:62),'Empty')
        if event.Indices(2)==2
          ElementFieldEditForm('Position');
        end
    end    

    set(sender,'Data',data);
end

function CellEditCallBack(sender, event)%%src-table// eventdata
% global Scema;
% global chosenTableRow;
% GlobalSet('ActiveTableRow',1);
% GlobalSet('ElementsList',{});
% chosenTableRow =

if numel(event.Indices)==0
    return
end
     if    event.Indices(2) == 1               
           elementTypeAssign(sender,event);
           displayUpdate(1);
     end
     
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

function elementTypeAssign(sender,event)
 Scema = GlobalGet('ElementsList');
 ElementsTypes=GlobalGet('ElementsTypes');
%  description=
      if  event.Indices(2) == 1               % check if column 2
        if    strcmp(event.NewData,ElementsTypes{1})
              set(sender,'ColumnEditable', [true, false, false, false, false]);
              assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'Surface'} {'0 0 0'} {'0 0 0'} {'10 10'} {'Edit'}]));
              Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
             
        elseif strcmp(event.NewData,ElementsTypes{2})
               set(sender,'ColumnEditable', [true, false, false, false, false]);
               assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'Mirror'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]))
               Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{event.Indices(1)}.extraDataType = strcat(Scema{event.Indices(1)}.extraDataType,'_mirror') ;
              
        elseif strcmp(event.NewData,ElementsTypes{3})
               set(sender,'ColumnEditable', [true, true, true, true, false]);
               assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'TransparentDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]));
               Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{event.Indices(1)}=convertQuad2DG( Scema{event.Indices(1)},0.032, 1, 0, 10^10);
             
        elseif strcmp(event.NewData,ElementsTypes{4})
               set(sender,'ColumnEditable', [true, false, false, false, false]);
               assignTableElementDescription(sender, event.Indices(1), tableRowAsHTML([{'ReflectiveDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]));
               Scema{event.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{event.Indices(1)}=convertQuad2DG( Scema{event.Indices(1)},0.032, 1, 0, 10^10);
             
        elseif strcmp(event.NewData,ElementsTypes{5})
               set(sender,'ColumnEditable', [true, false, false, false, false]);
               assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'Lens'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}]));
               Scema{event.Indices(1)}= getLens( 10, 5, 50, -50,'silica');
             
        elseif strcmp(event.NewData,ElementsTypes{6})
               assignTableElementDescription(sender, event.Indices(1),tableRowAsHTML( [{'Empty'} {'-'} {'-'} {'-'} {'-'}]));
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



function ElementFieldEditForm(fieldName)


s_size=GlobalGet('Screensize');
L=300;
padding=10;
fig_handler=figure('Units', 'pixels', 'pos',[s_size(3)/2-150 s_size(4)/2-50 L 100],'MenuBar','None','NumberTitle','Off');
set(fig_handler,'Name',fieldName);
pannel_handler = uipanel(fig_handler,'Title','Element XYZ coordinates', 'Position',[0.005 0.005 0.99 0.99]);
aspect=0.6;

text_plus_label=L/3-padding;

text_length   = 0.6*text_plus_label;

label_length = (1-0.6)*text_plus_label;

EL=GlobalGet('ElementsList');
EL=EL{GlobalGet('ActiveTableRow')};


textFieldLabelX = uicontrol('parent', pannel_handler ,'pos',[1                  40 label_length 30],'String', 'X, [mm]:','style','text');
textFieldX        = uicontrol('parent', pannel_handler ,'pos',[1+label_length    40 text_length 30],'style','edit','String',num2str(EL.position(1)));


textFieldLabelY = uicontrol('parent', pannel_handler ,'pos',[1+label_length + text_length+padding 40 label_length 30],'String', 'Y, [mm]:','style','text');
textFieldY         = uicontrol('parent', pannel_handler ,'pos',       [1+2*label_length + text_length+padding     40 text_length 30],'style','edit','String',num2str(EL.position(2)));


textFieldLabelZ = uicontrol('parent', pannel_handler ,'pos',[1+2*(label_length + text_length+padding) 40 label_length 30],'String', 'Z, [mm]:','style','text');
textFieldZ        = uicontrol('parent', pannel_handler ,'pos',       [1+2*(label_length + text_length+padding)+label_length 40 text_length 30],'style','edit','String',num2str(EL.position(3)));

acceptButton  = uicontrol('parent', pannel_handler ,'pos',[0  0 295 30],'String', 'Accept element shift','style','pushbutton');

end


