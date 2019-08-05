function js = sphbes1m(nu, x)

js = sqrt(pi./(2*x)).* besseli(nu + 0.5, x);

end




