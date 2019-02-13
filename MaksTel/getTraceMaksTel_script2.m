% maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec
[schema,b]=getMaksTel(45,-362.8,-100,-108.9,14.3,145,-200,11.6,-200);
fprintf('Vynos teleskopa %.3f mm\n',b);

raysIn=paraxialSpotHom([0 0 -400],[10 45],30);
[ raysIn,~,raysOut ] = traceThroughSystem(raysIn, schema);

raysOutMin=raysOut;
