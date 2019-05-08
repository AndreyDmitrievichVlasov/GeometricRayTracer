function [ mask ] = getGaussMask( x,y,sigma,phi )
%GETGAUSSMASK Summary of this function goes here
%   Detailed explanation goes here
[x,y]=meshgrid(x,y);

a=3*sigma;

b=a/cos(phi);

mask = (x.^2/a^2+y.^2/b^2)<1;

end

