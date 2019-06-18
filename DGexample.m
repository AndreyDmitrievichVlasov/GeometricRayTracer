%%Пример использования трейсера для толстой линзы
clear all; close all;clc;initEnvio();
%%чтобы перейти к определению функции,необходимо поставить курсор сразу после имени этой функции и нажать ctrl+D 
schema={};

schema{1} = getLens( 'aperture',2,'tickness',2,'r1', -15,'r2', 15);

schema{1} =  moveLens( schema{1} ,[0 0 0]);

schema{2} =flatQuad('aperture', [4 4 0],'apertureType',1,'position',[0 0 4]);

schema{2} =convertQuad2DG(schema{2},0.032, 1, 0, -100);

schema{3} = flatQuad('aperture', [10.25 10.25 0],'apertureType',1,'position',[0.25 0 17]);%flatQuad( 10,10,[0 0 0],[0 0 10]);  

LED_source =Spot('Nrays',5,'Mrays',100,'apertureType','circ','position',[0 0 -5]);

seq=[1 2 3];
[ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema,seq);


fig_1=figure(1);
axis vis3d 
view([0 0])
DrawElements(schema);
drawRays(fig_1,[ raysIn; raysMiddle; raysOut ]);
grid on;

[ PSF] = getPSFData( raysOut,schema{length(schema)},512,512);
 
drawSpotDiagram(PSF,schema{length(schema)});

