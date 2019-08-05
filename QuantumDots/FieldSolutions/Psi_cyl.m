function [ f ] = Psi_cyl( r,theta,z,n,m,varargin )
%PSI_CYL Summary of this function goes here
%   Detailed explanation goes here
    f= Psi_R(r,m,varargin).*Psi_Z(z*n).*Psi_Theta(theta,m);

end

function f = Psi_R(r, n, A,B, varargin)
        if isempty(varargin)
           f = besselj(n,r)*A+bessely(n,r)*B; return;
        end
        
         if length(varargin)==1
           f = besselj(n,r)*varargin{1}; return;
         end
        if length(varargin)==2
           f = besselj(n,r)*varargin{1}+bessely(n,r)*varargin{2}; return;
        end
            
        
end


function f = Psi_Z(Z)
         f = exp(1i*Z);
end

function f = Psi_Theta(theta,n)
         f = exp(1i*n*theta);
end
