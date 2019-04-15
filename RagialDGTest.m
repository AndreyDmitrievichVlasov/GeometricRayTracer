clear all;
close all;
clc;
initEnvio();

radialDG = flatQuad('aperture', [15 15 0],'apertureType',1,'position',[0 0 1]);

radialDG = convertQuad2RadialDG(radialDG, 0.012, -1, 0, 10^10);

[ detector] =  flatQuad('aperture', [0.5 0.5 0],'apertureType',1,'position',[0 0 2]);


 LED_source=LED([0 0 -1], 0.01);%paraxialSpot([0 0 -1],[4.99 5]);
%  LED_source= paraxialSpot([0 0 -1],[0.149 0.15]);

schema={};
schema{1}=radialDG;
schema{2}=detector;

[ raysIn, raysMiddle, raysOut ] = traceThroughSystem(LED_source, schema);


fig_1=figure();

DrawElements(schema);
drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle;]);
drawRays(fig_1,[ raysOut]);


fig_2=figure(2);
[~,~,~,~]=drawSpotDiagram(fig_2,schema{2},raysOut);
