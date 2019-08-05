function [ js ] = sphbes2m( nu, x)
%SPHBES2 Summary of this function goes here
%   Detailed explanation goes here

js = sqrt(pi./(2*x)) .* besseli(-nu - 0.5, x);

end

