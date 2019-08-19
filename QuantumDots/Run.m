 Init();
 [ Nu_n_p, E_n_p, C_n_p] =  CalcCylField(0.1,10, 0.025, 10, 10, 10);
% 
% [ f_roots ] = findRoots( @(x)(besselj(0,x)),'N',100,'acc',100);
% 
% 
% for i=1:50
%     f_roots1  = [f_roots1; findRoots( @(x)(besselj(i,x)),'N',100,'acc',500)];
% end
% figure()
% hold on;
% grid on;
% t=linspace(0,50,1000);
% % plot(t,besselj(0,t),'g');
% plot(f_roots,abs(besselj(0,f_roots)),'*r');
% plot(f_roots1,abs(besselj(0,f_roots1(1,:))),'*b');