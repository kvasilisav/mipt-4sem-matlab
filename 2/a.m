function [tri,edge] = a(points)
    tri = delaunayTriangulation(points');
    triplot(tri,'b');
    hold on;
    edge = freeBoundary(tri);
    plot(points(edge(:,1),1),points(edge(:,1),2),'r','LineWidth',2);
    axis equal;
end