function width = optWidthGlobal(z)
global MaksTelMatrMin;
detSize=50;
%printf('Length of raysOutMin=%d\n',length(raysOutMin));
width=optWidth(MaksTelMatrMin{3},z,detSize);
end