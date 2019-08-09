function [ f ] = IntPsi_cyl_sphr(r, t, z, nu, m, n, nu1, m1, n1, varargin)
%INTPSI_CYL Summary of this function goes here
    %   Detailed explanation goes here
    [r,theta] = meshgrid(r,t);
    %     не учитываются пределы интегрирования 
    if isempty(varargin)
        f =  IPsi_Z(r, theta, n, n1)*IPsi_Theta(t,m, m1)*IPsi_R(r, theta, nu, nu1, m, m1, 1,0);
    else
        f =  IPsi_Z(r, theta, n, n1)*IPsi_Theta(t,m, m1)*IPsi_R(r, theta, nu, nu1, m, m1, A,B);
    end
end

function f = IPsi_R(r,t, nu, nu1, n, n1, A,B)
       if B==0
         f = sum((besselj(n, r.*cos(t)*nu).*besselj(n1, r.*cos(t)*nu1)*A*A).*r)*(r(2)-r(1));
       else
         f = sum((besselj(n, r.*cos(t)*nu).*besselj(n1, r.*cos(t)*nu1)*A*A +...
                       bessely(n, r.*cos(t)*nu).*bessely(n1, r.*cos(t)*nu1)*B*B).*r.*r.*sin(t))*(r(2)-r(1))*(t(2)-t(1));    
       end
end


function f = IPsi_Z(r,t,n,n1)
% правильно ли вписан якобиан?
         f = sum(sum(exp(1i*r.*sin(t)*n).*exp(-1i*r.*sin(t)*n1).*r.*sin(t)))*(t(2)-t(1))*(r(2)-r(1));
end

function f = IPsi_Theta(theta,n, n1)
         f = sum(exp(1i*theta*n).*exp(-1i*theta*n1))*(theta(2)-theta(1));
end

