% clear
close all

%% Experiment Configuration
nrow = 10;
ncol = 10;
n_refl = nrow*ncol;

hx = .95;
hy = .95;

lx = [-hx/2, hx/2 ,hx/2, -hx/2, -hx/2];
ly = [-hy/2, -hy/2, hy/2, hy/2, -hy/2];

rs = [ 0, -5, 1.5 ];
rj = zeros(n_refl,3);
for i = 1 : nrow
    y = (i-1)*(hy+.1)+1;
    for j = 1 : ncol
        k = (i-1)*ncol+j;
        x = (j-1-(ncol-1)/2)*(hx+.1);
        rj(k,:) = [ x, y, 6 ];
    end
end

markers = ['^','o','s','x','*','d','+','v','>','<'];

%% Receiver Partterns
clear SPL_field_name;

% This range should change if rr is added or removed.
if ~exist('resultant','var')
    resultant = zeros(20,5,9);
end
for zxhsb = 4 : 4
    switch(zxhsb)
        case 1
            % B
            rr = [   -2.3721    2.8500         0
                     0    2.8500         0
               -2.3721    4.2250         0
                2.3721    3.7712         0
                2.3721    4.6925         0
               -2.3721    5.6000         0
                     0    5.6000         0
               -2.3721    6.9750         0
                2.3721    7.4287         0
                2.3721    6.5075         0
               -2.3721    8.3500         0
                     0    8.3500         0];
            SPL_field_name = 'SPL_field_B';
        case 2
            % C
            rr = [1.9998    7.8981         0
                0.5655    8.5743         0
               -0.9833    8.3189         0
               -2.1615    7.2119         0
               -2.6000    5.6000         0
               -2.1615    3.9881         0
               -0.9833    2.8811         0
                0.5655    2.6257         0
                1.9998    3.3019         0];
            SPL_field_name = 'SPL_field_C';
        case 3
            % D
            rr = [
               -1.6700    2.3000         0
                0.1300    2.7555         0
                1.4477    4.0000         0
                1.9300    5.7000         0
                1.4477    7.4000         0
                0.1300    8.6445         0
               -1.6700    9.1000         0
               -1.6700    7.4000         0
               -1.6700    5.7000         0
               -1.6700    4.0000         0];
            SPL_field_name = 'SPL_field_D';
        case 4
            % Pentagram
            rr =[0.0000    7.8798         0
               -2.7389    5.8899         0
               -1.6927    2.6702         0
                1.6927    2.6702         0
                2.7389    5.8899         0
               -0.0000    3.9000         0
                1.0462    4.6601         0
                0.6466    5.8899         0
               -0.6466    5.8899         0
               -1.0462    4.6601         0];
            SPL_field_name = 'SPL_field_Pentagram';
        case 5
            % Spiral
            rr = [   -0.8000    6.5000         0
               -0.5196    6.6802         0
               -0.5231    7.1064         0
               -0.9423    7.4898         0
               -1.6731    7.5077         0
               -2.3992    6.9696         0
               -2.7190    5.9365         0
               -2.3280    4.7366         0
               -1.1795    3.8605         0
                0.4462    3.7711         0
                2.0042    4.6979         0
                2.8667    6.5000         0];
            SPL_field_name = 'SPL_field_Spiral';
        case 6
            % A
            rr = [   -2.3721    2.8500         0
                2.3721    2.8500         0
               -1.7791    4.2250         0
                1.7791    4.2250         0
               -1.1860    5.6000         0
                     0    5.6000         0
                1.1860    5.6000         0
                0.5930    6.9750         0
               -0.5930    6.9750         0
                     0    8.3500         0];
            SPL_field_name = 'SPL_field_A';
        case 7            
            % J
            rr = [ 1.1000    8.5800         0
                1.1000    7.3200         0
                1.1000    6.0600         0
                1.1000    4.8000         0
               -1.9000    3.5400         0
               -1.4607    2.7480         0
               -0.4000    2.4200         0
                0.6607    2.7480         0
                1.1000    3.5400         0];
            SPL_field_name = 'SPL_field_J';
        case 8
            % O
            rr = [ -2.0000    3.4000         0
               -1.4142    2.4808         0
                0.0000    2.1000         0
                1.4142    2.4808         0
                2.0000    3.4000         0
                2.0000    7.8000         0
                1.4142    8.7192         0
                0.0000    9.1000         0
               -1.4142    8.7192         0
               -2.0000    3.4000         0
               -2.0000    4.8667         0
               -2.0000    6.3333         0
               -2.0000    7.8000         0
                2.0000    3.4000         0
                2.0000    4.8667         0
                2.0000    6.3333         0];
            SPL_field_name = 'SPL_field_O';
        case 9
            % U
            rr =[ -2.0000    3.6800         0
               -2.0000    5.2933         0
               -2.0000    6.9067         0
               -2.0000    8.5200         0
                2.0000    3.6800         0
                2.0000    5.2933         0
                2.0000    6.9067         0
                2.0000    8.5200         0
               -1.4142    2.5911         0
                0.0000    2.1400         0
                1.4142    2.5911         0];
            SPL_field_name = 'SPL_field_U';
    end

n_recv = size(rr,1);
C = lines(n_recv);

% %% Draw
% figure('Position',[97, 165.8, 610, 500])
% 
% subplot(2,2,3)
% plot_all_script
% view([0,-1,0])
% wh = [14.3,6];
% ax.Position = [1,1,wh/2.5];
% ax.FontSize = 9.5;
% xlabel('$x$ [m]','interpreter','latex')
% zlabel('$z$ [m]','interpreter','latex')
% title('(c) Front view. (from the stage)','FontName','Times New Roman','FontWeight','normal')
% 
% subplot(2,2,4)
% plot_all_script
% view([1,0,0])
% wh = [17.4,6];
% ax.Position = [9,1,wh/2.5];
% ax.FontSize = 9.5;
% ylabel('$y$ [m]','interpreter','latex')
% zlabel('$z$ [m]','interpreter','latex')
% title('(d) Side view. (from right)','FontName','Times New Roman','FontWeight','normal')
% 
% subplot(2,2,1)
% plot_all_script
% view([0,0,1])
% wh = [14.3,17.4];
% ax.Position = [1,5.4,wh/2.5];
% ax.FontSize = 9.5;
% xlabel('$x$ [m]','interpreter','latex')
% ylabel('$y$ [m]','interpreter','latex')
% title('(a) Plan view. (from the top)','FontName','Times New Roman','FontWeight','normal')
% 
% subplot(2,2,2)
% plot_all_script
% view([1,-.7,.5])
% wh = [17.4,17.4];
% ax.Position = [9,5.4,wh/2.5];
% ax.FontSize = 9.5;
% grid on
% xlabel('$x$ [m]','interpreter','latex')
% ylabel('$y$ [m]','interpreter','latex')
% zlabel('$z$ [m]','interpreter','latex')
% title('(b) Bird view.','FontName','Times New Roman','FontWeight','normal')
% ax.Position(2) = 6.9;
% 
% axis image
% 
% hleg = legend([hs,hrcv,href],{'src.','recv. 1','recv. 2','recv. 3','reflectors'},...
%     'NumColumns',3);
% hleg.Position = [0.58 .4 0.38 0.12];
% hleg.FontName = 'Times New Roman';
% hleg.FontSize = 9.5;

% print('../figures/experiment_layout','-depsc','-painters')

%% Optimization
% setup
FitnessFunction = @(x) minimize_this(rs,rj,x,rr);
% opts = gaoptimset('PlotFcns',{@gaplotbestf,@gaplotbestindiv},'UseParallel',true);
opts = optimoptions(@ga, ...
                    'PopulationSize',200, ...
                    'MaxGenerations', 900, ...
                    'EliteCount', 40, ...
                    'FunctionTolerance', 1e-12, ...
                    'ConstraintTolerance',1e-12, ...
                    'PlotFcn', @gaplotbestcustom);
lb = ones(1,n_refl);
ub = lb*n_recv;
IntCon = 1:n_refl;
NonLinConst = @(x) nonlinear_constraints(rs,rj,x,rr);

% optimization
global a; % This is to store objective function value over generation
a = zeros(900,3);
[xbest, fbest, exitflag, output, population, scores] =...
    ga(FitnessFunction, n_refl, [], [], [], [], lb, ub, [], IntCon, opts);

% plot convergence
close all
figure('Position',[34.6000  340.2000  350 161])
hold on
xmax = output.generations;
plot(a(1:xmax,1),a(1:xmax,2),'.')
plot(a(1:xmax,1),a(1:xmax,3),'*','MarkerSize',5)
xlim([0,xmax])
ax = gca;
ax.FontName = 'Times New Roman';
xlabel('generation','FontName','Times New Roman')
ylabel('obj. function val.','FontName','Times New Roman')
legend('mean','best','FontName','Times New Roman','FontSize',9.5)
text(xmax*2/3,(max(a(1:xmax,2))+min(a(1:xmax,2)))/2.5,...
    sprintf('mean=%.4f\nbest=%.4f',a(xmax,2),a(xmax,3)),...
    'FontName','Times New Roman',...
    'horizontalalignment','center','verticalalignment','middle','FontSize',9.5)

% print('../figures/convergence','-depsc','-painters')

%% Print the SPLs at each focal point.
resultant(20,1,zxhsb) = size(rr,1);
for i = 1 : size(rr,1)
    resultant(i,1:3,zxhsb) = rr(i,:);
    resultant(i,4,zxhsb) = SPL(rs,rj(xbest==i,:),rr(i,:));
end

lets_optimize_3
lets_optimize_4
end