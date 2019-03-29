hold on
hs = plot3(rs(1),rs(2),rs(3),'p','MarkerEdgeColor','k');
marker_i = 1;
for i = 1 : 3
    hrcv(i) = plot3(rr(i,1),rr(i,2),rr(i,3),markers(marker_i),'MarkerEdgeColor','k');
    marker_i = marker_i + 1;
end
for i = 1 : nrow
    for j = 1 : ncol
        k = (i-1)*ncol+j;
        plot3(rj(k,1)+lx,rj(k,2)+ly,rj(k,3)+[0,0,0,0,0],'Color',C(1,:))
    end
end

href = fill(NaN,NaN,'w','EdgeColor',C(1,:));

hold off
ax = gca;
ax.FontName = 'Times New Roman';
ax.Units = 'centimeters';