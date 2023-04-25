function [vertexAreas] = e(triangles, vertices)

% Вычисляем площадь каждого треугольника
a = vertices(triangles(:,2),:)-vertices(triangles(:,1),:);
b = vertices(triangles(:,3),:)-vertices(triangles(:,1),:);
crossProd = cross(a,b);
triangleAreas = 0.5*sqrt(sum(crossProd.^2,2));

% Инициализируем площадь каждой вершины нулем
vertexAreas = zeros(size(vertices,1),1);

% Добавляем площадь каждого треугольника к площадям соответствующих вершин
for i=1:size(triangles,1)
    vertexAreas(triangles(i,1)) = vertexAreas(triangles(i,1)) + triangleAreas(i);
    vertexAreas(triangles(i,2)) = vertexAreas(triangles(i,2)) + triangleAreas(i);
    vertexAreas(triangles(i,3)) = vertexAreas(triangles(i,3)) + triangleAreas(i);
end

% Устанавливаем площадь каждой вершины как одну треть от общей площади
vertexAreas = vertexAreas./3;

end

