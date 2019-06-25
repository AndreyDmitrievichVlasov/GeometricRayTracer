function [k,b ] = getFuncFromPoints( p1,p2 )
%GETFUNCFROMPOINTS Summary of this function goes here
%   Detailed explanation goes here

m=[[p1(1) 1];...
      [p2(1) 1]];
[kb]=inv(m)*[p1(2); p2(2)];

k=kb(1);
b=kb(2);
end

