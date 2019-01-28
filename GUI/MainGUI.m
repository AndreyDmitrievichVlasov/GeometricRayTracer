
function  MainGUI( )
%MAINGUI Summary of this function goes here
%   Detailed explanation goes here
close all; clc; clear all;

 Scema={};

% Scema{1} = flatQuad( 0.25,0.25,[0 0 0],[0.25 0 17]);



f = figure('Position', [10 10 900 250]);

t = uitable('Parent', f, 'Position', [25 50 830 200],'CellSelectionCallback', @(s,e)callback(e));

data = expandElementToCell(Scema);

t.ColumnFormat = {{'Surface','Mirror','TransparentDG','ReflectiveDG','Lens','Empty','SpotLight','PointLight','CustomLight','TestRay'} [], [], [],[] };

t.Data=data;

t.ColumnWidth = {'auto', 'auto', 'auto', 'auto','auto'};

t.ColumnEditable = [true, false, false, false];

t.ColumnName = {'Element type','Position','Rotation','Aperture','          '};

t.CellEditCallback = @(s,e)elementTypeCB(s,e);

 
get(f);
end


function data = expandElementToCell(element)
    if isempty(element)
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


function elementTypeCB(src, eventdata)%%src-table// eventdata

% disp(size(Scema))
    if  eventdata.Indices(1) == 1               % check if column 2
        if strcmp(eventdata.NewData,'Surface')
              src.ColumnEditable = [true, true, true, true, false];   
              src.Data(eventdata.Indices(1) ,:) = [{'Surface'} {'0 0 0'} {'0 0 0'} {'10 10'} {'Edit'}];
              Scema{eventdata.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
             
        elseif strcmp(eventdata.NewData,'Mirror')
             src.ColumnEditable = [true, true, true, true, false];
              src.Data(eventdata.Indices(1) ,:) = [{'Mirror'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}];
              Scema{eventdata.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
              Scema{eventdata.Indices(1)}.extraDataType = strcat(Scema{eventdata.Indices(1)}.extraDataType,'_mirror') ;
              
        elseif strcmp(eventdata.NewData,'TransparentDG')
             src.ColumnEditable = [true, true, true, true, false];
             src.Data(eventdata.Indices(1) ,:) = [{'TransparentDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}];
             Scema{eventdata.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
             Scema{eventdata.Indices(1)}=convertQuad2DG( Scema{eventdata.Indices(1)},0.032, 1, 0, 10^10);
             
        elseif strcmp(eventdata.NewData,'ReflectiveDG')
             src.ColumnEditable = [true, true, true, true, false];
             src.Data(eventdata.Indices(1) ,:) = [{'ReflectiveDG'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}];
             Scema{eventdata.Indices(1)}=flatQuad( 10,10,[0 0 0],[0 0 0]);
             Scema{eventdata.Indices(1)}=convertQuad2DG( Scema{eventdata.Indices(1)},0.032, 1, 0, 10^10);
             
        elseif strcmp(eventdata.NewData,'Lens')
             src.ColumnEditable = [true, true, true, true, false];
             src.Data(eventdata.Indices(1) ,:) = [{'Lens'} {'0 0 0'} {'0 0 0'} {'10'} {'Edit'}];
             Scema{eventdata.Indices(1)}= getLens( 10, 5, 20, -20,'silica');
             
        elseif strcmp(eventdata.NewData,'Empty')
	         src.Data(eventdata.Indices(1) ,:) = [{'Empty'} {'-'} {'-'} {'-'} {'-'}];
             src.ColumnEditable = [true, false, false, false, false];
             Scema{eventdata.Indices(1)}=[];
        end
    end
end