function [ field ] = CalcCylField(r_0,Energy, d, M, N)
%CALCCYLFIELD Summary of this function goes here
%   Detailed explanation goes here
% searching roots
Number_K_C=10;

MaxRoots=10;

k_c=linspace(-2*pi/d,2*pi/d,Number_K_C);

K_n_p = zeros(N,M,Number_K_C,MaxRoots);

E_n_p = zeros(N,M,Number_K_C,MaxRoots);

C_n_p = zeros(N,M,Number_K_C,MaxRoots);

E = linspace(Energy(1), Energy(2),256);
    for p=1:Number_K_C
        for n=1:N
            for m=1:M
                r = findK_n_p(r_0*sqrt(E-(2*pi*n/d+k_c(p))^2),m)/r_0;
                e = -r.^2+(2*pi*n/d+k_c(p))^2;
                
                K_n_p(n,m,p,:) = r(1:min(MaxRoots, length(r)));
                E_n_p(n,m,p,:) = e(1:min(MaxRoots, length(r)));
            end
        end
    end

    t = linspace(0,1,1000);
    r=r_0*t;
    z=r_0*t;
    
    for p=1:Number_K_C
        for n=1:N
            for m=1:M
                for e=1:MaxRoots
                     C_n_p(n,m,p,e) = findC_n_m(r*K_n_p(n,m,p,e),z*(2*pi*n/d+k_c(p)),theta,n,m);
                end
            end
        end
    end
    
    field=struct('K_n_m_p_e',K_n_p,'C_n_m_p_e',C_n_p,'E_n_m_p_e',E_n_p,'Decsription',...
        'n - orbital wave digit, m - radial wave digit, p - parametr index, e - energy spectrum item number');
end


function K_n_p = findK_n_p(E,m)

 K_n_p = findRoots(@(E)(Psi_cyl( r_0*E,0,0,0,m,1)),[E(1) E(length(E))],length(E)*4);

end

function C_n_m = findC_n_m(r,z,theta,n,m)

 C_n_m = 1/sum(Psi_cyl( r,z,theta,n,m,1).*Psi_cyl( r,z,theta,n,m,1).*r);
 
end
