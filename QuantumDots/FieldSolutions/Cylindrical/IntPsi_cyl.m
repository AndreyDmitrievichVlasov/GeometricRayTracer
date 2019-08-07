function [ f ] = IntPsi_cyl(r,theta,z,r1,theta1,z1, m, m1,varargin)
%INTPSI_CYL Summary of this function goes here
%   Detailed explanation goes here
    if isempty(varargin)
        f = IPsi_Z(z,z1)*IPsi_Theta(theta,theta1)*IPsi_R(r,r1, m,m1, 1,0);
    else
        f = IPsi_Z(z,1)*IPsi_Theta(theta,theta1)*IPsi_R(r, r2, m, m1, A,B);
    end
end

function f = IPsi_R(r,r1, n,n1, A,B)
       if B==0
         f = sum((besselj(n,r).*besselj(n1,r1)*A*A).*r)*(r(2)-r(1));
       else
         f = sum((besselj(n,r).*besselj(n1,r1)*A*A + bessely(n,r).*bessely(n1,r)*B*B).*r)*(r(2)-r(1));    
       end
end


function f = IPsi_Z(Z,Z1)
         f = sum(exp(1i*Z).*exp(-1i*Z1))*(Z(2)-Z(1));
end

function f = IPsi_Theta(theta,theta1)
         f = sum(exp(1i*theta).*exp(-1i*theta1))*(theta(2)-theta(1));
end

