function val = local_fun(c,N,idx,pi1,pi2)
array = zeros(1,N);
for i = 1 : N
    array(i) = c*pi1(idx(i,2),idx(i,1))+pi2(idx(i,2),idx(i,1));
end
val = std(array);
end