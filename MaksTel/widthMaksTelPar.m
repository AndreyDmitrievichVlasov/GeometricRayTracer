function [width,zf]=widthMaksTelPar(MaksTelPar,nrays,delta)
global raysOutMin;
[mt,b]=getMaksTel(MaksTelPar(1),MaksTelPar(2),MaksTelPar(3),MaksTelPar(4),MaksTelPar(5),MaksTelPar(6),MaksTelPar(7),MaksTelPar(8),MaksTelPar(9)); 
raysIn=paraxialSpotHom([0 0 -1000],[MaksTelPar(8) MaksTelPar(1)],nrays);
[~,~,raysOut] = traceThroughSystem(raysIn,mt);
raysOutMin=raysOut;
deflam=0.55;
[matr,newdir,firstvertex,lastvertex,zfmatr]=getMatrix(mt,deflam,1);
delta=abs(delta); % just in case someone will supply negative delta
if delta<0.5
 delta=10;   
end
[zf,width,info,output]=fminbnd(@optWidthGlobal,zfmatr-delta,zfmatr+delta);
if info==0
 printf('Maximum number of iterations of function evaluations reached\n');
elseif info==-1
 printf('The minimum search algorithm was terminated from user defined function\n');
end 
end