function [retarr]=netMinArr(objfun,lb,ub,addargs,narr,varargin)
% Same as netMin, but returns an array of first n lower values  
% netMinArr(objfun,lb,ub,addargs,narr,N,conFun)
% N - number of point along given dimension.
% x - is a matrix, x(1,:) is the abolute minimum, x(2,:) second smallest etc
% obj - the same
% This feature is not implemented yet: If length(N)==1, then N is number of point along all dimensions  
% retarr(j,1) - value of objective function, retarr(j,2:l+1) - vector argument where this value is reached
global outfilename;
l=length(lb);
retarr=[];
defN=4;
numsteps=500; % every numsteps steps we will dump the array of the smallest values so far
haveconstr=0;
if narr<=0
 printf('Error, narr=%d, should be >0\n',narr);  
 narr=10; 
end
if nargin==5 
 np(1:l)=defN;
 prodnp=defN^l;
elseif nargin==6 || nargin==7
 if length(varargin{1})!=l
  printf('Wrong lenngth of 6th srgument to netMin. It must be the same length as lb and ub\n');
  np(1:l)=defN;
  prodnp=defN^l;     
 else
  np=varargin{1};
  prodnp=1;
  for i=1:l
   prodnp*=np(i);
  end
 end 
else
 printf('In netMin, wrong number of arguments=%d. netMin expects 5-7 arguments',nargin);
 x=obj=0;
 return; 
end 
constfun=0;
if nargin==7
 haveconstr=1;
 constfun=varargin{2}; 
end
for i=0:(prodnp-1)
 curi=i;
 for j=1:l
  n(j)=mod(curi,np(j));
  xc(j)=lb(j)+(ub(j)-lb(j))*(0.5+n(j))/np(j);
  curi/=np(j);
  curi=floor(curi); 
 end
 if(~haveconstr || constfun(xc,addargs)>0)
  vc=objfun(xc,addargs);
  if rows(retarr)<narr || vc<retarr(end,1) % then we add xc in x array
   retarr=insertInArray(retarr,[vc,xc]);
   if rows(retarr)>narr
    retarr(narr+1,:)=[]; % remove extra row from the array retarr 
   end
  end
 end
 if i>0 && ~mod(i,numsteps) % then we dump the smallest values so far
  save('-append',outfilename,'retarr');
 end
end
end
