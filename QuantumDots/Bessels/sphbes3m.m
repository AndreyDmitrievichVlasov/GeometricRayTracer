function [ js ] = sphbes3m( nu,x )
%SPHBESMOD Summary of this function goes here
%   Detailed explanation goes here

js=(-1)^(nu+1)*pi/2*sqrt(pi./(2*x)).* (besseli(nu + 0.5, x) - besseli(-nu - 0.5, x));
% js=(-1)^(nu+1)*pi/2*(sphbes1(nu,x)-sphbes1(-nu,x));
end

