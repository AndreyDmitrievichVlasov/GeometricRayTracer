close all; clear all; clc;initEnvio();
[ lens ] = getLens( 'aperture',10,'tickness',10,'r1',[20 20 -10],'r2',[20 20 10],'material','SK16');
[ detector ] =  flatQuad('aperture', [0.125 0.125 0],'apertureType',1,'position',[0 0 40]);
schema={};
sequensce=[ 1 2];
% sequensce=[ 1 2 3 5 6 7 8];

% sequensce=[ 8];
% sequensce=[ 1 2 3 5 6 7 8];
schema{1}=lens;
schema{2}=detector;
LED_source=paraxialSpot([0 0 -10],[0 0.1]);

[ raysIn, raysMiddle, raysOut ] = traceThroughSystem(LED_source, schema,sequensce);

fig_1=figure();


DrawElements(schema);
drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle;]);
drawRays(fig_1,[ raysOut]);
% plot2svg('full_schema_.svg');
% drawRays(fig_1,[rays_in; rays_middle; rays_out_]);
% 
[ PSF] = getPSFData( raysOut,schema{2},128,128);

fig_2=figure(2);
drawSpotDiagram(fig_2,PSF,schema{2});

