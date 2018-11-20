function [ x,y,colors,angleSize] = spotDiagram( quad_,Rays)
%SPOTDIAGRAM Summary of this function goes here
%   Detailed explanation goes here

bounds=[-quad_.L/2 -quad_.H/2 quad_.L/2 quad_.H/2];
x=1:length(Rays);x=x-x;y=x;
colors=zeros(length(Rays),3);
angleSize=zeros(length(Rays),3);
if isstruct(Rays)
    for i=1:length(Rays)
            rayEnd    = Rays(i).r0+Rays(i).e*Rays(i).tEnd;
            position  = moveFromPoint(rayEnd, quad_.ABCD(1:3)*quad_.ABCD(4));
            position  = inverseRotation(position',1,quad_.angles/180*pi);
         if isIn(position(1:2),bounds)
             x(i)=position(1);
             y(i)=position(2);
             colors(i,:)=Rays(i).color;
             x_angle=atan(x(i)/quad_.ABCD(4)); 
             y_angle=atan(y(i)/quad_.ABCD(4)) ;
             angleSize(i,:)=[x_angle y_angle sqrt(x_angle^2+y_angle^2)/quad_.ABCD(4)];
         end
    end
else
        %    1   2   3   4   5   6     7   8           9         10  11 12 13
        % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY, R, G, B]
            rayEnd      = zeros(length(Rays),3);
            rayEnd(:,1) = Rays(:,1)+Rays(:,4).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(1)*quad_.ABCD(4);
            rayEnd(:,2) = Rays(:,2)+Rays(:,5).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(2)*quad_.ABCD(4);
            rayEnd(:,3) = Rays(:,3)+Rays(:,6).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(3)*quad_.ABCD(4);

            invRotMat=getInvRotMatrix(quad_.angles/180*pi);
            positions=zeros(size(rayEnd));
            positions(:,1)=invRotMat(1,1)*rayEnd(:,1)+invRotMat(1,2)*rayEnd(:,2)+invRotMat(1,3)*rayEnd(:,3);%+invRotMat(1,4)*1;
            positions(:,2)=invRotMat(2,1)*rayEnd(:,1)+invRotMat(2,2)*rayEnd(:,2)+invRotMat(2,3)*rayEnd(:,3);%+invRotMat(2,4)*1;
            positions(:,3)=invRotMat(3,1)*rayEnd(:,1)+invRotMat(3,2)*rayEnd(:,2)+invRotMat(3,3)*rayEnd(:,3);%+invRotMat(3,4)*1;

            isornot=isIn_array(positions,bounds);
            x=positions(:,1).*isornot;
            y=positions(:,2).*isornot;
            colors=zeros(size(Rays(:,11:13)));
            colors(:,1)=Rays(:,11).*isornot;
            colors(:,2)=Rays(:,12).*isornot;
            colors(:,3)=Rays(:,13).*isornot;
            
             angleSize(:,1)=atan(positions(:,1)/quad_.ABCD(4)).*isornot; 
             angleSize(:,2)=atan(positions(:,2)/quad_.ABCD(4)).*isornot ;
             angleSize(:,3)=atan(sqrt(positions(:,1).^2+positions(:,2).^2)/quad_.ABCD(4)).*isornot;
           
end


end

function isornot=isIn_array(pos,bounds)
    isornot=((pos(:,1)<=bounds(3)).*(pos(:,1)>=bounds(1)).*...
             (pos(:,2)<=bounds(4)).*(pos(:,2)>=bounds(2)) );
end
function isornot=isIn(pos,bounds)
    isornot=(pos(1)<=bounds(3)&&pos(1)>=bounds(1)&&...
             pos(2)<=bounds(4)&&pos(2)>=bounds(2) );
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
function  mat = getInvRotMatrix(angle)
    mat= transpose(xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3)));
end
function  vec = inverseRotation(vec,dirOrPos, angle)
    if dirOrPos==1
        vec_= transpose(xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3)))*[vec  1]';
    else
        vec_= transpose(xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3)))*[vec  0]';
    end
    vec=vec_(1:3);
end
function vec = moveFromPoint(vec,Pos)
% size(vec)
    vec_=[[1 0 0 -Pos(1)];...
          [0 1 0 -Pos(2)];...
          [0 0 1 -Pos(3)];...
          [0 0 0 1]]*[vec 1]';
    vec=vec_(1:3);
end