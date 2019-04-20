function [ w ] = W_func_distrebution( x,y, sigma, k, f  )
%W_FUNC_DISTREBUTION Summary of this function goes here
%   Detailed explanation goes here
[u,v]=meshgrid(x,y);
w=zeros(length(x),length(x));
for i=1:length(x)
    for j=1:length(y)
    w(i,j)=W_func( x(i), y(j), u, v, sigma, k, f );
    end
end

end

