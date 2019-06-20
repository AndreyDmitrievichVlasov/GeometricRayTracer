function drawLens(Lens,hndl)
             
frontMesh=Lens.frontSurface.extraData.surfaceMesh;
backMesh=Lens.backSurface.extraData.surfaceMesh;
backMesh(3,:)=backMesh(3,:)+Lens.tickness;

for i=1:size(frontMesh,2)
    frontMesh(:,i)=Lens.frontSurface.rotationMatrix(1:3,1:3)*frontMesh(:,i)+Lens.frontSurface.position';
    backMesh(:,i)=Lens.frontSurface.rotationMatrix(1:3,1:3)*backMesh(:,i)+Lens.frontSurface.position';
end
version_date = version('-release');
version_date = str2num(version_date(1:4));
     if version_date>2014
        plot3(hndl,frontMesh(1,:), frontMesh(2,:),frontMesh(3,:),'k','lineWidth',1);
        plot3(hndl,backMesh(1,:), backMesh(2,:),backMesh(3,:),'k','lineWidth',1);
%         plot3(hndl,l_1_y(1,:), l_1_y(2,:),l_1_y(3,:),'k','lineWidth',1);
%         plot3(hndl,l_2_y(1,:), l_2_y(2,:),l_2_y(3,:),'k','lineWidth',1);
    else
        plot3(hndl,frontMesh(1,:), frontMesh(2,:),frontMesh(3,:),'k','lineWidth',1,'lineSmooth','on');
        plot3(hndl,backMesh(1,:), backMesh(2,:),backMesh(3,:),'k','lineWidth',1,'lineSmooth','on');
%         plot3(hndl,l_1_y(1,:), l_1_y(2,:),l_1_y(3,:),'k','lineWidth',1,'lineSmooth','on');
%         plot3(hndl,l_2_y(1,:), l_2_y(2,:),l_2_y(3,:),'k','lineWidth',1,'lineSmooth','on');
      end
end

 
 

