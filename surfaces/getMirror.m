function [ mir ] = getMirror(aperture,r,orient,pos)
% getZer - orient - orientation, pos - position
mir = flatQuad( 2*aperture,2*aperture,orient,pos);

if length(r)==1
    mir = convertQuad2Sphere(mir,r);
end
if length(r)==2
    mir = convertQuad2Paraboloid(mir,r(1),r(2));
end
if length(r)==3
    mir = convertQuad2Ellipsoid( mir,r(1),r(2),r(3));
end

%schema{2}.extraDataType = strcat(schema{2}.extraDataType,'_mirror') ;
mir.extraDataType = strcat(mir.extraDataType,'_mirror') ;

% fprintf('mir.extraDataType=%s\n',mir.extraDataType);

end
