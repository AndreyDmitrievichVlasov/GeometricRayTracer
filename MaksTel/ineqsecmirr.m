function [retval]=ineqsecmirr(mtp)
 global MaksTelMatrMin; % we store in in this the structure in order not to generate it every time
% MaksTelMatrMin{1} - schema, MaksTelMatrMin{2} - matrix of that scheme 
 global absolutemax,absolutemin;
% MaksTelMatrMin{1} - schema of Maksutov telescope, MaksTelMatrMin{2} - matrix of Maksutiv telescope
 if checkMaksTelPars(mtp,MaksTelMatrMin{1})
  schema=MaksTelMatrMin{1};
  matr=MaksTelMatrMin{2};
  zf=schema{3}.position(3)-matr(1,1)/matr(2,1);
 else  
  [matr,newdir,firstvertex,lastvertex,zf,schema]=getMatrixMaksPar(mtp);
  MaksTelMatrMin{1}=schema;
  MaksTelMatr{2}=matr;
 end
 menisc=schema{1};
 mm=schema{2};
 sm=schema{3}; 
 valarray(1)=(absolutemax-zf)*(zf-absolutemin); 
% this thing is positive whenever zf is between absolutemin and absolutemax
 if menisc.backSurface.position(3)!=sm.position(3) 
  valarray(length(valarray)+1)=menisc.backSurface.position(3)-sm.position(3)-10;
% if they coincide, we don't care at all, but they don't, they have to be at least 10 mm apart  
 end
 signretval=+1; % by default, the sign is positive meaning this set of parameters is allowed
 retval=1;
 for i=1:length(valarray)
  if valarray(i)<0
   signretval=-1;
   retval*=(-valarray(i));
  else 
   retval*=valarray(i);
  end
 end
 retval*=signretval;
end