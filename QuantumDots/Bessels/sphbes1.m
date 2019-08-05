function js = sphbes1(nu, x)
% returns the spherical Bessel functions jnu(x)
% x is a vector or it may be a matrix if nu is a scalar
% if nu is a row and x a column vector, the output js is a matrix
% 
% [~, lnu] = size(nu);
% % [nx, lx] = size(x);
% xm = repmat(x, 1, lnu);
% js = sqrt(pi ./(2* xm)) .* besselj(nu + 0.5, x);

js = sqrt(pi./(2*x)) .* besselj(nu + 0.5, x);

end



