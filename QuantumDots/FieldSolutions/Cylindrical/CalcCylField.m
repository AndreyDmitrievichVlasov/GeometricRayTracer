function [ field ] = CalcCylField(r_0,energyLevels, d, M, N, P)
%CALCCYLFIELD Summary of this function goes here
%   Detailed explanation goes here
% searching roots
% Number_K_C=10;

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


% foreach Energy level we get a set of k_c therefore forech item from k_c
% set we get Nu_n_m and Coeff_n_m

Nu_n_p = zeros(N,M,P,MaxRoots);

E_n_p = zeros(N,M,P,MaxRoots);

C_n_p = zeros(N,M,P,MaxRoots);

% E = linspace(Energy(1), Energy(2),1000);

statment1 = 'Computing K_n_p and E_n_p' ;
statment2 = 'Computing C_n_p ' ;
progress = 'total progress is ';
% disp(statment);
% disp([progress,num2str((Number_K_C*(p-1)*n)/(Number_K_C*N))*100 ' %'])



for p=1:P
        for n=1:N
            disp(statment1);
            disp([progress,num2str((P*(p-1)+n)/(P*N)*100) ' %'])
            k_n_p = 2 * pi * n / d + k_c(p);
            for m=1:M
                root = besselRoots(m,rootsIDX);
                
                e = root.^2+(k_n_p)^2;       
                
                Nu_n_p(n,m,p,rootsIDX) = root;
                
                E_n_p(n,m,p,rootsIDX) = e;
            end
               clc;
        end
end


    t = linspace(0,1,1000);
    r=r_0*t;
    z=d*t;
    theta = t*2*pi;
    
    for p=1:P
        for n=1:N
         
             disp(statment1);
             disp([progress,'100 %']);
             disp(statment2);   
             disp([progress,num2str((P*(p-1)+n)/(P*N)*100) ' %'])
             
             k_n_p = 2 * pi * n / d + k_c(p);
             
             for m=1:M
                for e=rootsIDX
                       nu=Nu_n_p(n,m,p,e);
                       C_n_p(n,m,p,e) =  IntPsi_cyl(  r, theta, z,...
                                                                   nu, m, k_n_p,...
                                                                   nu, m, k_n_p);
                end
             end
            clc;
        end
    end
    
    field=struct('Nu_n_m_p_e',Nu_n_p,'C_n_m_p_e',C_n_p,'E_n_m_p_e',E_n_p,'Decsription',...
        'n - orbital wave digit, m - radial wave digit, p - parametr index, e - energy spectrum item number');
end

 



