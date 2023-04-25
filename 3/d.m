function L = d(tri, vertices)
% tri - матрица соединений, описывающая триангуляцию, каждая строка содержит индексы вершин, образующих треугольник
% vertices - координаты вершин триангуляции, каждая строка содержит координаты вершины (x, y)
% L - разреженная матрица оператора Лапласа

% Проводим вычисления для каждого из трех ребер треугольника и сохраняем в векторе
edge_lengths = zeros(size(tri, 1)*3, 1); 
k = 1;
for i = 1:size(tri, 1)
    for j = 1:3
        if j == 3
            next = 1;
        else
            next = j+1;
        end
        v1 = vertices(tri(i, j), :);
        v2 = vertices(tri(i, next), :);
        edge_lengths(k) = norm(v1 - v2);
        k = k + 1;
    end
end

% Формируем матрицу оператора Лапласа
m = size(vertices, 1); 
n = size(tri, 1); 
I = zeros(n*3, 1); 
J = zeros(n*3, 1); 
V = zeros(n*3, 1); 
idx = 1; 
for i = 1:n
    I(idx:idx+2) = tri(i, :);
    J(idx:idx+2) = tri(i, :); 
    V(idx:idx+2) = edge_lengths((i-1)*3+1:i*3).^(-1); 
    idx = idx + 3;
end
L = sparse(I, J, -V, m, m); 
L = L + diag(sum(L, 2)); 
end
