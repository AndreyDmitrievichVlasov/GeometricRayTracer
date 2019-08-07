function [ f ] = Psi_cyl( r,theta,z, m,varargin )
%PSI_CYL Summary of this function goes here
%   Detailed explanation goes here

        [r,z,t] = meshgrid(r,z,theta);
        
        f = Psi_Z(z).*Psi_Theta(t);

        if isempty(varargin)
           f = f.*Psi_R(r, m, 1, 1);
           f=squeeze(f);
           return;
        end
        
        if length(varargin)==1
            f = f.*Psi_R(r, m, varargin{1}, 0); 
            f=squeeze(f);
            return;
        end
         
        if length(varargin)==2
           f = f.*Psi_R(r, m, varargin{1}, varargin{2});
           f=squeeze(f);
           return;
        else
            f = f.*Psi_R(r, m, 1, 1);
            f=squeeze(f);
            return;
        end
end

function f = Psi_R(r, n, A, B)

        f = besselj(n,r)*A + bessely(n,r)*B;

end


function f = Psi_Z(Z)
         f = exp(1i*Z);
end

function f = Psi_Theta(theta)
         f = exp(1i*theta);
end
