%[x, obj, info, iter, nf, lambda] = sqp (x0, phi)
%[…] = sqp (x0, phi, g, h, lb, ub, maxiter, tol)

backMen=[45,-362.8,100,108.9,20,140,120,11.6,-108.9];
% initial parameters for Back Menisc configuration
%lb=[backMen(1)-0.01,backMen(2)-0.01,-300,-300,7,60,50,backMen(8)-0.01,-300];
lb=[backMen(1)-0.01,backMen(2)-0.01,backMen(3)-0.01,backMen(4)-0.01,7,60,50,backMen(8)-0.01,-300];
ub=[backMen(1)+0.01,backMen(2)+0.01,backMen(3)+0.01,backMen(4)+0.01,30,250,230,backMen(8)+0.01,0];

[x,obj,info,iter,nf,lambda]=sqp(backMen,@widthMaksTelParGlobal,[],@ineqsecmirr,lb,ub);

