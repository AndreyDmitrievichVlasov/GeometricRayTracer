clear all; close all;clc;initEnvio();

position=3.2589 + 6.007551 + 0.999975 + 2.952076 + 4.740409;

ofsett= 42.1577;

%forward
[ lens1 ] = getLens( 'aperture',10,'tickness', 3.2589,'r1', -22.01359,'r2', 435.760436,'material','SK16');
[ lens1 ] = moveLens( lens1,[0 0 0]);

[ lens2 ] = getLens('aperture', 10,'tickness', 0.999975,'r1',22.213277,'r2', -20.291924,'material','F2');
[ lens2 ] = moveLens( lens2,[0 0 3.2589+6.007551]);

[ lens3 ] = getLens('aperture', 6,'tickness', 2.952076,'r1',  -79.683603, 'r2',18.389841,'material','SK16');
[ lens3 ] = moveLens( lens3,[0 0 3.2589 + 6.007551 + 0.999975 + 4.740409]);

%reverce
[ lens_1 ] = getLens('aperture', 10,'tickness', 3.2589,'r1', -435.760436, 'r2', 22.01359,'material','SK16');
[ lens_1 ] = moveLens( lens_1,[0 0 position+ofsett*2+2+2.952076+4.750409+0.999975+6.007551]);

[ lens_2 ] = getLens('aperture', 10,'tickness', 0.999975,'r1',20.291924,'r2', -22.213277,'material','F2');
[ lens_2 ] = moveLens( lens_2,[0 0 position+ofsett*2+2+2.952076+4.750409]);

[ lens_3 ] = getLens('aperture', 6,'tickness', 2.952076,'r1', -18.389841,'r2', 79.683603,'material','SK16');
[ lens_3 ] = moveLens( lens_3,[0 0 position+ofsett*2+2]);


radialDG = flatQuad('aperture', [8 8 0],'apertureType',1,'position',[0 0 position+ofsett+1]);

% radialDG = flatQuad( [8 8 0],1,[0 0 0],[0 0 position+ofsett+1]);
radialDG = convertQuad2RadialDG(radialDG, 0.032,  1, 0, 10^10);

[ axicon ] =getLens( 'aperture',4,'tickness', 1,'r1', 10^10,'r2', 10^10,'material','SK16');%; getAxicon( 4, 2,[4 4 1],'SK16');% getLens( 4, 2, 10^10, 10^10,'SK16');%; 

[ axicon ] = moveLens( axicon,[0 0 position+ofsett]);

[ detector] =  flatQuad('aperture', [15 15 0],'apertureType',1,'position',[0 0 122.25+75]);

schema={};
sequensce=[ 1 2 3 8 4 5 6 7 9];
% sequensce=[ 1 2 3 5 6 7 8];
% sequensce=[ 1 2 3 4 5 6 7 9];
%  sequensce=[8 4 9];
% sequensce=[ 8];
% sequensce=[ 1 2 3 5 6 7 8];
schema{1}=lens1;
schema{2}=lens2;
schema{3}=lens3;

schema{4}=axicon;

schema{5}=lens_3;
schema{6}=lens_2;
schema{7}=lens_1;

schema{8}=radialDG;
schema{9}=detector;

% SceneSave('schemeVeronica',schema);
% DG_flat =  flatQuad( 4,4,[0 0 1],[0 0 -1]);
% DG_flat=convertQuad2DG(DG_flat,0.032, 1, 0, 10^10);
% schema{5}=DG_flat;

%   LED_source=paraxialSpot([0 0 -50],[4.95 5],'coloredCheceker.png');
tic
field_y = 5;
  LED_source=Spot('position',[0 0 0],'apertureType','circ','aperture',[4.99 5],'Nrays',1,'Mrays',512,'position',[0 0 -10],...
      'waveLenghts',linspace(0.38,0.78,6),'distance',10000,'fields',{[0 field_y]});
% LED_source=LED([0 0 -10], 0.1);%paraxialSpot([0 0 -10],[4.8 4.9]);% [ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);
% as sequence
[ raysIn, raysMiddle, raysOut ] = traceThroughSystem(LED_source, schema,sequensce);

fig_1=figure(3);


DrawElements(schema);
drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle;]);
drawRays(fig_1,[raysOut]);
xlim([-20 20]);
zlim([-50 200]);

% plot2svg('full_schema_.svg');
% drawRays(fig_1,[rays_in; rays_middle; rays_out_]);
% 
[ PSF] = getPSFData( raysOut, schema{9},512,512);

 
drawSpotDiagram(PSF,schema{9},'saveSpot2',['spotDiagrammForField [0 ',num2str(field_y),'].svg']);
toc;
       % [~,~,~,~]=drawSpotDiagram(fig_2,schema{11},raysOut);
% 
% fig_3=figure(3);
% [ intensity,x ,y ] = quadIntencity( schema{11},raysOut,512,512);
% imagesc(x,y,intensity');
% axis equal;

