function drawQuad(fig_handler,quad_)
%DRAWQUAD Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(version('-release'),'2015b')
        drawQuadIn2015b(quad_)
    else
        drawQuadInOlderVersions(quad_)
    end
end

function drawQuadIn2015b(quad_)
    hold on
    plot3(quad_.XYZ(1,:),quad_.XYZ(2,:),quad_.XYZ(3,:),'k:','lineWidth',1);
    %TBN
    r_0=quad_.position;

    plot3([r_0(1) r_0(1)+0.5*quad_.L*quad_.TBN(1,1)],...
             [r_0(2) r_0(2)+0.5*quad_.L*quad_.TBN(2,1)],...
             [r_0(3) r_0(3)+0.5*quad_.L*quad_.TBN(3,1)],...
             'r','lineWidth',1);

    plot3([r_0(1) r_0(1)+0.5*quad_.H*quad_.TBN(1,2)],...
          [r_0(2) r_0(2)+0.5*quad_.H*quad_.TBN(2,2)],...
          [r_0(3) r_0(3)+0.5*quad_.H*quad_.TBN(3,2)],...
          'g','lineWidth',1);

    plot3([r_0(1) r_0(1)+0.25*(quad_.H+quad_.L)*quad_.TBN(1,3)],...
          [r_0(2) r_0(2)+0.25*(quad_.H+quad_.L)*quad_.TBN(2,3)],...
          [r_0(3) r_0(3)+0.25*(quad_.H+quad_.L)*quad_.TBN(3,3)],...
          'b','lineWidth',1);
        elemType = quad_.extraDataType;
        
        if endWith(elemType,'DG')%strcmp(elemType,'flatDG')||strcmp(elemType,'sphereDG')||strcmp(elemType,'ellipsoidDG')||strcmp(elemType,'paraboloidDG');
            plot3(quad_.extraData.direction(1,:),quad_.extraData.direction(2,:),quad_.extraData.direction(3,:),...
                 'g--','lineWidth',1.75);
        end
%         description=quad_.extraDataType((quad_.extraDataType-2):length(quad_.extraDataType));conus
%         if strcmp(elemType,'sphere')||strcmp(elemType,'ellipsoid')||strcmp(elemType,'paraboloid')||strcmp(elemType,'conus')||...
%            strcmp(elemType,'sphereDG')||strcmp(elemType,'ellipsoidDG')||strcmp(elemType,'paraboloidDG')
     if  ~isempty(quad_.extraData)
            plotCurveIn3D(quad_.extraData.arc_x,quad_.rotationMatrix,quad_.position,0);
            plotCurveIn3D(quad_.extraData.arc_y,quad_.rotationMatrix,quad_.position,0);
            plotCurveIn3D(quad_.extraData.arc_xy,quad_.rotationMatrix,quad_.position,0);
    end
    hold off;
end

function drawQuadInOlderVersions(quad_)
    hold on
    plot3(quad_.XYZ(1,:),quad_.XYZ(2,:),quad_.XYZ(3,:),'k:','lineSmooth','on','lineWidth',2);
    %TBN
     r_0=quad_.position;

    plot3([r_0(1) r_0(1)+0.5*quad_.L*quad_.TBN(1,1)],...
          [r_0(2) r_0(2)+0.5*quad_.L*quad_.TBN(2,1)],...
          [r_0(3) r_0(3)+0.5*quad_.L*quad_.TBN(3,1)],...
          'r','lineSmooth','on','lineWidth',1);

    plot3([r_0(1) r_0(1)+0.5*quad_.H*quad_.TBN(1,2)],...
          [r_0(2) r_0(2)+0.5*quad_.H*quad_.TBN(2,2)],...
          [r_0(3) r_0(3)+0.5*quad_.H*quad_.TBN(3,2)],...
          'g','lineSmooth','on','lineWidth',1);

    plot3([r_0(1) r_0(1)+0.25*(quad_.H+quad_.L)*quad_.TBN(1,3)],...
          [r_0(2) r_0(2)+0.25*(quad_.H+quad_.L)*quad_.TBN(2,3)],...
          [r_0(3) r_0(3)+0.25*(quad_.H+quad_.L)*quad_.TBN(3,3)],...
          'b','lineSmooth','on','lineWidth',1);

        if strcmp(quad_.extraDataType,'flatDG')
            plot3(quad_.extraData.direction(1,:),quad_.extraData.direction(2,:),quad_.extraData.direction(3,:),...
                 'g--','lineSmooth','on','lineWidth',1.75);
        end
         elemType = quad_.extraDataType;
        if endWith(elemType,'DG')%strcmp(elemType,'flatDG')||strcmp(elemType,'sphereDG')||strcmp(elemType,'ellipsoidDG')||strcmp(elemType,'paraboloidDG');
            plot3(quad_.extraData.direction(1,:),quad_.extraData.direction(2,:),quad_.extraData.direction(3,:),...
                 'g--','lineSmooth','on','lineWidth',1.75);
        end
%         description=quad_.extraDataType((quad_.extraDataType-2):length(quad_.extraDataType));
%         if strcmp(elemType,'sphere')||strcmp(elemType,'ellipsoid')||strcmp(elemType,'paraboloid')||strcmp(elemType,'conus')||...
%            strcmp(elemType,'sphereDG')||strcmp(elemType,'ellipsoidDG')||strcmp(elemType,'paraboloidDG')
          if  ~isempty(quad_.extraData)
            plotCurveIn3D(quad_.extraData.arc_x,quad_.rotationMatrix,quad_.position,0);
            plotCurveIn3D(quad_.extraData.arc_y,quad_.rotationMatrix,quad_.position,0);
            plotCurveIn3D(quad_.extraData.arc_xy,quad_.rotationMatrix,quad_.position,0);
          end

        hold off;
end

function plotCurveIn3D(curve_data,orient_matrix,ref_point,smooth_or_not)

draw_data=[orient_matrix(1,1)*curve_data(1,:)+orient_matrix(1,2)*curve_data(2,:)+orient_matrix(1,3)*curve_data(3,:)+ref_point(1);
           orient_matrix(2,1)*curve_data(1,:)+orient_matrix(2,2)*curve_data(2,:)+orient_matrix(2,3)*curve_data(3,:)+ref_point(2);
           orient_matrix(3,1)*curve_data(1,:)+orient_matrix(3,2)*curve_data(2,:)+orient_matrix(3,3)*curve_data(3,:)+ref_point(3)];
    
       
    
    if smooth_or_not==1
          plot3(draw_data(1,:),draw_data(2,:),draw_data(3,:),'k','lineSmooth','on','lineWidth',1.75);
    else
          plot3(draw_data(1,:),draw_data(2,:),draw_data(3,:),'k','lineWidth',1.75);
    end
end
