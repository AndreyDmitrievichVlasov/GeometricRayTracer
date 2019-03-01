function  ElementsDataTableInit( parent )
%ELEMENTSDATATABLEINIT Summary of this function goes here
%   Detailed explanation goes here

scrsize = get( groot, 'Screensize' );

Table = uitable('Parent', parent, 'Position', [10 10 410 scrsize(4)*0.79]);

headers = {'Element type', ...
               '<html><center>Position<br /></center></html>', ...
               '<html><center>Rotation<br /></center></html>', ...
               '<html><center>Material<br /></center></html>', ...
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
vals= {'none','silica','SK16','F2','air'};       

Materials={   '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> none </TD></TR> </table></HTML>',...
              '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> silica </TD></TR> </table></HTML>',...
              '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> SK16 </TD></TR> </table></HTML>',...
              '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> F2 </TD></TR> </table></HTML>',...
              '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> air </TD></TR> </table></HTML>',
          };
            
GlobalSet('GlassLibKeys',containers.Map(Materials,vals));
InitMaterials();

GlobalSet('ElementsTypes',ElementsTypes);

set(Table,'ColumnFormat',{[], [], [], [],[] })

% set(Table,'ColumnFormat',{{'Surface','Mirror','TransparentDG','ReflectiveDG','Lens','Empty','SpotLight','PointLight','CustomLight','TestRay'}, [], [], [],[] })

set(Table,'ColumnWidth', {'auto', 'auto', 'auto', 'auto','auto'});

set(Table,'ColumnEditable', [false, false, false, false]);


% set(Table,'CellEditCallback',@(s,e)CellEditCallBack(s,e));

set(Table,'CellSelectionCallback',@(s,e)CellSelectionCallback(s,e));

% set(Table,'KeyPressFcn',@(s,e)ButtonDownFcn(s,e))

GlobalSet('ElementsDataTable',Table);


% get(Table)
% set(Table,'BackgroundColor',[0.8 0.8 1]);

% uitable('Data',{'<HTML><table border=0 width=400 bgcolor=#FF0000><TR><TD>Hello</TD></TR> </table></HTML>' })
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


 
