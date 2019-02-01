function  DrawElements( Elements, varargin )
%DRAWELEMENTS Summary of this function goes here
%   Detailed explanation goes here

    if ~iscell(Elements)
        disp('Unknown data in lens drawer');
        return;
    end
    if isempty(Elements)
           disp('No lens to draw');
           return;
    end
    
    
    
    for i=1:length(Elements)
        if isempty(Elements{i})
          continue;
        end
        
        if sum((strcmp(fieldnames(Elements{i}),'type')) )~=0
           %% Lenses
            if strcmp(Elements{i}.type,'lens')
                  drawLens(Elements{i},varargin);
                  continue;
            elseif strcmp(Elements{i}.type,'surface')
                  drawQuad(Elements{i},varargin);
                  continue;
            else
                 disp('Element can be drawn');
                 continue;
            end
        else
             disp('Element can be drawn ')
        end
    end
end

