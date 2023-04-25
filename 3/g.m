function W = g(mesh)
% mesh - структура, задающая триангулированную поверхность
% mesh.X - матрица координат вершин поверхности
% mesh.T - матрица треугольников поверхности

nNodes = size(mesh.X,1);
nElements = size(mesh.T,1);

% Создаем пустые массивы индексов и значений
I = zeros(3*nElements,1);
J = zeros(3*nElements,1);
S = zeros(3*nElements,1);
k = 0;

% Вычисляем расстояния между всеми парами вершин
D = pdist2(mesh.X,mesh.X);

% Заполняем значения индексов и значений S
for i = 1:nElements
    vertices = mesh.T(i,:);
    for j = 1:3
        k = k + 1;
        I(k) = vertices(j);
        J(k) = vertices;
        S(k) = 1./D(vertices(j),vertices);
    end
end

% Создаем sparse-матрицу обратных расстояний
W = sparse(I,J,S,nNodes,nNodes);

% Зануляем значения на граничных вершинах
boundaryNodes = unique([mesh.freeBoundary; mesh.holes]); % Номера граничных вершин
W(boundaryNodes,:) = 0;
W = W - diag(sum(W,2));
end

