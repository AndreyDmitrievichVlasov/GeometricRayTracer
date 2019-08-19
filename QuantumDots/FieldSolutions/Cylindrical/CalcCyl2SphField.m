function [ Nu_n_p, E_n_p, C_n_p ] = CalcCyl2SphField( r_0,energyLevels, d, M, N, P )
%CALCCYL2SPHFIELD Summary of this function goes here
%   Detailed explanation goes here
besselRoots = dlmread('besselRoots_m_1_51_n_roots_100.dat');

if energyLevels>size(besselRoots,1)
    energyLevels=size(besselRoots,1);
end
if energyLevels<=0
    energyLevels=1;
end
MaxRoots=energyLevels;

rootsIDX=1:MaxRoots;

k_c=linspace(-2*pi/d,2*pi/d,P);



% E_n_p = zeros(N,M,P,MaxRoots);
E_n_p = cell(N,M);% zeros(N,M,P,MaxRoots);
C_n_p =  cell(N,M);%zeros(N,M,P,MaxRoots);

% E = linspace(Energy(1), Energy(2),1000);

statment1 = 'Computing K_n_p and E_n_p' ;
statment2 = 'Computing C_n_p ' ;
progress = 'total progress is ';
Nu_n_p = cell(N,M);% zeros(N,M,P,MaxRoots);

%    [root,k_n_p] = meshgrid(besselRoots(1,rootsIDX),k_c);
   
   
for n=1:N
            disp(statment1);
            disp([progress,num2str(n/N*100) ' %'])
            k_n_p = 2 * pi * n / d + k_c;
            for m=1:M
                
                [root,k_n_p_] = meshgrid(besselRoots(m,rootsIDX),k_n_p);
                
                e = root.^2+(k_n_p_).^2;       
                
                Nu_n_p {n,m}=root;
             
                E_n_p  {n,m} = e;
            end
           clc;
end
   t = linspace(0,1,1000);
    r=r_0*t;
    z=d*t;
    theta = t*2*pi;
    c_tmp=zeros(P,length(rootsIDX));
    
    for n=1:N
        for m=1:M
         
             disp(statment1);
             disp([progress,'100 %']);
             disp(statment2);   
             disp([progress,num2str((N*(n-1)+m)/(M*N)*100) ' %'])
          
             nu=Nu_n_p{n,m};
             
             for p=1:P
                k_n_p = 2 * pi * n / d + k_c(p);
                 for e=rootsIDX
                       c_tmp(p,e) = IntPsi_cyl_sphr(  r, theta, z,...
                                                      nu, m, k_n_p,...
                                                      nu, m, k_n_p);
                  end
             end
             C_n_p{n,m}=c_tmp;
            clc;
        end
    end
%     
%     field=struct('Nu_n_m_p_e',Nu_n_p,'C_n_m_p_e',C_n_p,'E_n_m_p_e',E_n_p,'Kp',k_c,'Decsription',...
%         'n - orbital wave digit, m - radial wave digit, p - parametr index, e - energy spectrum item number');


end

