function drawLens(Lens,hndl)
drawQuad(Lens.frontSurface,hndl);
drawQuad(Lens.backSurface,hndl);
end_1=Lens.frontSurface.extraData.drawQuality;
end_2=Lens.backSurface.extraData.drawQuality;
t=Lens.tickness;

l_1_x=[Lens.frontSurface.extraData.arc_x(:,1)...
           Lens.backSurface.extraData.arc_x(:,1)+[0;0;t]];
l_2_x=[Lens.backSurface.extraData.arc_x(:,end_2)+[0;0;t]...
           Lens.frontSurface.extraData.arc_x(:,end_1)];
l_1_y=[Lens.frontSurface.extraData.arc_y(:,1)...
           Lens.backSurface.extraData.arc_y(:,1)+[0;0;t]];
l_2_y=[Lens.backSurface.extraData.arc_y(:,end_2)+[0;0;t]...
           Lens.frontSurface.extraData.arc_y(:,end_1)];                  

for i=1:2
    l_1_x(:,i)=Lens.frontSurface.rotationMatrix(1:3,1:3)*l_1_x(:,i)+Lens.frontSurface.position';
    l_2_x(:,i)=Lens.frontSurface.rotationMatrix(1:3,1:3)*l_2_x(:,i)+Lens.frontSurface.position';
    l_1_y(:,i)=Lens.frontSurface.rotationMatrix(1:3,1:3)*l_1_y(:,i)+Lens.frontSurface.position';
    l_2_y(:,i)=Lens.frontSurface.rotationMatrix(1:3,1:3)*l_2_y(:,i)+Lens.frontSurface.position';
end
    if strcmp(version('-release'),'2015b')
        plot3(hndl,l_1_x(1,:), l_1_x(2,:),l_1_x(3,:),'k','lineWidth',1);
        plot3(hndl,l_2_x(1,:), l_2_x(2,:),l_2_x(3,:),'k','lineWidth',1);
        plot3(hndl,l_1_y(1,:), l_1_y(2,:),l_1_y(3,:),'k','lineWidth',1);
        plot3(hndl,l_2_y(1,:), l_2_y(2,:),l_2_y(3,:),'k','lineWidth',1);
    else
        plot3(hndl,l_1_x(1,:), l_1_x(2,:),l_1_x(3,:),'k','lineWidth',1,'lineSmooth','on');
        plot3(hndl,l_2_x(1,:), l_2_x(2,:),l_2_x(3,:),'k','lineWidth',1,'lineSmooth','on');
        plot3(hndl,l_1_y(1,:), l_1_y(2,:),l_1_y(3,:),'k','lineWidth',1,'lineSmooth','on');
        plot3(hndl,l_2_y(1,:), l_2_y(2,:),l_2_y(3,:),'k','lineWidth',1,'lineSmooth','on');

    end
end

 
 

