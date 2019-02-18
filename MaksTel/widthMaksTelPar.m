function [width,zf]=widthMaksTelPar(MaksTelPar,nrays,delta)
global raysOutMin;
[mt,b]=getMaksTel(MaksTelPar(1),MaksTelPar(2),MaksTelPar(3),MaksTelPar(4),MaksTelPar(5),MaksTelPar(6),MaksTelPar(7),MaksTelPar(8),MaksTelPar(9)); 
raysIn=paraxialSpotHom([0 0 -1000],[MaksTelPar(8) MaksTelPar(1)],nrays);
[~,~,raysOut] = traceThroughSystem(raysIn,mt);
raysOutMin=raysOut;
deflam=0.55;
[matr,newdir,firstvertex,lastvertex,zfmatr]=getMatrix(mt,deflam,1);
delta=abs(delta); % just in case someone will supply negative delta
defdelta=10;
if delta<0.5
 delta=defdelta;
end
absolutemin=20;
absolutemax=1500;
time_to_exit=0;
zmin=max(absolutemin,zfmatr-delta);
zmax=min(absolutemax,zfmatr+delta);
prevwidth=100;
eps=0.001;
zfp=-100;
do 
 [zfc,wc,info,output]=fminbnd(@optWidthGlobal,zmin,zmax);
 if abs(zfc-zmin)<eps
  if abs(zfp-zmin)<eps
   time_to_exit=1;
  else
   if abs(zmin-absolutemin)<eps
    printf('The optimal image is closer than absolutezmin=%.1f. Returning absolutezmin\n',absolutemin); 
    time_to_exit=1;
   else
    zmax=zmin;
    zmin=max(absolutemin,zmin-defdelta);
   end 
  end 
 elseif zmax-zfc<eps
  if abs(zmax-zfp)<eps
   time_to_exit=1;
  else
   if abs(zmax-absolutemax)<eps
    printf('The optimal image is further than absolutemax=%.1f. Returning absolutemax\n',absolutemax); 
    time_to_exit=1;
   else
    zmin=zmax;
    zmax=min(absolutemax,zmax+5*defdelta);
   end
  end
 else
  time_to_exit=1;
 end
 if ~time_to_exit
  zfp=zfc;
 end 
until(time_to_exit)
 
if info==0
 printf('Maximum number of iterations of function evaluations reached\n');
elseif info==-1
 printf('The minimum search algorithm was terminated from user defined function\n');
end 

end