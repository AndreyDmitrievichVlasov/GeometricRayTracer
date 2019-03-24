function isChecked = checkInputVars( varargin )
%CHECKINPUTVARS Summary of this function goes here
%   Detailed explanation goes here
if mod(length(varargin),2)==0
    isChecked=true;
else
    isChecked=false;
end

end

