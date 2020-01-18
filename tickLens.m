%%Пример использования трейсера для толстой линзы
clear; close all;clc;initEnvio();
%%чтобы перейти к определению функции,необходимо поставить курсор сразу после имени этой функции и нажать ctrl+D 
[ lens ] = getLens( 'aperture',2, 'tickness',2, 'r1', [10 10 10],'r2',[10 10 50]);

[ lens ] = moveLens(lens,[0 0 0]);

[ detector] =  flatQuad('aperture', [2.1 2.1 0],'apertureType',1,'position',[0 0 12]);

 LED_source=Spot('position',[0 0 -2],'apertureType','circ','aperture',[0 1.5],'Nrays',32,'Mrays',32);

[ rays_in, rays_middle, rays_out ] = traceThroughtLens( lens, LED_source);

[  rays_out ] = quadIntersect( detector, rays_out);

fig_1=figure(1);
    
axis vis3d 

view([0 0])

DrawElements({lens, detector});

 drawRays(fig_1,[rays_in;rays_middle;rays_out]);

 grid on;
 
 [ PSF] = getPSFData( rays_out, detector,128,128);

 drawSpotDiagram(PSF,detector);
