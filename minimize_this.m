function z = minimize_this(rs,rj,p_idx,rr)
% rs is source location, size(rs) = [ 1, 3 ]
% rj is reflector locations, size(rj) = [ M, 3 ] where M is the number of
%   reflectors.
% p_idx is permutation index which is the combination of integers to be
%   optimized.
% rr is receiver location, size(rr) = [ N, 3 ] where N is the number of
%   receivers

persistent n
if isempty(n)
    n = 0;
end
n = n+1;

N = size(rr,1);
SPLs = zeros(1,N);
for i = 1 : N
    SPLs(i) = SPL(rs,rj(p_idx==i,:),rr(i));
end
z = std(SPLs)-sum(SPLs);
% fprintf('%4i %.4e %.4e\n',n,std(SPLs),sum(SPLs))