function [ quad_ ] = convertQuad2Sphere(quad_,R)
%CONVERTQUAD2SPHERE Summary of this function goes here
%   Detailed explanation goes here
quad_.extraDataType=sphereType();
quality=64;

quad_.apertureData=getAperture(quad_.apertureType, quad_.apertureData,R,R);

apertureMesh = createMesh(quad_.apertureType, quad_.apertureData, R);

quad_.extraData=struct('surfaceMesh',apertureMesh,...
                                  'R',R,'A',R,'B',R,'C',R,'refractionIndex',1,'drawQuality',quality,...
                                   'surfaceMatrix',[[1/R^2 0     0      0];...
                                                         [0     1/R^2 0      0];...
                                                         [0     0     1/R^2  0];...
                                                         [0     0     0       -1];]);

end


function apertureMesh = createMesh(ApertureType, ApertureData, R)
multiplyer=[1 1];
    if 1 == ApertureType
        mesh = dlmread('rectAperture.app')';
        multiplyer=[ApertureData(1) ApertureData(2)];
           mesh =  CurvLinearInterp3D(mesh,10);      
    elseif 2 == ApertureType
        mesh = dlmread('circAperture.app')';
        
        multiplyer=[ApertureData(2) ApertureData(2)];
        
      
    end    
    
       
    
        apertureMesh=zeros(size(mesh));
        
        apertureMesh(1,:)=mesh(1,:);

        apertureMesh(2,:)=mesh(2,:);

        apertureMesh(3,:) =real( R-sign(R)*SphereEquation(apertureMesh(1,:)*multiplyer(1),apertureMesh(2,:)*multiplyer(2), R));
  
end

 







