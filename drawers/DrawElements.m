function  DrawElements( fig_handler,Elements )
%DRAWELEMENTS Summary of this function goes here
%   Detailed explanation goes here

set(fig_handler,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
set(fig_handler,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman');

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
                  drawLens(fig_handler, Elements{i});
                  continue;
            elseif strcmp(Elements{i}.type,'surface')
                  drawQuad(fig_handler, Elements{i});
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

