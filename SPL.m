function z = SPL(rs,rj,rr)
% This function calculates the sum of 1/r at rr
% where r is the distance from rs to rj + distance from rj to rr.

y = 0;
for j = 1 : size(rj,1)
    y = y + 1/sum((rs-rj(j,:)).^2+(rj(j,:)-rr).^2);
end
z = 10*log10(y/sum((rs-rr).^2));