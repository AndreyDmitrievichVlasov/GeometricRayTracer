function [ rays_out ] = difractionFromQuad( quad_,rays)
%DIFRACTIONFROMQUAD Summary of this function goes here
%   Detailed explanation goes here
tangent    = [-1 0 0];
bi_tangent = [0 -1 0];
normal     = [0 0 -1];

if strcmp(quad_.extraDataType,'faltDG')
    error('this surface can not be represented as DG');
end
if isstruct(rays)
    rays_out=[];
    for i=1: length(rays)
       ray_=(quad_.TBN*rays(i).e')';
       ray_projection=ray_+(ray_*bi_tangent')*bi_tangent;
       
       difraction_angle=quad_.extraData.orders*rays(i).lam/quad_.extraData.density...
                            +sqrt(ray_(1).^2+ray_(2).^2)./sqrt(ray_(1).^2+ray_(3).^2);
                        
%        difraction_angle=quad_.extraData.orders*rays(i).lam/quad_.extraData.density*norm(ray_projection)...
%                         +norm(cross(tangent,ray_projection));
       ray_(3) =  -sqrt(1-difraction_angle^2);%проверить знаки
       ray_(1) =   sign(quad_.extraData.orders)*sqrt(1-ray_(3).^2-ray_(2).^2);%доху€ неправильно
%        ray_= [-sqrt(1-difraction_angle^2) ray_(2) -difraction_angle];% 3?
       ray_= (quad_.invTBN*ray_')';
       rays_out=[rays_out struct('r0',rays(i).r0+rays(i).e*(rays(i).tEnd+quad_.TextureHeight()),'e',...
                                 ray_,'tStart',0,'tEnd',1.0,'lam',rays(i).lam,'wieght',...
                                 rays(i).wieght,'color',rays(i).color*0.9,'internal',0)];
    end
else
    rays_out  = zeros(size(rays));
    ray_      = zeros(length(rays),3);  
    ray_(:,1) = quad_.TBN(1,1)*rays(:,4)+quad_.TBN(1,2)*rays(:,5)+quad_.TBN(1,3)*rays(:,6);
    ray_(:,2) = quad_.TBN(2,1)*rays(:,4)+quad_.TBN(2,2)*rays(:,5)+quad_.TBN(2,3)*rays(:,6);
    ray_(:,3) = quad_.TBN(3,1)*rays(:,4)+quad_.TBN(3,2)*rays(:,5)+quad_.TBN(3,3)*rays(:,6);
    ray_1=ray_;
%     -0.0123   -0.0019   -0.9999
%    -0.0123   -0.0026   -0.9999
%    -0.0123   -0.0034   -0.9999
%    -0.0123   -0.0041   -0.9999
%     ray_projection=ray_;
%     ray_projection(:,2)=ray_(:,2)-ray_(:,2);
%     ray_projection=ray_+(ray_*bi_tangent')*bi_tangent;
    difraction_angle=quad_.extraData.orders*rays(:,9)/quad_.extraData.density...
                            +sqrt(ray_(:,1).^2+ray_(:,2).^2)./sqrt(ray_(:,1).^2+ray_(:,3).^2);
    


    ray_(:,3) =  -sqrt(1-difraction_angle.^2);%проверить знаки
    ray_(:,1) =   sign(quad_.extraData.orders)*sqrt(1-ray_(:,3).^2-ray_(:,2).^2);%доху€ неправильно
%     ray_1-ray_
    ray_(:,1) = quad_.invTBN(1,1)*ray_(:,1)+quad_.invTBN(1,2)*ray_(:,2)+quad_.invTBN(1,3)*ray_(:,3);
    ray_(:,2) = quad_.invTBN(2,1)*ray_(:,1)+quad_.invTBN(2,2)*ray_(:,2)+quad_.invTBN(2,3)*ray_(:,3);
    ray_(:,3) = quad_.invTBN(3,1)*ray_(:,1)+quad_.invTBN(3,2)*ray_(:,2)+quad_.invTBN(3,3)*ray_(:,3);
 
 
    %    1   2   3   4   5   6     7   8           9         10  11 12 13
    % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY, R, G, B]

    rays_out(:,1)= rays(:,1)+rays(:,4).*(rays(:,8)-rays(:,7)+quad_.TextureHeight());
    rays_out(:,2)= rays(:,2)+rays(:,5).*(rays(:,8)-rays(:,7)+quad_.TextureHeight());
    rays_out(:,3)= rays(:,3)+rays(:,6).*(rays(:,8)-rays(:,7)+quad_.TextureHeight());
    rays_out(:,4:6)=ray_;
    rays_out(:,8)=1;
    rays_out(:,9:13)=rays(:,9:13);
%    
%     rays_out=[rays_out struct('r0',rays(i).r0+rays(i).e*(rays(i).tEnd+quad_.TextureHeight()),'e',...
%                                  ray_,'tStart',0,'tEnd',1.0,'lam',rays(i).lam,'wieght',...
%                                  rays(i).wieght,'color',rays(i).color*0.9,'internal',0)];
end

end

