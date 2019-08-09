function [ f ] = IntPsi_cyl(r, theta, z, nu, m, n, nu1, m1, n1, varargin)
%INTPSI_CYL Summary of this function goes here
%   Detailed explanation goes here
    if isempty(varargin)
        f =  IPsi_Z(z, n, n1)*IPsi_Theta(theta,m, m1)*IPsi_R(r,nu,nu1, m, m1, 1,0);
    else
        f =  IPsi_Z(z, n, n1)*IPsi_Theta(theta,m, m1)*IPsi_R(r,nu,nu1, m, m1, A,B);
    end
end

function f = IPsi_R(r, nu, nu1, n, n1, A,B)
       if B==0
         f = sum((besselj(n, r*nu).*besselj(n1, r*nu1)*A*A).*r)*(r(2)-r(1));
       else
         f = sum((besselj(n, r*nu).*besselj(n1, r*nu1)*A*A + bessely(n, r*nu).*bessely(n1, r*nu1)*B*B).*r)*(r(2)-r(1));    
       end
end


function f = IPsi_Z(Z,n,n1)
         f = sum(exp(1i*Z*n).*exp(-1i*Z*n1))*(Z(2)-Z(1));
end

function f = IPsi_Theta(theta,n, n1)
         f = sum(exp(1i*theta*n).*exp(-1i*theta*n1))*(theta(2)-theta(1));
end

