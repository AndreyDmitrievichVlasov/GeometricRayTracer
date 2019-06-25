function [ w ] = W_func_distrebution( x, y,n,m, sigma, lam, f  )
%W_FUNC_DISTREBUTION Summary of this function goes here
%   Detailed explanation goes here
[u,v]=meshgrid(linspace(x(1),x(length(x)),n),linspace(y(1),y(length(y)),m));
w=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
        w(i,j) = W_func( x(i), y(j), u, v, sigma, lam, f );
    end
end

end

