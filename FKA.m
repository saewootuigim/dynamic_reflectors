function A = FKA( rs, rr, ex, ey, rj, n, lx, ly, N, xi, wi )

% a=1 is set.
% f=4kHz is set.
% lambda = c/f, c=340
% k = 2*pi/lambda = 2*pi*f/340
f = 4000;
lambda = 340/f;
k = 2*pi/lambda;

A = 0;
for i = 1 : N
    for j = 1 : N
        Q = rj + lx*ex*xi(i) + ly*ey*xi(j);
%         plot3(Q(1),Q(2),Q(3),'kx')
        R = rs-Q;
        S = rr-Q;
        r = norm(R);
        s = norm(S);
        cosnr = R'*n/r;
        cosns = S'*n/s;
        A = A - 1i/2/lambda*exp(1i*k*(r+s))/r/s*(cosnr-cosns)*lx*ly*wi(i)*wi(j);
    end
end