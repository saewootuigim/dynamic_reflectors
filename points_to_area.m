function A = points_to_area( p1, p2, p3, p4 )
% p is array of points M X N, M dimensional point, N points
A = .5*(p1(1)*p2(2) + p2(1)*p3(2) + p3(1)*p4(2) + p4(1)*p1(2)...
      - p2(1)*p1(2) - p3(1)*p2(2) - p4(1)*p3(2) - p1(1)*p4(2));
