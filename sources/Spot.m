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
% radialModulation;
% xModulation;
% yModulation;
% L=0;
% N=0,M=0;
radialModulation = parseInputVars( 'radialModulation',varargin{:} );
if isempty(radialModulation )
    radialModulation = @(theta)(1);%10^10;
end

xModulation= parseInputVars( 'xModulation',varargin{:} );
if isempty(xModulation )
   xModulation = @(x)(1);%10^10;
end

yModulation = parseInputVars( 'yModulation',varargin{:} );
if isempty(yModulation )
    yModulation = @(y)(1);%10^10;
end




L = parseInputVars( 'distance',varargin{:} );
if isempty(L )
    L = 0;%10^10;
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

if L==0
    if strcmp(apertureType,'rect')
        for i=1:length(fields)
                rays=[rays;getRectSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation)];
        end
    elseif strcmp(apertureType,'circ')
        for i=1:length(fields)
                rays=[rays;getCircSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,radialModulation)];
        end
    else
        for i=1:length(fields)
                rays=[rays;getRectSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation)];
        end
    end
else
    if strcmp(apertureType,'rect')
        for i=1:length(fields)
                rays=[rays;getRectSpot(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation)];
        end
    elseif strcmp(apertureType,'circ')
        for i=1:length(fields)
                rays=[rays;getCircSpot(position,aperture,N,M,[fields{i},L],waveLenghts,radialModulation)];
        end
    else
        for i=1:length(fields)
                rays=[rays;getRectSpot(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation)];
        end
    end
end
        

end

function rays=getRectSpot(position,aperture,N,M,field,waveLengths,modFuncX,modFuncY)
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
        intence= modFuncX(x_s(i))*modFuncY(y_s(i))*intensity;
        rays=[rays; [position+field,-e,0,t,waveLengths(k),intence,  getTrueColor(intence,color_)]];
        end
    end
end

end


function rays=getCircSpot(position,aperture,N,M,field,waveLengths,modFunc)
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
             intence= modFunc(phi_s(j))*intensity*norm(p_)/max(aperture);
             rays=[rays; [position+field,-e,0,t,waveLengths(k),intence,  getTrueColor(intence,color_)]];
            end
        end
    end
end


%%%%



function rays=getRectSpotParaxial(position,aperture,N,M,field,waveLengths,modFuncX,modFuncY)
x_s=linspace(-aperture(1)/2,aperture(1)/2,N);
y_s=linspace(-aperture(2)/2,aperture(2)/2,M);
rays=[];
% N,M
intensity=1;%1/N/M;
for k=1:length(waveLengths)
    color_= getWLColor( waveLengths(k) );
    for i=1:N
        for j=1:M
        p = [x_s(i) y_s(j) 0]+ [field(1) field(2) 0];
        e=[0 0 1];
        intence= modFuncX(x_s(i))*modFuncY(y_s(i))*intensity;
        rays=[rays; [position + p,e,0,1,waveLengths(k), intence,  getTrueColor(intence,color_)]];
        end
    end
end

end


function rays=getCircSpotParaxial(position,aperture,N,M,field,waveLengths,modFunc)
    r_s=linspace(aperture(1),aperture(2),N);
    phi_s=linspace(0,2*pi,M);
    rays=[];
    intensity=1;%1/N/M/max(aperture);
    for k=1:length(waveLengths)
        color_= getWLColor( waveLengths(k) );
        for i=1:N
            for j=1:M
            p_ = [r_s(i)*cos(phi_s(j)) r_s(i)*sin(phi_s(j)) 0]+ [field(1) field(2) 0];
%             p = p_;
             e=[0 0 1];
        %     p=p-e*t;
            intence= modFunc(phi_s(j))*intensity*norm(p_)/max(aperture);
            rays=[rays; [p_+position,e,0,1,waveLengths(k),intence, getTrueColor(intence,color_)]];
            end
        end
    end
end

function col = getTrueColor(intence,col)
t=1-intence;
colDir=[1 1 1]-col;%colDir=colDir;%/norm(colDir);
col=col+colDir*t;

col=col - (col-1).*(col>1);
col=col - col.*(col<0);

end