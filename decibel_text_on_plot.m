subplot(3,2,zxhsb-3)
hold on
for i = 1 : size(rr,1)
    plot(rr(i,1),rr(i,2),'xr')
    text(rr(i,1),rr(i,2),sprintf('%.3f',resultant(i,4,zxhsb)),'Interpreter','Latex','HorizontalAlignment','center','VerticalAlignment','top')
end
hold off
set(gca,'FontName','Times New Roman')
xlabel('$x$ [m]','Interpreter','Latex')
ylabel('$y$ [m]','Interpreter','Latex')

axis image
axis([-5,5,0,10])