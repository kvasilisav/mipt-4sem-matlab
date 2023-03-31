function [surfaceVertices, surfaceEdges, surfaceTriangles] = b(vertices)
    DT = delaunayTriangulation(vertices);
    % Получение списка тетраэдров
    tetrahedra = DT.ConnectivityList;
    
    % Извлечение "поверхностных" тетраэдров
    boundaryTetrahedra = freeBoundary(DT);
    
    % Получение списка "поверхностных" вершин
    surfaceVertices = unique(boundaryTetrahedra(:));
    
    % Создание списка "поверхностных" рёбер и треугольников
    surfaceEdges = [];
    surfaceTriangles = [];
    
    for i=1:size(boundaryTetrahedra,1)
        % Получение списка рёбер тетраэдра
        edges = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
        
        % Отбор только "поверхностных" рёбер
        boundaryEdges = edges(~ismember(edges,boundaryTetrahedra(i,:)));
        
        % Добавление "поверхностных" рёбер в список
        surfaceEdges = [surfaceEdges; boundaryEdges];
        
        % Добавление "поверхностных" треугольников в список
        for j=1:size(boundaryEdges,1)
            connectedTriangles = triangulationNeighbors(DT,boundaryEdges(j,:));
            if connectedTriangles(1) ~= 0 && connectedTriangles(2) ~= 0
                surfaceTriangles = [surfaceTriangles; [boundaryEdges(j,:) connectedTriangles']];
            end
        end
    end
    
    % Отображение результатов
    trisurf(surfaceTriangles,surfaceVertices(:,1),surfaceVertices(:,2),surfaceVertices(:,3),'FaceColor','r','FaceAlpha',0.3);
    hold on;
    plot3(surfaceVertices(:,1),surfaceVertices(:,2),surfaceVertices(:,3),'k*');
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

end