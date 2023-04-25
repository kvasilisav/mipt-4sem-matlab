function [normals] = f(triangles, vertices)
% 'triangles' - матрица N*3, содержащая индексы вершин, составляющих треугольники.
% 'vertices' - матрица M*3, содержащая XYZ-координаты вершин.
% 'normals' - матрица M*3, содержащая векторы единичных нормалей в каждой вершине.

faceNormals = cross(vertices(triangles(:,2),:)-vertices(triangles(:,1),:), ...
    vertices(triangles(:,3),:)-vertices(triangles(:,1),:));
faceNormals = faceNormals./sqrt(sum(faceNormals.^2,2));

normals = zeros(size(vertices));

for i=1:size(triangles,1)
    normals(triangles(i,1),:) = normals(triangles(i,1),:) + faceNormals(i,:);
    normals(triangles(i,2),:) = normals(triangles(i,2),:) + faceNormals(i,:);
    normals(triangles(i,3),:) = normals(triangles(i,3),:) + faceNormals(i,:);
end

normals = normals./sqrt(sum(normals.^2,2));

end

