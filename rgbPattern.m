close all; clear all; clc
dim=256;

cmap = [[1 0 0];[0 1 0];[0 0 1]];

r=1*ones(dim,dim);
g=2*ones(dim,dim);
b=3*ones(dim,dim);
rgb_pattern = [[r g b];...
               [b r g];...
               [g b r]];
   
       N=10;M=10;    
           
picture = zeros(3*dim*N,3*dim*M);

for i=1:N
    for j=1:N
%       length((i-1)*dim+(1:dim))
%       length(  (j-1)*dim+(1:dim))
        picture((i-1)*dim*3+(1:dim*3),(j-1)*dim*3+(1:dim*3))=rgb_pattern;
    end
end

imwrite(picture,cmap,'coloredCheceker.png');