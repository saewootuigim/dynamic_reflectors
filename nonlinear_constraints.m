function [C, Ceq] = nonlinear_constraints(rs,rj,x,rr)

Ceq = [];
C = zeros(2*length(x));

for j = 1 : length(x)
    %  pitch (on y-z plane)
    aaa = rs(2:3)-rj(j,2:3);
    bbb = rr(x(j),2:3)-rj(j,2:3);
    ccc = [rj(j,2),0]-rj(j,2:3);
    th1 = acos(aaa*bbb'/norm(aaa)/norm(bbb));
    if th1<0
        fprintf('strange... rj%03i=(%.4f,%.4f)\n',j,rj(j,1),rj(j,2))
        th1 = th1 + pi;
    end
    th2 = acos(bbb*ccc'/norm(bbb)/norm(ccc));
    if th2<0
        fprintf('strange... rj%03i=(%.4f,%.4f)\n',j,rj(j,1),rj(j,2))
        th2 = th2 + pi;
    end
    pitch = -th1/2+th2;
    % roll (on z-x plane)
    aaa = rs([3,1])-rj(j,[3,1]);
    bbb = rr(x(j),[3,1])-rj(j,[3,1]);
    ccc = [0,rj(j,1)]-rj(j,[3,1]);
    th1 = acos(aaa*bbb'/norm(aaa)/norm(bbb));
    if th1<0
        fprintf('strange... rj%03i=(%.4f,%.4f)\n',j,rj(j,1),rj(j,2))
        th1 = th1 + pi;
    end
    th2 = acos(bbb*ccc'/norm(bbb)/norm(ccc));
    if th2<0
        fprintf('strange... rj%03i=(%.4f,%.4f)\n',j,rj(j,1),rj(j,2))
        th2 = th2 + pi;
    end
    roll = th1/2-th2;
    C(2*j-1) = abs(pitch)-0.5236; % 0.5236 rand == 30 degree
    C(2*j  ) = abs(roll)-0.5236;
end