%% Plot sound level field.

%% Kirchhoff Diffraction Formula
fprintf('Kirchhoff Diffraction Formula\nThis process takes at least 1 min.\n')

% frequency
f = 4000;
% other dependent variables
lambda = 340/f;
k = 2*pi/lambda;
% amplitude
a = 1;

% number of quadrature points
N = 19;
% number of mesh points per dimension
M = 101;

% quadrature points and weights
[ xi1, wi1 ] = lgwt(N,-1,1);
[ xi2, eta2 ] = meshgrid(xi1*hx/2,xi1*hy/2);
wi2 = (wi1*hx/2)*(wi1*hy/2)';
xi3 = reshape(xi2,1,[]);
eta3 = reshape(eta2,1,[]);
wi3 = reshape(wi2,1,[]);
qi = [xi3;eta3;zeros(size(xi3))];
% plot3(qi(1,:),qi(2,:),qi(3,:),'x'); hold on

% receiver points
x = linspace(-5,5,M);
y = linspace(0,10,M);
[ xi, yi ] = meshgrid(x,y);
xi1 = reshape(xi,1,[]);
yi1 = reshape(yi,1,[]);
rrcv = [xi1;yi1;zeros(size(xi1))];

%% Kirchhoff diffraction formula
zi1 = zeros(size(xi1));


% for each mesh point i
progress = 10;
t_out = tic;
for i = 1 : size(rrcv,2)
    
    % for each reflecting panel J
    for j = 1 : size(rj,1)
    
        % imaginary source
        b = (rs-rj(j,:))';
        Ay = A(:,1:2,j)*((A(:,1:2,j)'*A(:,1:2,j))\(A(:,1:2,j)'*b));
        w = Ay-b;
        rs_imag = rs'+2*w;

        q = A(:,:,j)*qi+rj(j,:)';
        temp = rs_imag-q;
        r = sqrt(sum(temp.^2));
        cosnr = (A(:,3,j)'*temp)./r;

        nj2 = A(:,3,j)';

        temp = rrcv(:,i)-q;
        s = sqrt(sum(temp.^2));
        cosns = (nj2*temp)./s;
        zi1(i) = zi1(i) + abs(sum(exp(1i*k*(r+s))./(r.*s).*(cosnr-cosns).*wi3))^2;
    end
    
    % print progress
    if i/size(rrcv,2)*100>progress || i==size(rrcv,2)
        t2 = toc;
        fprintf('  %3i%% done. %.2f sec.\n',round(i/size(rrcv,2)*100),t2)
        tic
        progress = progress + 10;
    end
end
t2 = toc(t_out);
fprintf('<----- total elapse %.4f sec. ----->\n\n',t2)

zi1 = reshape(zi1,M,M);

%% Directly coming sound
zi2 = (a/4/pi)^2./sum((rs'-rrcv).^2);
zi2 = reshape(zi2,M,M);

%% Plot
% close all

% pcolor
figure('Position',[100,468,330,280])
colormap gray
hold on

pcolor(xi,yi,10*log10(zi1+zi2)); shading flat
colorbar

ax = gca;
ax.FontName = 'Times New Roman';

xlabel('$x$ [m]','Interpreter','LaTeX')
ylabel('$y$ [m]','Interpreter','LaTeX')
axis image

% print(sprintf('../../figures/%s_1',SPL_field_name),'-depsc','-painters')
% print(sprintf('../../figures/%s_1',SPL_field_name),'-dpng','-painters')

% test
figure('Position',[100,468,330,280])
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

% print(sprintf('../../figures/%s_2',SPL_field_name),'-depsc','-painters')
% print(sprintf('../../figures/%s_2',SPL_field_name),'-dpng','-painters')