function [ f_roots ] = findRoots( func_handler,varargin)
%FINDROOTS Summary of this function goes here
%   Detailed explanation goes here
f_roots=[];
% diveriative=@(x_0)((func_handler(x_0+10^-6)-func_handler(x_0-10^-6))/2/10^-6);
% n_roots=0;
% if isempty(varargin)
%     t =linspace(0,10,1000);
% end
% 
% if length(varargin)==1
%     if length(varargin{1})==1
%         n_roots = varargin{1};
%     else
%         t = varargin{1};
%     end
% end


accyracy = getValueByKey(varargin,{'Accuracy','accuracy','acc'});
if isempty(accyracy)
    accyracy = 100;
end;
rootsNumber = getValueByKey(varargin,{'rootsNumber','N','n'});
if isempty(rootsNumber)
    rootsNumber = 0;
end;
Interval = getValueByKey(varargin,{'Interval', 'interavl'});
if isempty(Interval)
    Interval = [0 1];
else
    rootsNumber=[];
end;

if isempty(rootsNumber)
        f_roots = searchRootsInInterval(func_handler, Interval(1),Interval(2),accyracy);
else
        f_roots=searchRootsIterated(func_handler,rootsNumber,accyracy);
end

    
end

function roots = searchRootsInInterval(func_handler, t_1,t_2,acc)
     
     roots=[];
     t = linspace(t_1,t_2,acc);%*(t_2-t_1)+t_1;
     for i=1:length(t)-1

        f_l=func_handler(t(i));

        f_r=func_handler(t(i+1));

        if f_l*f_r<0
           roots=[roots lerpZero([t(i) f_l],[t(i+1) f_r])];
        end
    end

end

function roots = searchRootsIterated(func_handler,roots_number,acc)
    
    t=0;
    step =1;
    roots=[];
    while(length(roots)<=roots_number)
       roots = [roots  searchRootsInInterval(func_handler, t,t + step,acc)];
       t=t+step;
    end
    roots=roots(1:roots_number);
end


function t = lerpZero(p1,p2)
m= 1/(p1(1)-p2(1))*[[1 -1];...
      [-p2(1) p1(1)]];
kb=m*[p1(2);p2(2)];
t=-kb(2)/kb(1);
end


function val = getValueByKey(params,key)
    val=[];
    for i=1:2:length(params)
        for n=1:length(key)
            if strcmp(key{n},params{i})
                 val=params{i+1};
                return;  
            end
        end
    end
end

