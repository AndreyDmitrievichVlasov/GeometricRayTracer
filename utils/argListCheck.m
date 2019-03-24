function  argListCheck(varargin)
%ARGLISTCHECK Summary of this function goes here
%   Detailed explanation goes here
if  ~checkInputVars( varargin{:} )
    disp('incorrect input list');
    return;
end
disp(parseInputVars(  'one', varargin{:} ));
disp( parseInputVars( 'two', varargin{:})); 
 disp(parseInputVars( 'three', varargin{:}));
 disp(parseInputVars( 'four1', varargin{:}));
end

