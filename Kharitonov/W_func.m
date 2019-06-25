function  val = W_func( x, y, u, v, sigma, lam, f )
%W_FUNCK Summary of this function goes here
%   Detailed explanation goes here
dxdy=(u(1,1)-u(1,2))*(v(1,1)-v(2,1));
% direct way
difference=sqrt((x-u).^2+(y-v).^2+f^2);


  val=1i/lam*exp(-(u.^2+v.^2)/2/sigma^2).*exp(-1i*2*pi/lam*sqrt(u.^2+v.^2+f^2)).*exp(1i*2*pi/lam*difference)./difference;
% val=1i/lam*exp(-(u.^2+v.^2)/2/sigma^2).*exp(1i*pi*Bi(mod(Phi(u,v,f,lam),2*pi))).*exp(1i*2*pi/lam*difference)./difference;
%  val=1i/lam*exp(-(u.^2+v.^2)/2/sigma^2).*exp(-1i*2*pi/lam*sqrt((sqrt(u.^2+v.^2)-0.001^2)+f^2)).*exp(1i*2*pi/lam*difference)./difference;
% val=exp(1i*pi*Bi(mod(k*sqrt(u.^2+v.^2+f^2),2*pi))).*exp(difference)./difference;
val=sum(sum(val))*dxdy;

end