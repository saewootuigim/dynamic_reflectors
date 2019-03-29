function A = area( p )

[~,n] = size(p);
A = cross(p(:,n),p(:,1));
for i = 1 : n-1
    A = A + cross(p(:,i),p(:,i+1));
end
n = cross(p(:,1)-p(:,2),p(:,3)-p(:,2));
n = n/norm(n);
A = abs(A'*n/2);