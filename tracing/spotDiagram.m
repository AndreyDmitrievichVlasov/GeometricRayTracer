function [ x,y,colors,angleSize,waveLngthKeys] = spotDiagram( quad_,Rays)
%SPOTDIAGRAM Summary of this function goes here
%   Detailed explanation goes here

% bounds=[-quad_.L/2 -quad_.H/2 quad_.L/2 quad_.H/2];

% bounds=[[-quad_.L/2 0, 0]; [quad_.L/2,0 ,0 ];[0, -quad_.H/2, 0];[0, quad_.H/2,0]];

% x=1:length(Rays);
% x=x-x;
% y=x;
% colors=zeros(length(Rays),3);
[raysMap, waveLngthKeys]= getRaysSeparatedByWaveLength(Rays);
% raysMap(waveLngthKeys{1})
% raysMap(waveLngthKeys{2})
% raysMap(waveLngthKeys{3})
 x={};y={};colors={};angleSize={};
for i=1:length(waveLngthKeys)
    [ x_,y_,colors_,angleSize_] = CalculateSpotDiagram(quad_,raysMap(waveLngthKeys{i}));
     x{i}=x_;
     y{i}=y_;
     colors{i}=colors_;
     angleSize{i}=angleSize_;
end


end


function [ x,y,colors,angleSize] = CalculateSpotDiagram(quad_,Rays)
            angleSize=zeros(size(Rays,1),3);
        %    1   2   3   4   5   6     7   8           9         10  11 12 13
        % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY, R, G, B]
            rayEnd      = zeros(size(Rays,1),3);
            rayEnd(:,1) = Rays(:,1)+Rays(:,4).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(1)*quad_.ABCD(4);
            rayEnd(:,2) = Rays(:,2)+Rays(:,5).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(2)*quad_.ABCD(4);
            rayEnd(:,3) = Rays(:,3)+Rays(:,6).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(3)*quad_.ABCD(4);

            rayEnd(:,1) = rayEnd(:,1) -quad_.position(1);
            rayEnd(:,2) = rayEnd(:,2) -quad_.position(2);
            rayEnd(:,3) = rayEnd(:,3) -quad_.position(3);
            
            invRotMat=getInvRotMatrix(quad_.angles/180*pi);
            positions=zeros(size(rayEnd));
            positions(:,1)=invRotMat(1,1)*rayEnd(:,1)+invRotMat(1,2)*rayEnd(:,2)+invRotMat(1,3)*rayEnd(:,3);%+invRotMat(1,4)*1;
            positions(:,2)=invRotMat(2,1)*rayEnd(:,1)+invRotMat(2,2)*rayEnd(:,2)+invRotMat(2,3)*rayEnd(:,3);%+invRotMat(2,4)*1;
            positions(:,3)=invRotMat(3,1)*rayEnd(:,1)+invRotMat(3,2)*rayEnd(:,2)+invRotMat(3,3)*rayEnd(:,3);%+invRotMat(3,4)*1;

            isornot=isInsideArray(positions,quad_);
            x=(positions(:,1)+quad_.position(1)).*isornot;
            y=(positions(:,2)+quad_.position(2)).*isornot;
            colors=zeros(size(Rays(:,11:13)));
            colors(:,1)=Rays(:,11).*isornot;
            colors(:,2)=Rays(:,12).*isornot;
            colors(:,3)=Rays(:,13).*isornot;

            angleSize(:,1)=atan(positions(:,1)/quad_.ABCD(4)).*isornot; 
            angleSize(:,2)=atan(positions(:,2)/quad_.ABCD(4)).*isornot ;
            angleSize(:,3)=atan(sqrt(positions(:,1).^2+positions(:,2).^2)/quad_.ABCD(4)).*isornot;
end


function isornot=isInsideArray(pos,q)
 isornot=[];
 if(size(pos,1)>1)
  for i=1:size(pos,1)
   isornot(end+1)=isInside(pos(i,:),q);
  end
  isornot=isornot';
 else
  isornot=isInside(pos,q);
 end
 return;
end
%% Error is in function below
function [raysMap, waveLngthKeys]= getRaysSeparatedByWaveLength(rays)
raysMap= containers.Map('KeyType','double','ValueType','any');
 
    for i=1:size(rays,1)
        if ~isKey(raysMap,rays(i,9));
            raysMap(rays(i,9))=rays(i,:);
            continue;
        end
        raysMap(rays(i,9))=[raysMap(rays(i,9));rays(i,:)];
   end
    waveLngthKeys=keys(raysMap);
end

%function isornot=isIn_array(pos,bounds)
%    isornot=((pos(:,1)<=bounds(3)).*(pos(:,1)>=bounds(1)).*...
%             (pos(:,2)<=bounds(4)).*(pos(:,2)>=bounds(2)) );
%end
%function isornot=isIn(pos,bounds)
%    isornot=(pos(1)<=bounds(3)&&pos(1)>=bounds(1)&&...
%             pos(2)<=bounds(4)&&pos(2)>=bounds(2) );
%end

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