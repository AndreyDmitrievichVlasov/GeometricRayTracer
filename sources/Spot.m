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


RaysPerField = M*N*length(waveLenghts);
rays = zeros(RaysPerField*length(fields),13);

if L==0
    if strcmp(apertureType,'rect')
        for i=1:length(fields)
            
                rays((i-1)*RaysPerField+1:RaysPerField*i,:) =...
                    getRectSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation);
%                 rays=[rays;getRectSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation)];
        end
    elseif strcmp(apertureType,'circ')
        for i=1:length(fields)
            rays((i-1)*RaysPerField+1:RaysPerField*i,:) =...
                getCircSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,radialModulation);
%                 rays=[rays;getCircSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,radialModulation)];
        end
    else
        for i=1:length(fields)
             rays((i-1)*RaysPerField+1:RaysPerField*i,:) =...
                 getRectSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation);
%                 rays=[rays;getRectSpotParaxial(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation)];
        end
    end
else
    if strcmp(apertureType,'rect')
        for i=1:length(fields)
                rays((i-1)*RaysPerField+1:RaysPerField*i,:) =...
                    getRectSpot(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation);
%                 rays=[rays;getRectSpot(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation)];
        end
    elseif strcmp(apertureType,'circ')
        for i=1:length(fields)
             rays((i-1)*RaysPerField+1:RaysPerField*i,:) =...
                 getCircSpot(position,aperture,N,M,[fields{i},L],waveLenghts,radialModulation);
%                 rays=[rays;getCircSpot(position,aperture,N,M,[fields{i},L],waveLenghts,radialModulation)];
        end
    else
        for i=1:length(fields)
             rays((i-1)*RaysPerField+1:RaysPerField*i,:) =...
                 getRectSpot(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation);
%                 rays=[rays;getRectSpot(position,aperture,N,M,[fields{i},L],waveLenghts,xModulation,yModulation)];
        end
    end
end
        

end

function rays=getRectSpot(position,aperture,N,M,field,waveLengths,modFuncX,modFuncY)

dx = aperture(1)/(N - 1); 

dy = aperture(2)/(M - 1); 

raysPerWL = N*M;
    
rays = zeros(raysPerWL * length(waveLengths),13);

intensity=1;

for k=1:length(waveLengths)
   
    color_= getWLColor( waveLengths(k) );
    
    xs = -aperture(1)/2;
       
    for i=1:N
         
          idx = (i-1)*N;
         
         ys = -aperture(2)/2;
      
         for j = 1:M
                idx = idx + 1;
                p = [xs ys 0];
                e = p - field; t = norm(e); e=e/t;
               intence= modFuncX(xs)*modFuncY(ys)*intensity;
                rays(raysPerWL*(k-1) + idx,1:3) = position-field;
                rays(raysPerWL*(k-1) + idx,4:6) = -e;
                rays(raysPerWL*(k-1) + idx, 7) = 0;
                rays(raysPerWL*(k-1) + idx, 8) = 1;
                rays(raysPerWL*(k-1) + idx, 9) = waveLengths(k);
                rays(raysPerWL*(k-1) + idx, 10) = intence;
                rays(raysPerWL*(k-1) + idx, 11:13) = getTrueColor(intence,color_);
                ys=ys+dy;
        end
        xs = xs + dx;
    end
end

end

function rays=getCircSpot(position,aperture,N,M,field,waveLengths,modFunc)
%     r_s = linspace(aperture(1),aperture(2),N);
%     
%     phi_s = linspace(0,2*pi,M);

    dphi = 2*pi/(M-1); 
    
    dr = (aperture(2)-aperture(1))/(N-1);
    
    intensity = 1;%1/N/M/max(aperture);
    
    raysPerWL = N*M;
    
    rays = zeros(raysPerWL * length(waveLengths),13);

    %     raysPerWL*(k-1) +
    
    for k=1:length(waveLengths)
        
        color_= getWLColor( waveLengths(k) );
        
        rs = aperture(1);
             
        for i = 1:N
            
            phis = 0;
            
            idx = (i-1)*N;
            
            for j = 1:M
                idx = idx + 1;
                p_ = [rs*cos(phis) rs*sin(phis) 0];
                e = p_ - field;t=norm(e); e=e/t;
                intence= modFunc(phis)*intensity*norm(p_)/max(aperture);
                rays(raysPerWL*(k-1) + idx,1:3) = position-field;
                rays(raysPerWL*(k-1) + idx,4:6) = -e;
                rays(raysPerWL*(k-1) + idx, 7) = 0;
                rays(raysPerWL*(k-1) + idx, 8) = 1;
                rays(raysPerWL*(k-1) + idx, 9) = waveLengths(k);
                rays(raysPerWL*(k-1) + idx, 10) = intence;
                rays(raysPerWL*(k-1) + idx, 11:13) = getTrueColor(intence,color_);
                phis=phis + dphi;
            end
            rs=rs+dr;
        end
    end
end

function rays = getRectSpotParaxial(position,aperture,N,M,field,waveLengths,modFuncX,modFuncY)
% x_s=linspace(-aperture(1)/2,aperture(1)/2,N);
% y_s=linspace(-aperture(2)/2,aperture(2)/2,M);

dx = aperture(1)/(N - 1); 

dy = aperture(2)/(M - 1); 

raysPerWL = N*M;
    
rays = zeros(raysPerWL * length(waveLengths),13);

intensity=1;

for k=1:length(waveLengths)
  
    color_= getWLColor( waveLengths(k) );
    
    xs = -aperture(1)/2;
     
    for i=1:N
         
          idx = (i-1)*N;
         
          ys = -aperture(2)/2;
         
        for j = 1:M
                idx = idx + 1;
                p = [xs ys 0]+ [field(1) field(2) 0];
                e=[0 0 1];
                intence= modFuncX(xs)*modFuncY(ys)*intensity;
                rays( raysPerWL*(k-1) + idx,1:3) =position + p;
                rays( raysPerWL*(k-1) + idx,4:6) = e;
                rays( raysPerWL*(k-1) + idx, 7) = 0;
                rays( raysPerWL*(k-1) + idx, 8) = 1;
                rays( raysPerWL*(k-1) + idx, 9) = waveLengths(k);
                rays( raysPerWL*(k-1) + idx, 10) = intence;
                rays( raysPerWL*(k-1) + idx, 11:13) = getTrueColor(intence,color_);
                ys = ys + dy;
        end
        xs = xs + dx;
    end
end

end

function rays = getCircSpotParaxial(position,aperture,N,M,field,waveLengths,modFunc)
%     r_s=linspace(aperture(1),aperture(2),N);
%     
%     phi_s=linspace(0,2*pi,M);
  
    dphi = 2*pi/(M-1);     
    
    dr = (aperture(2)-aperture(1))/(N-1); 
    
    intensity=1;%1/N/M/max(aperture);
 
    raysPerWL = N*M;
    
    rays = zeros(raysPerWL * length(waveLengths),13);
    
    for k = 1:length(waveLengths)
        
        color_ = getWLColor( waveLengths(k) );
      
        rs = aperture(1);
        
%         phis = 0;
           
        for i = 1:N
            idx = (i-1)*N;
            phis = 0;
            for j = 1:M
                idx = idx + 1;
                p_ = [rs*cos(phis) rs*sin(phis) 0]+ [field(1) field(2) 0];
                e = [0 0 1];
                intence = modFunc(phis)*intensity*norm(p_)/max(aperture);
                rays(raysPerWL*(k-1) + idx,1:3) = p_+position;
                rays(raysPerWL*(k-1) + idx,4:6) = e;
                rays(raysPerWL*(k-1) + idx, 7) = 0;
                rays(raysPerWL*(k-1) + idx, 8) = 1;
                rays(raysPerWL*(k-1) + idx, 9) = waveLengths(k);
                rays(raysPerWL*(k-1) + idx, 10) = intence;
                rays(raysPerWL*(k-1) + idx, 11:13) = getTrueColor(intence,color_);
                phis = phis + dphi;
            end
            rs = rs + dr;
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