function [ quad_ ] = convertQuad2Conus( quad_,A,B,C )
%CONVERTQUAD2CONUS Summary of this function goes here
%   Detailed explanation goes here
quad_.extraDataType=conusType();
% quality=64;
% if quad_.L>2*A
% quad_.L=2*A;
% end
% if quad_.H>2*B
%     quad_.H=2*B;
% end
% 

quad_.apertureData=getAperture(quad_.apertureType, quad_.apertureData,A,B);

apertureMesh = createMesh(quad_.apertureType, quad_.apertureData, A,B,C,0);



if C==0
    quad_.extraData=struct('surfaceMesh',apertureMesh,...
                        'A',A,'B',B,'C',C,'aperture',[A B 0],'refractionIndex',1,...
                        'surfaceMatrix',[[1/A^2 0     0       0];...
                                             [0     1/B^2 0       0];...
                                             [0     0     1/C^2  0];...
                                             [0     0     0       -1]]);

else
    quad_.extraData=struct('surfaceMesh',apertureMesh,...
                        'A',A,'B',B,'C',C,'aperture',[A B 0],'refractionIndex',1,...
                        'surfaceMatrix',[[1/A^2 0     0       0];...
                                                 [0     1/B^2 0       0];...
                                                 [0     0     -1/C^2  0];...
                                                 [0     0     0       0]]);

end

end

