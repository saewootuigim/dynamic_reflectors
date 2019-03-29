%% Plot adjusted roflectors.
% Run 'lets_optimize_1.m' before running this script.
% close all

rjr = zeros(3,4,n_refl);
A = zeros(3,3,n_refl);
C = lines(n_recv);

for m = 1 : max(xbest)
    tic
    
    figure('Position',[ 488 500 400 220])
    colormap jet
    hold on
    
    % n1 = normal vector of x-y plane
    % n2 = normal vectos of rotated plane
    n1 = [0;0;1];
    for j = 1 : nrow*ncol
        % Calculate rotation matrix R.
        r = xbest(j);
        if r~=m
            continue
        end
        a = rs-rj(j,:);
        a = a'/ norm(a);
        b = rr(r,:)-rj(j,:);
        b = b'/ norm(b);
        n2 = a+b;
        n2 = -n2/norm(n2);
        % b_com = basis vector common to two planes
        b1 = cross(n1,n2);
        b1 = sign(b1(1))*b1/norm(b1); % so that b_com can always direct positive x direction.
        % b2 = the last basis vector of plane 2
        b2 = cross(n2,b1);
        b2 = b2/norm(b2);
        % Rotation with yaw.
        R1 = [b1,b2,n2];
        
        % b1 and b2 are not aligned with x and y axes.
        % This means that the corresponding rotation matrix will yield yaw.
        % To prevent yawing, we must align b1 and b2 to x and y axes.
        th = get_theta(n2,b1);
        % Rotation without yaw.
        R2 = [n2(1)^2+(n2(2)^2+n2(3)^2)*cos(th), n2(1)*n2(2)*(1-cos(th))-n2(3)*sin(th), n2(1)*n2(3)*(1-cos(th))+n2(2)*sin(th);
              n2(1)*n2(2)*(1-cos(th))+n2(3)*sin(th), n2(2)^2+(n2(1)^2+n2(3)^2)*cos(th), n2(2)*n2(3)*(1-cos(th))-n2(1)*sin(th);
              n2(1)*n2(3)*(1-cos(th))-n2(2)*sin(th), n2(2)*n2(3)*(1-cos(th))+n2(1)*sin(th), n2(3)^2+(n2(1)^2+n2(2)^2)*cos(th)];
        R2 = R2*R1;
        
        % Rotate reflector j.
        rjr(:,:,j) = R2*[lx(1:end-1);ly(1:end-1);0,0,0,0] + rj(j,:)';
        
        % Store two basis vectors on rotated plane for future use.
        A(:,:,j) = [ R2(:,1), R2(:,2), -R2(:,3) ];
        
        % source
        hs = plot3(rs(1),rs(2),rs(3),'p','MarkerFaceColor','k','MarkerEdgeColor','k');
        % receiver
        hrcv = plot3(rr(r,1),rr(r,2),rr(r,3),'x','MarkerEdgeColor','k');
        text(rr(r,1),rr(r,2),rr(r,3),sprintf('$\\mathbf{r}_{r%i}$',r),'Interpreter','latex','VerticalAlignment','middle','HorizontalAlignment','center')
        % reflector
        fill3(rjr(1,:,j),rjr(2,:,j),rjr(3,:,j),C(m,:))
        % incident wave
        a = rs-rj(j,:);
        plot3([rj(j,1),rj(j,1)+a(1)],[rj(j,2),rj(j,2)+a(2)],[rj(j,3),rj(j,3)+a(3)],'Color',C(2,:),'LineStyle','-.')
        % reflected wave
        a = rr(r,:)-rj(j,:);
        hr = plot3([rj(j,1),rj(j,1)+a(1)],[rj(j,2),rj(j,2)+a(2)],[rj(j,3),rj(j,3)+a(3)],'Color',C(2,:),'LineStyle','-.');
    end
    
    view([1,.7,.35])
    xlabel('$x$ [m]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    zlabel('$z$ [m]','interpreter','latex')
    axis image
    axis([min(rj(:,1))-1,max(rj(:,1))+1,rs(2),max(rj(:,2))+1,-.5,max(rj(:,3))+1])
    grid on
    ax = gca;
    ax.FontName='Times New Roman';
    hold off
    
    elapse = toc;
    fprintf('%3i/%3i done. %.2f sec.\n',m,max(xbest),elapse)
    
    %print(sprintf('../figures/adjusted_reflectors_recv_%i',m),'-depsc','-painters')
end


figure('Position',[ 488 500 400 220])
colormap jet
hold on

for j = 1 : nrow*ncol
    r = xbest(j);
    % source
    hs = plot3(rs(1),rs(2),rs(3),'p','MarkerFaceColor','k','MarkerEdgeColor','k');
    % receiver
    hrcv = plot3(rr(r,1),rr(r,2),rr(r,3),'x','MarkerEdgeColor','k');
    % reflector
    fill3(rjr(1,:,j),rjr(2,:,j),rjr(3,:,j),C(r,:))
end

view([1,.7,.35])
xlabel('$x$ [m]','interpreter','latex')
ylabel('$y$ [m]','interpreter','latex')
zlabel('$z$ [m]','interpreter','latex')
% legend([hs,hrcv,hr],{'source','receiver','physical path'},'Location','best','NumColumns',2)
axis image
axis([min(rj(:,1))-1,max(rj(:,1))+1,rs(2),max(rj(:,2))+1,-.5,max(rj(:,3))+1])
grid on
ax = gca;
ax.FontName='Times New Roman';
hold off

%print('../figures/adjusted_reflectors_recv_0','-depsc','-painters')


function answer = get_theta(n,b)
syms theta
myfun = (n(1)*n(2)*(1-cos(theta))+n(3)*sin(theta))*b(1)+(n(2)^2+(n(1)^2+n(3)^2)*cos(theta))*b(2)+(n(2)*n(3)*(1-cos(theta))-n(1)*sin(theta))*b(3);
answer = vpasolve(myfun,theta);
end