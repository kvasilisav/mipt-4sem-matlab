function [h] = c_voronoi(a, b, c)
    % вычисление координат узлов ячейки Вигнера-Зейтца
    M = cell(7,1);
    M{1} = [0 0 0];
    M{2} = [0.5 0.5 0.5];
    M{3} = [0.5 0.5 0];
    M{4} = [0.5 0 0.5];
    M{5} = [0 0.5 0.5];
    M{6} = [0 0.5 0];
    M{7} = [0 0 0.5];
    
    % вычисление периодических векторов ячейки
    e1 = cross(b,c)/norm(cross(b,c));
    e2 = cross(c,a)/norm(cross(c,a));
    e3 = cross(a,b)/norm(cross(a,b));
    
    % вычисление координат узлов ячейки Вигнера-Зейтца в новой системе координат
    X = zeros(3,7);
    for i = 1:7
        X(:,i) = e1*M{i}(1) + e2*M{i}(2) + e3*M{i}(3);
    end
   
    dt = delaunayTriangulation(X);

    [V,R] = voronoiDiagram(dt);
    
    
    
    tid = nearestNeighbor(dt,0,0,0);
    XR10 = V(R{tid},:);
    K = convhull(XR10);
    defaultFaceColor  = [0.6875 0.8750 0.8984];

    h = figure;
    hold on;

    trisurf(K, XR10(:,1) ,XR10(:,2) ,XR10(:,3) , ...
            'FaceColor', defaultFaceColor, 'FaceAlpha',0.8)
    title('3-D Voronoi Region')

end

