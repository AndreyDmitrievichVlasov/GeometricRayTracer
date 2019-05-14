clear all; close all;clc;initEnvio();


radialDG = flatQuad('aperture', [20 20 0],'apertureType',1,'position',[0 0 0]);

radialDG = convertQuad2RadialDG(radialDG, 0.032, 1, 0, 10^10);
detector1 =  flatQuad('aperture', [20 20 0],'apertureType',1,'position',[0 0 20]);


schema={};

sequensce=[ 1 2];
% sequensce=[ 1 2 3 5 6 7 8];

% sequensce=[ 8];
% sequensce=[ 1 2 3 5 6 7 8];
schema{1}=radialDG;
schema{2}=detector1;
LED_source=paraxialSpot([0 0 -50],[0 0.0001]);
% as array
% [ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);
% as sequence
[ raysIn, raysMiddle, raysOut ] = traceThroughSystem(LED_source, schema,sequensce);

fig_1=figure();


DrawElements(schema);
drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle;]);
drawRays(fig_1,[ raysOut]);
% plot2svg('full_schema_.svg');
% drawRays(fig_1,[rays_in; rays_middle; rays_out_]);
% 
fig_2=figure(2);
[~,~,~,~]=drawSpotDiagram(fig_2,schema{2},raysOut);

fig_3=figure(3);
[ intensity,x ,y ] = quadIntencity( schema{2},raysOut,512,512);
imagesc(x,y,intensity');
axis equal;