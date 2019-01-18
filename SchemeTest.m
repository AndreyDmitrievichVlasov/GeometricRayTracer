clear all; close all;clc;initEnvio();

[ lens1 ] = getLens( 2.0, 1,  15, 15 );
[ lens1 ] = moveLens( lens1,[0 0 0]);

[ lens2 ] = getLens( 2.0, 1, 15, -15 );
[ lens2 ] = moveLens( lens2,[0 0 2]);

[ lens3 ] = getLens( 2.0, 1,  -15, -15);
[ lens3 ] = moveLens( lens3,[0 0 4]);

[ detector] =  flatQuad( 0.2,0.2,[0 0 0],[0.28 0 19.5]);


schema={};
sequensce=[5 1 2 3 4 ];
schema{1}=lens1;
schema{2}=lens2;
schema{3}=lens3;
schema{4}=detector;

DG_flat =  flatQuad( 4,4,[0 0 1],[0 0 -1]);
DG_flat=convertQuad2DG(DG_flat,0.032, 1, 0, 10^10);
schema{5}=DG_flat;

LED_source=paraxialSpot([0 0 -5],1);

% as array
% [ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);
% as sequence
[ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema,sequensce);

fig_1=figure();

axis vis3d 
view([0 0])
DrawElements(fig_1,schema);
drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle; ]);
drawRays(fig_1,[ raysOut]);
% drawRays(fig_1,[rays_in; rays_middle; rays_out_]);
grid on;
% 
fig_2=figure(2);
[~,~,~,~]=drawSpotDiagram(fig_2,schema{4},raysOut);

fig_3=figure(3);
[ intensity,x ,y ] = quadIntencity( schema{4},raysOut,128,128);
imagesc(x,y,intensity);
axis equal;