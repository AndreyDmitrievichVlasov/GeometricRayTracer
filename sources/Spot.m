function [ rays ] = Spot( varargin )
%SPOT Summary of this function goes here
%   Detailed explanation goes here
if ~checkInputVars(varargin{:})
    disp('incorrect list of input vars');
    rays=[];
    return;
end
 rays=[];
aperture=[];
apertureType='';
waveLenghts=[];
fields={};
position=[0,0,0];
% L=0;
% N=0,M=0;

L = parseInputVars( 'distance',varargin{:} );
if isempty(L )
    L = 1;
end


position = parseInputVars( 'position',varargin{:} );
if isempty(position )
    position = [0,0,0];
end
apertureType = parseInputVars( 'apertureType',varargin{:} );
if isempty(apertureType )
    apertureType ='rect';
end

aperture = parseInputVars( 'aperture',varargin{:} );
if isempty(aperture )
    aperture =[1 1];
end

waveLenghts = parseInputVars( 'waveLenghts',varargin{:} );
if isempty(waveLenghts )
    waveLenghts =[750 650 550]/1000;%wavelength in micrometers;
end
fields = parseInputVars( 'fields',varargin{:} );
if isempty(fields )
    fields ={[0 0]};
end
N = parseInputVars( 'Nrays',varargin{:} );
if isempty(N )
    N =10;
end

M = parseInputVars( 'Mrays',varargin{:} );
if isempty(M )
    M =10;
end

if strcmp(apertureType,'rect')
    for i=1:length(fields)
            rays=[rays;getRectSpot(position,aperture,N,M,[fields{i},L],waveLenghts)];
    end
elseif strcmp(apertureType,'circ')
    for i=1:length(fields)
            rays=[rays;getCircSpot(position,aperture,N,M,[fields{i},L],waveLenghts)];
    end
else
    for i=1:length(fields)
            rays=[rays;getRectSpot(position,aperture,N,M,[fields{i},L],waveLenghts)];
    end
end
        

end

function rays=getRectSpot(position,aperture,N,M,field,waveLengths)
x_s=linspace(-aperture(1)/2,aperture(1)/2,N);
y_s=linspace(-aperture(2)/2,aperture(2)/2,M);
rays=[];
% N,M
intensity=1;%1/N/M;
for k=1:length(waveLengths)
    color_= getWLColor( waveLengths(k) );
    for i=1:N
        for j=1:M
        p = [x_s(i) y_s(j) 0];
        e = p - field;t=norm(e); e=e/t;
    %     p=p-e*t;
        rays=[rays; [position+field,-e,0,t,waveLengths(k), intensity, color_*intensity]];
        end
    end
end

end


function rays=getCircSpot(position,aperture,N,M,field,waveLengths)
    r_s=linspace(aperture(1),aperture(2),N);
    phi_s=linspace(0,2*pi,M);
    rays=[];
    intensity=1;%1/N/M/max(aperture);
    for k=1:length(waveLengths)
        color_= getWLColor( waveLengths(k) );
        for i=1:N
            for j=1:M
            p_ = [r_s(i)*cos(phi_s(j)) r_s(i)*sin(phi_s(j)) 0];
%             p = p_;
            e = p_ - field;t=norm(e); e=e/t;
        %     p=p-e*t;
            rays=[rays; [position+field,-e,0,t,waveLengths(k), intensity*norm(p_), color_*intensity]];
            end
        end
    end
end