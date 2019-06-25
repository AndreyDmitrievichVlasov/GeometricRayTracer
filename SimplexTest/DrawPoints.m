function  DrawPoints(  )
%DRAWPOINTS Summary of this function goes here
%   Detailed explanation goes here
points=[0 0  randi(10)  randi(10)  randi(10) 0;
            0    randi(10)  randi(10)  randi(10) 0 0];


        
p1=[randi(10);randi(10)];
p2=[randi(10);randi(10)];

if p1(1)==p2(1)
p1(1)=randi(10);
end
if p1(2)==p2(2)
p1(2)=randi(10);
end


[k,b ] = getFuncFromPoints( p1,p2 );

targetfcn=@(x)(k*x+b);

% f=figure(1);

hold on;

fill(points(1,:),points(2,:),'g','FaceAlpha',0.25,'EdgeAlpha',0);
% get(f)

plot([0,max(max(max(points(1,:)),p1(1)),p2(1))],....
    [targetfcn(0),targetfcn(max(max(max(points(1,:)),p1(1)),p2(1)))],'LineWidth',1.7)

plot([p1(1),p2(1)],[p1(2),p2(2)],'bo')

plot(points(1,:),points(2,:),'LineWidth',1.7);
plot(points(1,:),points(2,:),'ro');
hold off;
xlim([0 max(max(max(points(1,:)),p1(1)),p2(1))]);
ylim([0 max(max(max(points(2,:)),p1(2)),p2(2))]);
% get(gca)
% set(get(gca,'Children'),'position',[0 0 1 1]);
set(gca,'xtick',[0:1:10]);

set(gca,'ytick',[0:1:10]);
xlabel('x_{1}');
ylabel('x_{2}');
axis equal;
grid on;

end

