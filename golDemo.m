% This file is not to be run entirely, it gives an example of GOL session
% before running gol_init, insert the correct matlab variable into gol_init.m. If we run this on Matlab, set matlab=1 or matlab=true
% If we run this on Octave, insert matlab=0 or matlab=false
matlab=false;
gol_init; % This step is needed to initialize all GOL global variables and to add folders to the search path

% This function initializes mt - Maksutov telescope with givemn parameters
MaksTelPar=[maprad=45,rmm=-435,r1m=-150,r2m=-300,mthick=20,dist=200,argdistsec=-1,secaprad=11.6,argrsec=-200];
[matr,newdir,firstvertex,lastvertex,zfmatr,mt]=getMatrixMaksPar(MaksTelPar);
% If we wanted to, we could just write:
% MaksTelPar=[45,-435,-150,-300,20,200,-200,10,-200];
% or
% [matr,newdir,firstvertex,lastvertex,zf,mt]=getMatrixMaksPar([45,-435,-150,-300,20,200,-200,10,-200]);
% Inputs: 
%  maprad - menisc aperture radius, rmm - radius of main mirror
% r1m, r2m - radii of menisc (r1m - external), 
% dist - distance between main mirror and menisc
% distsec - distance between primary mirror and secondary mirror. 
%   If zero or negative, secondary mirror is assumed to be coated inner side of menisc
% secaprad - secondary aperture radius
% rsec - radius of curvature of secondary mirror. if distsec<=0, this value is ignored and r2m is used for this purpose
% Outputs:
% matr - ray transfer matrix of Maksutov telescope, see http://jestestvoznanie.ru/thick-lenses/
% newdir - the direction after the telescope. dir=1 - positive z direction, dir=0, negative z direction. This should be always 1. 
%  Initial rays are assumed to have dir=1
% firstvertex - the first point on the main optical axis where the light encounters the system.
% lastvertex - the last point on the main optical axis where the light encounters the system.
% zfmatr - z-coordinate of focal plane calculated from ray transfer matrix formalism. 
%  Since paraxial approximation is used when calculating zf, the best focus can be elsewhere, but usually not too far.
% mt - Maksutov telescope object, a cell array containing Maksutov telescope elements

% generate RGB parallel rays
raysIn=paraxialSpotHom([0 0 -1000],[MaksTelPar(8) MaksTelPar(1)],30);
% [0 0 -1000] - that's origination point
% [MaksTelPar(8) MaksTelPar(1)] - the outer and inner radii of the ray fan. Rays with distance from the axis more than MaksTelPar(8) and less than MaksTelPar(1) are going to be removed
% The last arguments, 30, is number of rays. The total output number of rays will ne 30*30 minus rays that don't work because of their distance to the axis

[~,~,raysOut] = traceThroughSystem(raysIn,mt);
% trace rays through Maksutov telescope. 
% raysOut is output rays array

MaksTelMatrMin{1}=mt;
MaksTelMatrMin{2}=matr;
MaksTelMatrMin{3}=raysOut;
% These are global variables that are needed for minimization. If they are not initialized, then widthMaksTelPar will initialize them


[width,zf]=widthMaksTelPar(MaksTelPar,nrays=30,delta=10);
% INPUTS: delta is the step to expand search window if we haven't found the minimum right away. 10 mm is a good choice
% OUTPUTS: 
%  width is the image width, the radius of a circle that contains 50% of all rays in the optimal position of detector
%  zf is the optimal position of the detector

golGetFigs(raysOut,zf,detSize=2.0,Npix=300,matlab,str='DemoPars');
% This function will produce two images in the images folder. If there is no folder 'images', it will complain - please make sure that the folder images exists
% INPUTS - zf - detector position. Could be anything, not just the best detector position
% detSize - the size of the detector
% Npix - number of pixels along one side of the detector
% matlab - tells us if this is run in Matlab or Octave (see gol_init script description in the beginning of this file)
% str - the string that's going to be appended to the filenames so that 

% Now it's time to minimize. 
mtpMinInd=[45,-362.8,-100,-108.9,14.3,160,145,11.6,-108.9]; % The parameters of the telescope. Only those parameters which are not in minInd, are used
minInd=[6,7,9]; % We will minimize position of menisc (6), position of the secondary mirror (7) and its curvature
% So, the argument of function to be minimized is x(1)=position of the menisc, x(2)=position of the secondary mirror, x(3)=radius of curvature of the secondary mirror
lb679=[50 50 -300]; % minimum values of the parameters
ub679=[290,280,0];  % maximum values of the parameters
% widthMinInd - function that returns image width from a system with given parameters
% ineqMinInd - inequality function that checks several conditions.
% ineqMinInd checks that: 
%  1) the image calculated by matri[ method is between z=absolutemin and z=absolutemax (absolutemin and absolutemax are global variables that are described in gol_init.m)
% 2) that the system has positive overall optical power (is focusing)
% 3) if the positions of menisc and secondary mirror do not coincide, it checks that they are at least 10 mm apart.
% If all the above conditions are met, ineqMinInd returns positive value, otherwise it is negative or zero

[x679,obj679,info679,iter679,nf679,lambda679]=sqp([148.00   134.33  -200.00],@widthMinInd,[],@ineqMinInd,lb679,ub679);
% This is a built-in Octave function for minimizing widthMinInd function (objective function). Unfortunately, it usually fails (returns x value very close to the original one and lambda all zeros).
% The documentation for function sqr is available here:  



