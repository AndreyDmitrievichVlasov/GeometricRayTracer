function [ z ] = SphereEquation( x, y, R )
%SPHEREEQUATION Summary of this function goes here
%   Detailed explanation goes here
z = sqrt(R^2 - x.^2-y.^2);

end

