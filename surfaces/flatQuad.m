function [ mirror] = flatQuad( H,L,e,r)
% H - height
% L - length
% e - [ angle_x angle_y angle_z]
% r - [x_0 y_0 z_0];
    xyz=[[-L/2 L/2   L/2 -L/2 -L/2];...
             [ H/2 H/2 -H/2 -H/2  H/2];...
             [ 0    0      0      0     0]];
    for i=1:5
        xyz(:,i)=getRotation(xyz(:,i),1,e/180*pi);
        xyz(:,i)=moveToPoint(xyz(:,i),r);
    end
    tangent=xyz(:,1)-xyz(:,2);tangent=tangent/norm(tangent);
    bitangent=xyz(:,4)-xyz(:,1);bitangent=bitangent/norm(bitangent);
    normal=cross(bitangent,tangent);normal=normal/norm(normal);
    TBN=[tangent bitangent normal];

   % apertureTypes, square, circular , circularRing, squareRing
    
    
    
    mirror=struct('XYZ',xyz,'ABCD',[normal' normal'*r'],'angles',e,'position',r,...
                  'L',L,'H',H,'aperureType',2,'apertureSettings',[L,H],'TextureHeight',@()(0),'invTBN',TBN^-1,...
                  'TBN',TBN,'TextureNormal',@()(normal'),...
                  'extraDataType','','extraData',[],'rotationMatrix',...
                  xRotMat(e(1)/180*pi)*yRotMat(e(2)/180*pi)*zRotMat(e(3)/180*pi)...
                  ,'type','surface');
end


