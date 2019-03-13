function [ quad_ ] = convertQuad2Ellipsoid( quad_,A,B,C)
%CONVERTQUAD2ELLIPSOID Summary of this function goes here
%   Detailed explanation goes here
quad_.extraDataType=ellipsoidType();

quad_.apertureData=getAperture(quad_.apertureType, quad_.apertureData,A,B);

apertureMesh = createMesh(quad_.apertureType, quad_.apertureData, A,B,C);



quad_.extraData=struct('surfaceMesh',apertureMesh,...
                        'A',A,'B',B,'C',C,'refractionIndex',1,...
                        'surfaceMatrix',[[1/A^2 0     0      0];...
                                              [0     1/B^2 0      0];...
                                              [0     0     1/C^2  0];...
                                              [0     0     0     -1]]);
end


% function apertureMesh = createMesh(ApertureType, ApertureData, A,B,C)
% 
%     if 1 == ApertureType
%         mesh = GlobalGet('RectangularApertureMesh');
%         multiplyer=[ApertureData(1) ApertureData(2)];
%            mesh =  CurvLinearInterp3D(mesh,10);      
%     elseif 2 == ApertureType
%         mesh = GlobalGet('CircularApertureMesh');
%         multiplyer=[ApertureData(2) ApertureData(2)];
%     end    
%     
%        
%     
%         apertureMesh=zeros(size(mesh));
%         
%         apertureMesh(1,:)=mesh(1,:)*multiplyer(1);
% 
%         apertureMesh(2,:)=mesh(2,:)*multiplyer(2);
% 
%         apertureMesh(3,:) =EllipseEquation(apertureMesh(1,:),apertureMesh(2,:),A,B,C);
%   
% end
