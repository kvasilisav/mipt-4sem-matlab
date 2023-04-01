function Dy = c(mesh)
% mesh - структура, задающая триангулированную сетку
% mesh.X - матрица координат вершин сетки
% mesh.T - матрица треугольников сетки

nNodes = size(mesh.X,1);
nElements = size(mesh.T,1);

% Создаем пустые массивы индексов
I = zeros(3*nElements,1);
J = zeros(3*nElements,1);
S = zeros(3*nElements,1);
k = 0;

% Заполняем значения индексов и значений S
for i = 1:nElements
    vertices = mesh.T(i,:);
    x = mesh.X(vertices,:);
    area = abs(det([ones(3,1) x]))/2; % Площадь треугольника
    dphi = [-(x(2,1)-x(3,1)), -(x(3,1)-x(1,1)), -(x(1,1)-x(2,1));...
        x(2,2)-x(3,2), x(3,2)-x(1,2), x(1,2)-x(2,2)]/(2*area); % Производные
    for j = 1:3
        k = k + 1;
        I(k) = vertices(j);
        J(k) = vertices;
        S(k) = dphi(j,:);
    end
end

% Создаем sparse-матрицу оператора частной по y производной
Dy = sparse(I,J,S,nNodes,nNodes);

% Зануляем значения на граничных вершинах
boundaryNodes = unique([mesh.freeBoundary; mesh.holes]); % Номера граничных вершин
Dy(boundaryNodes,:) = 0;
Dy = Dy - diag(sum(Dy,2));
end