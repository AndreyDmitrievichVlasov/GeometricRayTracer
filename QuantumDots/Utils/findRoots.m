function [ f_roots ] = findRoots( func_handler,interval,steps)
%FINDROOTS Summary of this function goes here
%   Detailed explanation goes here
f_roots=[];
% diveriative=@(x_0)((func_handler(x_0+10^-6)-func_handler(x_0-10^-6))/2/10^-6);

t = linspace(0,1,steps)*(interval(2)-interval(1))+interval(1);

    for i=1:length(t)-1

        f_l=func_handler(t(i));

        f_r=func_handler(t(i+1));

        if f_l*f_r<0
           f_roots=[f_roots lerpZero([t(i) f_l],[t(i+1) f_r])];
        end
    end
end
function t = lerpZero(p1,p2)
m= 1/(p1(1)-p2(1))*[[1 -1];...
      [-p2(1) p1(1)]];
kb=m*[p1(2);p2(2)];
t=-kb(2)/kb(1);
end
