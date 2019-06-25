clear all; close all;clc;initEnvio();

radialDG = flatQuad('aperture', [8 8 0],'apertureType',1,'position',[0 0 0]);%flatQuad( 10,10,[0 0 0],[0 0 0]);

dtetector = flatQuad('aperture', [8 8 0],'apertureType',1,'position',[0 0 10]);%flatQuad( 10,10,[0 0 0],[0 0 10]);

radialDG = convertQuad2RadialDG(radialDG,0.032, -1, 0, 10^10);

schema={};

schema{1}=radialDG;

schema{2}=dtetector;

LED_source = Spot('distance',100,'Nrays',5,'Mrays',100,'apertureType','circ','position',[0 0 0],'fields',{[0 0],[1 0],[2 0]});%LED([0 0 -10], 0.1);%paraxialSpot([0 0 -10],[4.8 4.9]);

[ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);

fig_1=figure();

DrawElements(schema);

drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle;]);
drawRays(fig_1,[ raysOut]);

[ PSF] = getPSFData( raysOut,schema{length(schema)},512,512);
 
drawSpotDiagram(PSF,schema{length(schema)});
