function [ z ] = Phi(x,y,f,lam)
%PHI Summary of this function goes here
%   Detailed explanation goes here\

if (size(x,1)==1)||(size(x,2)==1)

[x,y]=meshgrid(x,y);
    
end
    
k=2*pi/lam;

z=-k*sqrt(x.^2 + y.^2 + f^2);

end

