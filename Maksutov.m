close all; clear all; clc;


ttelescope = getMaksTel(90,-435,-150,-300,20,200,-200,10,-200);

schema{1}=ttelescope.menisc;
schema{2}=ttelescope.mmirror;

schema{3}=ttelescope.smirror;
schema{4}=flatQuad( 10.5,10.5,[0 0 0],[0 0 ttelescope.b]);
% convert 2 mirror
schema{2}.extraDataType = strcat(schema{2}.extraDataType,'_mirror') ;
schema{3}.extraDataType = strcat(schema{3}.extraDataType,'_mirror') ;

LED_source=paraxialSpot([0 0 -400],[0 45]);

[ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);

f=figure(1);
axis vis3d 
view([0 0])

DrawElements(f,schema);
drawRays(f,[raysIn;raysMiddle;raysOut]);
grid on;

% endWith