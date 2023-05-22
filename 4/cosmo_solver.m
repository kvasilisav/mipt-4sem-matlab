function [W, Ws, sg] = cosmo_solver(XYZ, Q, P, S, e_in)

% Получение матриц взаимных расстояний между вершинами сетки
RDist = rev_dist(P, XYZ);
QRDist = rev_dist(XYZ, XYZ);
SRDist = rev_dist(P, P);

% Получение матрицы A и вектора b
A = SRDist .* S';
b = -1 / e_in * RDist' * Q;
sg = A \ b;

% Получение вектора q и вектора Ws
q = sg .* S;
Ws = 1/2 * Q' * RDist * (sg .* S);

% Получение вектора Wq и суммарного потенциала
Wq = Q' * QRDist * Q / 2;
W = Ws + Wq;

end

function M = rev_dist(A, B)
n = size(A, 1);
m = size(B, 1);
M = zeros(m, n);
for k = 1:m
    for l = 1:n
        if k ~= l || dist(B(k, :), A(l, :)) ~= 0
            M(k, l) = 1 / dist(B(k, :), A(l, :));
        end
    end
end
end

function s = dist(v1, v2)
    s = norm(v1 - v2);
end