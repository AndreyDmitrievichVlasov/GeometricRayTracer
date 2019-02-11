clear all; close all;clc;
windows=false;
initEnvio(windows);
%all distances are expressed in mm
% graphics_toolkit gnuplot;

% getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec)
[schema,b]=getMaksTel(45,-435,-150,-300,20,200,-200,10,-200);
fprintf('Vynos teleskopa %.3f mm\n',b);

%detector = flatQuad(10.5,10.5,[0 0 0],[0 0 b-27]);
raysIn=paraxialSpot([0 0 -400],[10 45]);

[ raysIn,raysMiddle,raysOut ] = traceThroughSystem(raysIn, schema);

