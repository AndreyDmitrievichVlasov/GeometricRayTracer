function [ z ] = ConusEquation( x,y,A,B,C  )
%CONUSEQUATION Summary of this function goes here
%   Detailed explanation goes here
z = -C+sign(C)*abs(C)*sqrt( x.^2/A^2+y.^2/B^2);


end

