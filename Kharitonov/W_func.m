function  val = W_func( x, y, u, v, sigma, k, f )
%W_FUNCK Summary of this function goes here
%   Detailed explanation goes here



dxdy=(u(1,1)-u(1,2))*(v(1,1)-v(2,1));
% direct way
% difference=sqrt((x-u).^2+(y-v).^2+f^2);
% val=1i*k/2/pi*sum(sum(exp(-(u.^2+v.^2)/2/sigma^2)*...
%                                    exp(1i*pi*Bi(mod(k*sqrt(u.^2+v.^2+f^2),2*pi)))*...
%                                    exp(difference)./difference))*dxdy;
% simplified way
difference=((x-u).^2+(y-v).^2);

val=1i*k/2/pi/f*sum(sum(exp(-(u.^2+v.^2)/2/sigma^2)*...
                                     exp(1i*pi*Bi(mod(-k*(u.^2+v.^2)/2/f, 2*pi)))*...
                                     exp(1i*k*difference)))*dxdy;
end

