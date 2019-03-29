%% Develop letters.
close

N = 2.2;

th = linspace(-pi,0,5);
x = 2*cos(th);
y = 1.3*sin(th);

rr = [x',y'-N,zeros(size(x))'];

rr =[0,0,0];
rr(1:4,1) = -2;
rr(1:4,2) = linspace(-N,N,4);

rr(5:8,1) = 2;
rr(5:8,2) = linspace(-N,N,4);

th = linspace(-pi*3/4,-pi/4,3);
x = 2*cos(th);
y = 1.4*sin(th)-N;
rr(9:11,1) = x;
rr(9:11,2) = y;

rr(:,2) = rr(:,2)*1.1 + 6.1;

plot(rr(:,1),rr(:,2),'.','MarkerSize',10)
axis image
axis([-5,5,0,10])