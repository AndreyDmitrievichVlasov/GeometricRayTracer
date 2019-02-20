function [width,zf]=widthMaksTelPar(MaksTelPar,nrays,delta)
global raysOutMin;
global absolutemax,absolutemin;
global MaksTelMatrMin; % we store in in this the structure in order not to generate it every time
% MaksTelMatrMin{1} - schema, MaksTelMatrMin{2} - matrix of that scheme. MaksTelMatrMin{3} - what is used to be called raysOutMin
% raysOutMin is changed only together with 
[mt,b]=getMaksTel(MaksTelPar(1),MaksTelPar(2),MaksTelPar(3),MaksTelPar(4),MaksTelPar(5),MaksTelPar(6),MaksTelPar(7),MaksTelPar(8),MaksTelPar(9)); 
raysIn=paraxialSpotHom([0 0 -1000],[MaksTelPar(8) MaksTelPar(1)],nrays);
[~,~,raysOut] = traceThroughSystem(raysIn,mt);
deflam=0.55;
[matr,newdir,firstvertex,lastvertex,zfmatr]=getMatrix(mt,deflam,1);
printf('zfmatr=%.3f\n',zfmatr);
raysOutMin=raysOut;
delta=abs(delta); % just in case someone will supply negative delta
defdelta=10;
if delta<0.5
 delta=defdelta;
end
%absolutemin=-100;
%absolutemax=1500;
time_to_exit=0;
if zfmatr>=absolutemin && zfmatr<absolutemax
 zmin=max(absolutemin,zfmatr-delta);
 zmax=min(absolutemax,zfmatr+delta);
else 
 if zfmatr<absolutemin 
  zmin=absolutemin;
  zmax=absolutemin+delta; 
 elseif zfmatr>absolutemax
  zmin=absolutemax-delta;
  zmax=absolutemax;
 else
  printf('GOL Internal error. Unexpected \n');
  width=100;
  zf=-500;
  return;
 end
end 
prevwidth=100;
eps=0.001;
zfp=-100;
wp=100;
do 
 [zfc,wc,info,output]=fminbnd(@optWidthGlobal,zmin,zmax);
 if abs(zfc-zmin)<eps
  if abs(zfp-zmin)<eps
   time_to_exit=1;
  else
   if abs(zmin-absolutemin)<eps
    printf('The optimal image is closer than absolutemin=%.1f. Returning absolutemin\n',absolutemin); 
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
  wp=wc;
 end 
until(time_to_exit)

width=wc;
zf=zfc;
 
if info==0
 printf('Maximum number of iterations of function evaluations reached\n');
elseif info==-1
 printf('The minimum search algorithm was terminated from user defined function\n');
end 

end