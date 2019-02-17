function width = optWidthGlobal(z)
global raysOutMin;
detSize=50;
%printf('Length of raysOutMin=%d\n',length(raysOutMin));
width=optWidth(raysOutMin,z,detSize);
end