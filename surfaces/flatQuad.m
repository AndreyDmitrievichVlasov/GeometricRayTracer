function [ mirror] = flatQuad(aperture,apertureType,e,r)
% H - height
% L - length
% e - [ angle_x angle_y angle_z]
% r - [x_0 y_0 z_0];

% aperture=[L H delta] - Rectangular
% aperture=[Rmin Rmax delta] - Circular
if apertureType==1
    xyz = initRectAperture(aperture,e,r);
elseif apertureType==2
    xyz = initCircAperture(aperture,e,r);
else
    xyz = initRectAperture(aperture,e,r);
end

               

    tangent=xyz(:,1)-xyz(:,2);tangent=tangent/norm(tangent);
    bitangent=xyz(:,4)-xyz(:,1);bitangent=bitangent/norm(bitangent);
    normal=cross(bitangent,tangent);normal=normal/norm(normal);
    TBN=[tangent bitangent normal];

    mirror=struct('XYZ',xyz,'ABCD',[normal' normal'*r'],'angles',e,'position',r,...
                  'ApertureType',apertureType,'ApertureData',aperture,'TextureHeight',@()(0),'invTBN',TBN^-1,...
                  'TBN',TBN,'TextureNormal',@()(normal'),...
                  'extraDataType','','extraData',[],'rotationMatrix',...
                  xRotMat(e(1)/180*pi)*yRotMat(e(2)/180*pi)*zRotMat(e(3)/180*pi)...
                  ,'type','surface');
end

function xyz = initRectAperture(aperture,e,r)
     H = aperture(1);
     L = aperture(2);
     d = aperture(3);
         xyz=[[-L/2 L/2   L/2 -L/2 -L/2];...
                  [ H/2 H/2 -H/2 -H/2  H/2];...
                  [ 0    0      0      0     0]];
        if d~=0
        xyz_=[[-L/2+d L/2-d   L/2-d -L/2+d -L/2+d];...
                 [ H/2- H/2-d -H/2+d -H/2+d  H/2-d];...
                 [ 0    0      0      0     0]];
        xyz=[xyz_ xyz];
        end
    for i=1:length(xyz,2);
        xyz(:,i)=getRotation(xyz(:,i),1,e/180*pi);
        xyz(:,i)=moveToPoint(xyz(:,i),r);
    end
end


function initCircAperture(aperture,e,r)

end
