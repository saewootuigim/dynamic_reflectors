function bool = inside_or_outside( p0, p1, p2, p3, p4 )

A1 = points_to_area( p1, p2, p3, p4 );
A2 = .5*(norm(cross(p1-p0,p2-p0)) + norm(cross(p2-p0,p3-p0))...
    + norm(cross(p3-p0,p4-p0)) + norm(cross(p4-p0,p1-p0)));

if A2>A1+.001
    bool = 0;
else
    bool = 1;
end
