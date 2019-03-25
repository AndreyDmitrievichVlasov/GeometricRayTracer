%% Возврашает структуру описывающую линзу

%% aperture - значение диаметра входной апертуры

%% tickness - толщина линзы 

%% r_1 и r_2 определяют первую и вторую поверхности линзы. 

%% что бы опредилить сферическую поверхность, небходимо передать только радиус, т.е.:
%% length(r_1) или length(r_2) = 1

%% что бы опредилить параболическую поверхность, небходимо передать два параметра, определяющих параболу, т.е.:
%% length(r_1) или length(r_2) = 2

%% что бы опредилить сферическую поверхность, небходимо передать три длины полуосей, т.е.:
%% length(r_1) или length(r_2) = 3

%% Поверхности можно комбинировать. 
 
function [ lens ] = getLens(varargin)
% aperture,tickness,r_1,r_2 
%GETLENS Summary of this function goes here
%   Detailed explanation goes here
if ~checkInputVars(varargin{:})
    disp('incorrect list of input vars');
    lens=[];
    return;
end

% aperture,tickness,r_1,r_2 
aperture = parseInputVars( 'aperture',varargin{:} );
if isempty(aperture )
    aperture =[5 5 0];
end

apertureType = parseInputVars( 'apertureType',varargin{:} );
if isempty(apertureType)
apertureType=2;
end

tickness = parseInputVars( 'tickness', varargin{:} );
if isempty(tickness)
tickness=2;
end

material = parseInputVars( 'material',varargin{:} );
if isempty(material)
material='silica';
end

r_1 = parseInputVars( 'r1',varargin{:} );
if isempty(r_1)
r_1=-15;
end

r_2 = parseInputVars( 'r2',varargin{:} );
if isempty(r_2)
r_2=15;
end

lens=initDefaultLens(aperture, tickness,r_1,r_2, apertureType);
    if ischar(material)
             rI=Materials(material);
             lens.materialDispersion=@(lam)(dispersionLaw(lam, rI.refractionIndexData));
             lens.material=rI;
     else
        disp('Incorrect material definition. Default material will be applied')
     end
end


function lens = initDefaultLens(aperture, tickness,r_1,r_2, appType)

if length(aperture)==1
    front_surf = flatQuad( [0 aperture 0], appType,[0 0 0],[0 0 0]);
elseif length(aperture)==2
    front_surf = flatQuad( [aperture(1) aperture(2) 0], appType,[0 0 0],[0 0 0]);
elseif length(aperture)==3
    front_surf = flatQuad( [aperture(1) aperture(2) aperture(3)], appType,[0 0 0],[0 0 0]);
end

front_surf  = getSurfaceType(front_surf,r_1);


% back_surf  = flatQuad( [0 aperture 0], 2,[0 0 0],[0 0 tickness]);
if length(aperture)==1
    back_surf = flatQuad( [0 aperture 0], appType,[0 0 0],[0 0 tickness]);
elseif length(aperture)==2
    back_surf = flatQuad( [aperture(1) aperture(2) 0], appType,[0 0 0],[0 0 tickness]);
elseif length(aperture)==3
    back_surf = flatQuad( [aperture(1) aperture(2) aperture(3)], appType,[0 0 0],[0 0 tickness]);
end

back_surf  = getSurfaceType(back_surf,r_2);

rI=Materials('silica');
lens=struct('frontSurface',front_surf,'backSurface',back_surf,'tickness',tickness,'apertureData',aperture,'apertureType',appType,'material',...
                rI,'materialDispersion',@(lam)(dispersionLaw(lam, rI.refractionIndexData)),'type','lens');
end

function n = dispersionLaw(lam, Ndata)

n    =    sqrt(1  +    Ndata(1)*lam.^2./(lam.^2-Ndata(2)^2)...
                      +    Ndata(3)*lam.^2./(lam.^2-Ndata(4)^2)+...
                            Ndata(5)*lam.^2./(lam.^2-Ndata(6)^2));

end

 function surfdata=getSurfaceType(surfdata,R)

    if length(R)==1
       surfdata  = convertQuad2Sphere(surfdata,R);
    end
    if length(R)==2
       surfdata  = convertQuad2Paraboloid(surfdata,R(1),R(2));
    end
    if length(R)==3
       surfdata = convertQuad2Ellipsoid( surfdata,R(1),R(2),R(3));
    end
end
