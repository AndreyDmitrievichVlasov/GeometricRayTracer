function [ quad_ ] = convertQuad2DG(quad_,density,orders,transOrReflect)
%CONVERTQUAD2DG Summary of this function goes here
quad_.extraDataType='flatDG';
direction = [quad_.L*[0   0   0.75 0.75 1   0.75 0.75 0]-quad_.L/2;
             quad_.H*[0.6 0.4 0.4  0.25 0.5 0.75 0.6  0.6]-quad_.H/2;
                     [0   0   0    0    0   0    0    0]];
 
         for i=1:8
             direction(:,i)=getRotation(direction(:,i),1,quad_.angles/180*pi);
             direction(:,i)=moveToPoint(direction(:,i),quad_.ABCD(1:3)'*quad_.ABCD(4));
         end
quad_.extraData=struct('direction',direction,'density',density,'orders',orders,'transOrReflect',transOrReflect);
end

function  rotX = xRotMat(angle)
rotX =[[1 0               0              0];...
       [0 cos(angle) -sin(angle)  0];...
       [0 sin(angle)   cos(angle) 0];...
       [0 0               0              1]];
end

function  rotY = yRotMat(angle)
rotY =[[  cos(angle)   0  sin(angle)  0];...
       [  0                1  0               0];...
       [ -sin(angle)    0  cos(angle) 0];...
       [  0                 0  0              1]];
end

function  rotZ = zRotMat(angle)
rotZ =[[cos(angle) -sin(angle) 0 0];...
       [sin(angle)   cos(angle) 0 0];
       [0                0             1 0];...
       [0                0             0 1]];
end
function  vec = getRotation(vec,dirOrPos, angle)
    if dirOrPos==1
      
        vec_=xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3))*[vec; 1];
    else
        vec_=xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3))*[vec; 0];
    end
    vec=vec_(1:3);
end
function vec = moveToPoint(vec,Pos)
    vec_=[[1 0 0 Pos(1)];...
          [0 1 0 Pos(2)];...
          [0 0 1 Pos(3)];...
          [0 0 0 1]]*[vec ;1];
    vec=vec_(1:3);
end
