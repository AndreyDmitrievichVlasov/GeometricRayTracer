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
function [ lens ] = getAxicon(varargin)

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

conusParams = parseInputVars( 'conusData',varargin{:} );
if isempty(conusParams)
r_1=[10 10 10];
end

lens=createAxicon( aperture, apertureType, tickness,conusParams);%initDefaultLens(aperture, tickness,r_1,r_2, apertureType);
    if ischar(material)
             rI=Materials(material);
             lens.materialDispersion=@(lam)(dispersionLaw(lam, rI.refractionIndexData));
             lens.material=rI;
     else
        disp('Incorrect material definition. Default material will be applied')
     end

end




function [ lens ] = createAxicon( aperture, appType, tickness,conusParams)
%GETLENS Summary of this function goes here
%   Detailed explanation goes here
if length(conusParams)~=3
    disp('incorrect conus data');
    return;
end

if length(aperture)==1
    front_surf = flatQuad( [0 aperture 0], appType,[0 0 0],[0 0 0]);
elseif length(aperture)==2
    front_surf = flatQuad( [aperture(1) aperture(2) 0], appType,[0 0 0],[0 0 0]);
elseif length(aperture)==3
    front_surf = flatQuad( [aperture(1) aperture(2) aperture(3)], appType,[0 0 0],[0 0 0]);
end

front_surf=convertQuad2Sphere(front_surf, 10^10);


if length(aperture)==1
    back_surf = flatQuad( [0 aperture 0], appType,[0 0 0],[0 0 tickness]);
elseif length(aperture)==2
    back_surf = flatQuad( [aperture(1) aperture(2) 0], appType,[0 0 0],[0 0 tickness]);
elseif length(aperture)==3
    back_surf = flatQuad( [aperture(1) aperture(2) aperture(3)], appType,[0 0 0],[0 0 tickness]);
end


back_surf=convertQuad2Conus(back_surf, conusParams(1),conusParams(2),conusParams(3));

rI=Materials('silica');
lens=struct('frontSurface',front_surf,'backSurface',back_surf,'tickness',tickness,'aperture',aperture,'material',...
                rI,'materialDispersion',@(lam)(dispersionLaw(lam, rI.refractionIndexData)),'type','lens');


end
function n = dispersionLaw(lam, Ndata)

n    =    sqrt(1  +    Ndata(1)*lam.^2./(lam.^2-Ndata(2)^2)...
                      +    Ndata(3)*lam.^2./(lam.^2-Ndata(4)^2)+...
                            Ndata(5)*lam.^2./(lam.^2-Ndata(6)^2));

end

