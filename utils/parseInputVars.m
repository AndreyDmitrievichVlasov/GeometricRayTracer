function [answer] = parseInputVars( paramName,varargin )
%PARSEINPUTVARS Summary of this function goes here
%   Detailed explanation goes here\answer
answer=[];
for i=1:length(varargin )-1
    if ischar(varargin {i})
        if strcmp(varargin {i},paramName)
             answer=varargin {i+1};
             return;
        end
    end
end

end

