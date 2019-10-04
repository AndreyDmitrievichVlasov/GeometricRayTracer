% This function generates the Spherical Harmonics basis functions of degree
% L and order M.
%
% SYNTAX: [Ymn,THETA,PHI,X,Y,Z]=spharm4(L,M,RES,PLOT_FLAG);
%
% INPUTS:
%
% L         - Spherical harmonic degree, [1x1]
% M         - Spherical harmonic order,  [1x1]
% RES       - Vector of # of points to use [#Theta x #Phi points],[1x2] or [2x1] 
% PLOT_FLAG - Binary flag to generates a figure of the spherical harmonic surfaces (DEFAULT=1)
%
%
% OUTPUTS:
% 
% Ymn   - Spherical harmonics coordinates, [RES(1) x RES(2)]
% THETA - Circumferential coordinates, [RES(1) x RES(2)]
% PHI   - Latitudinal coordinates, [RES(1) x RES(2)]
% X,Y,Z - Cartesian coordinates of magnitude, squared, spherical harmonic surface points, [RES(1) x RES(2)]


function [Ymn,THETA,PHI,X,Y,Z]=spharm(varargin)% L,M,RES,PLOT_FLAG)

% Define constants (REQUIRED THAT L(DEGREE)>=M(ORDER))

if(mod(length(varargin),2)~=0)
    error('The number of key paramrtrs is not equal to nuber of value parametrs or vice versa')
end

L = getValueByKey(varargin,'L');
if isempty(L)
    L = 2;
end;

M = getValueByKey(varargin,'M');
if isempty(M)
    M = 2;
end;

if L<M
    error('The ORDER (M) must be less than or eqaul to the DEGREE(L).');
end


RES = getValueByKey(varargin,'resolution');
if isempty(RES)
    RES=[64 64];
end;

PLOT_FLAG = getValueByKey(varargin,'Display');
if isempty(PLOT_FLAG)
    PLOT_FLAG = 0;
end;


Phi_theta = getValueByKey(varargin,'angles');
if ~isempty(Phi_theta)
      RES=[];
end;

if isempty(RES)
    [Ymn,THETA,PHI,X,Y,Z] = createMeshAngles(L,M,Phi_theta);
else
    [Ymn,THETA,PHI,X,Y,Z] = createMesh(L,M,RES);
end
    if PLOT_FLAG
        DisplaySphHarm(Ymn,THETA,PHI,M,L)
    end
end

function DisplaySphHarm(Ymn,THETA,PHI,M,L)
[Xm,Ym,Zm]=sph2cart(THETA,PHI-pi/2,abs(Ymn));C_m=sqrt(Xm.^2+Ym.^2+Zm.^2);
[Xr,Yr,Zr]=sph2cart(THETA,PHI-pi/2,real(Ymn));C_r=sqrt(Xr.^2+Yr.^2+Zr.^2);
[Xi,Yi,Zi]=sph2cart(THETA,PHI-pi/2,imag(Ymn));C_i=sqrt(Xi.^2+Yi.^2+Zi.^2);

% f=gcf; axis off;
f = figure('Name','Spherical Harmonics');
    subplot(1,3,1)
        surface(Xm,Ym,Zm, C_m,'EdgeColor','none','FaceColor','interp');
        view(-35,45)
        light; lighting phong; camzoom(1.3);
        title(['|Y^',num2str(M),'_',num2str(L),'|']);
        colorbar();
        axis equal
        
    subplot(1,3,2)
        surface(Xr,Yr,Zr, C_r,'EdgeColor','none','FaceColor','interp');
        view(-35,45)
        light; lighting phong; camzoom(1.3);
        title(['Real(Y^',num2str(M),'_',num2str(L),')']);
        colorbar();
        axis equal
        
    subplot(1,3,3)
        surface(Xi,Yi,Zi, C_i,'EdgeColor','none','FaceColor','interp');
        view(-35,45)
        light; lighting phong; camzoom(1.3);
        title(['Imag(Y^',num2str(M),'_',num2str(L),')']);
        colorbar();
        axis equal
end


function val = getValueByKey(params,key)
    val=[];
    for i=1:2:length(params)
        if strcmp(key,params{i})
             val=params{i+1};
            return;  
        end
    end
end

function [Ymn,THETA,PHI,X,Y,Z] = createMesh(L,M,RES)
    THETA=linspace(0,2*pi,RES(1));  % Azimuthal/Longitude/Circumferential
    PHI  =linspace(0,  pi,RES(2));  % Altitude /Latitude /Elevation

    [THETA,PHI]=meshgrid(THETA,PHI);

    Lmn=legendre(L,cos(PHI));

    if L~=0
      Lmn=squeeze(Lmn(M+1,:,:));
    end

        a1=((2*L+1)/(4*pi));

        a2=factorial(L-M)/factorial(L+M);

        C=sqrt(a1*a2);

        Ymn=C*Lmn.*exp(1i*M*THETA);

        [X,Y,Z]=sph2cart(THETA,PHI-pi/2,Ymn);
end


function [Ymn,THETA,PHI,X,Y,Z] = createMeshAngles(L,M,Phi_theta)
    THETA=Phi_theta(1);  % Azimuthal/Longitude/Circumferential
    PHI  =Phi_theta(2);  % Altitude /Latitude /Elevation

%     [THETA,PHI]=meshgrid(THETA,PHI);

    Lmn=legendre(L,cos(PHI));

    if L~=0
      Lmn=squeeze(Lmn(M+1,:,:));
    end

        a1=((2*L+1)/(4*pi));

        a2=factorial(L-M)/factorial(L+M);

        C=sqrt(a1*a2);

        Ymn=C*Lmn.*exp(1i*M*THETA);

        [X,Y,Z]=sph2cart(THETA,PHI-pi/2,Ymn);
end
