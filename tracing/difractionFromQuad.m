function [ rays_out ,rays_difracted] = difractionFromQuad( quad_,rays )
%DIFRACTIONFROMQUAD Summary of this function goes here
%   Detailed explanation goes here
tangent    =  [-1 0 0];
bi_tangent = [0 -1 0];
normal     =  [0 0 -1];
% предполагаетс€, что нормаль к решЄте всегда совпадает с осью Z в
% собственно пространстве решЄтки
if strcmp(quad_.extraDataType,'faltDG')
    error('this surface can not be represented as DG');
end

 [ rays_out] = quadIntersect( quad_, rays);


rays_difracted  = zeros(size(rays));
%перевод направлени€ лучей из собственной системы координат в 
% систему координат дифракционной решЄтки
ray_dir_dg_space = matrixMultByArrayOfVectors( quad_.TBN,rays(:,4:6));
 
difraction_angle =    quad_.extraData.orders*rays(:,9)/quad_.extraData.density...
                               -sqrt(1 - ray_dir_dg_space(:,3).^2);
 
    
rho=sqrt(rays(:,4).^2+rays(:,6).^2);
% 
%     ray_(:,3) =  -sqrt(1-difraction_angle(1).^2);%проверить знаки
%     ray_(:,1) =   sign(quad_.extraData.orders)*sqrt(1-ray_(:,3).^2-ray_(:,2).^2);%доху€ неправильно
% %     ray_1-ray_
%     ray_(:,1) = quad_.invTBN(1,1)*ray_(:,1)+quad_.invTBN(1,2)*ray_(:,2)+quad_.invTBN(1,3)*ray_(:,3);
%     ray_(:,2) = quad_.invTBN(2,1)*ray_(:,1)+quad_.invTBN(2,2)*ray_(:,2)+quad_.invTBN(2,3)*ray_(:,3);
%     ray_(:,3) = quad_.invTBN(3,1)*ray_(:,1)+quad_.invTBN(3,2)*ray_(:,2)+quad_.invTBN(3,3)*ray_(:,3);
%  
 
    %     1    2    3    4     5    6        7     8                     9             10  11 12 13
    % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY, R, G, B]

    rays_difracted(:,1)= rays(:,1)+rays(:,4).*(rays(:,8)-rays(:,7)+quad_.TextureHeight());
    rays_difracted(:,2)= rays(:,2)+rays(:,5).*(rays(:,8)-rays(:,7)+quad_.TextureHeight());
    rays_difracted(:,3)= rays(:,3)+rays(:,6).*(rays(:,8)-rays(:,7)+quad_.TextureHeight());
    rays_difracted(:,4)=rho.*difraction_angle;
    rays_difracted(:,5)=rays(:,5);
    rays_difracted(:,6)=rho.*sqrt(1-difraction_angle.^2);
    rays_difracted(:,8)=1;
    rays_difracted(:,9:13)=rays(:,9:13);
%    
%     rays_out=[rays_out struct('r0',rays(i).r0+rays(i).e*(rays(i).tEnd+quad_.TextureHeight()),'e',...
%                                  ray_,'tStart',0,'tEnd',1.0,'lam',rays(i).lam,'wieght',...
%                                  rays(i).wieght,'color',rays(i).color*0.9,'internal',0)];
end

function vects = matrixMultByArrayOfVectors(mat,vectorsArray)
    vects=zeros(size(vectorsArray));
    vects(:,1) = mat(1,1)*vectorsArray(:,1)+mat(1,2)*vectorsArray(:,2)+mat(1,3)*vectorsArray(:,3);
    vects(:,2) = mat(2,1)*vectorsArray(:,1)+mat(2,2)*vectorsArray(:,2)+mat(2,3)*vectorsArray(:,3);
    vects(:,3) = mat(3,1)*vectorsArray(:,1)+mat(3,2)*vectorsArray(:,2)+mat(3,3)*vectorsArray(:,3);
end
