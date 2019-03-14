function [ quad_] = flatQuad(aperture,apertureType,e,r)
% H - height
% L - length
% e - [ angle_x angle_y angle_z]
% r - [x_0 y_0 z_0];

% aperture=[L H delta] - Rectangular
% aperture=[Rmin Rmax delta] - Circular
% But for circular the aperture(3) is not used at all!
if apertureType==1
    [xyz,TBN,aperture] = initRectAperture(aperture,e,r);
elseif apertureType==2
    [xyz,TBN,aperture] = initCircAperture(aperture,e,r);
else
    [xyz,TBN,aperture] = initRectAperture(aperture,e,r);
end
% 
%                
% 
%     tangent=xyz(:,1)-xyz(:,2);tangent=tangent/norm(tangent);
%     bitangent=xyz(:,4)-xyz(:,1);bitangent=bitangent/norm(bitangent);
%     normal=cross(bitangent,tangent);normal=normal/norm(normal);
%     TBN=[tangent bitangent normal];
   % apertureTypes, square, circular , circularRing, squareRing
    
    
    
    quad_=struct('XYZ',xyz,'ABCD',[TBN(:,3)' TBN(:,3)'*r'],'angles',e,'position',r,...
                  'apertureType',apertureType,'apertureData',aperture,'TextureHeight',@()(0),'invTBN',TBN^-1,...
                  'TBN',TBN,'TextureNormal',@()(TBN(:,3)'),...
                  'extraDataType','','extraData',[],'rotationMatrix',...
                  xRotMat(e(1)/180*pi)*yRotMat(e(2)/180*pi)*zRotMat(e(3)/180*pi)...
                  ,'type','surface');
end

function [xyz,TBN,aperture] = initRectAperture(aperture,e,r)
     H = aperture(1);
     L = aperture(2);
     d = aperture(3);
     if d>L/2||d>H/2
         disp('Warning:aperture area selfintersection')
         d=(L+H)/4;
     end
     aperture = [L,H,d];
         xyz=[[-L/2 L/2   L/2 -L/2 -L/2];...
                  [ H/2 H/2 -H/2 -H/2  H/2];...
                  [ 0    0      0      0     0]];
        if d~=0
        xyz_=[[-L/2+d L/2-d   L/2-d -L/2+d -L/2+d];...
              [ H/2- H/2-d -H/2+d -H/2+d  H/2-d];...
              [ 0    0      0      0     0]];
        xyz=[xyz_ xyz];
        end
%     tangent=[1 0 0]';
%     bitangent=[0 1 0]';
%     normal=[0 0 1]';
    TBN=[[1 0 0]' [0 1 0]' [0 0 1]'];
    for i=1:3
       TBN(:,i)=getRotation(TBN(:,i),1,e/180*pi);
   end
    
    
    for i=1:size(xyz,2);
        xyz(:,i)=getRotation(xyz(:,i),1,e/180*pi);
        xyz(:,i)=moveToPoint(xyz(:,i),r);
    end
end


function [xyz,TBN,aperture] = initCircAperture(aperture,e,r)
R_min = aperture(1);
R_max = aperture(2);
% d = aperture(3); 
     if R_min >R_max
         disp('Warning:aperture area selfintersection')
         tmp = R_max;
         R_min = tmp;
     end
t=linspace(0,1,64)*2*pi;
xyz=[sin(t)*R_max;cos(t)*R_max;t*0];
aperture = [R_min,R_max];
if R_min~=0
    xyz=[xyz [sin(t)*R_min;cos(t)*R_min;t*0]];
end   
   TBN=[[1 0 0]' [0 1 0]' [0 0 1]'];
    for i=1:3
      TBN(:,i)=getRotation(TBN(:,i),1,e/180*pi);
    end

    for i=1:size(xyz,2);
        xyz(:,i)=getRotation(xyz(:,i),1,e/180*pi);
        xyz(:,i)=moveToPoint(xyz(:,i),r);
    end
end
