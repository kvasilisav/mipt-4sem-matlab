function [W, Ws, sg, q_1] = pcm_solver(XYZ, Q, P, N, S, e_in, e_ex)

    % Получение матрицы взаимных расстояний между вершинами сетки
    RDist = rev_dist(P, XYZ);
    mutRDist = rev_dist(XYZ, XYZ);
    
    % Получение матрицы PCM-метода
    M = pcm_matrix(P, N, S);
    
    % Получение коэффициента
    kf = (e_in - e_ex) / (2 * pi * (e_in + e_ex));
    
    % Получение длин матриц
    n = length(S(:, 1));
    m = length(Q(:, 1));
    
    % Получение матрицы R и вектора b
    R = zeros(n, m);
    for k = 1:n
        for l = 1:m
            R(k, l) = dot(P(k, :) - XYZ(l, :), N(k, :)) * (RDist(l, k) ^ 3);
        end
    end
    b = (kf / e_in) * (R * Q);
    
    % Получение матрицы A и вектора sg
    A = eye(n) - kf / e_in * M;
    sg = A \ b;
    
    % Получение вектора Ws
    Ws = Q' * RDist * (sg .* S);
    
    % Получение вектора Wq
    Wq = Q' * mutRDist * Q / 2;
    
    % Получение суммарной переменной зарядности
    q_1 = dot(sg, S);
    
    % Получение суммарного потенциала
    W = Ws + Wq;
end
    
function M = pcm_matrix(P, N, S) 
    % Используем функцию rev_dist для расчета обратных расстояний между вершинами
    RDist = rev_dist(P);
    n = length(S);
    
    M = zeros(n, n);
    Square = sum(S);
    
    for k = 1:n
        for l = 1:n
            % Расчет элемента интегральной матрицы
            M(k, l) = dot((P(k, :) - P(l, :)), N(k, :)) * S(l) * (RDist(k, l) ^ 3);
        end
    end
        
    for k = 1:n
        % Расчет диагональных элементов интегральной матрицы
        M(k, k) = 2 * pi - dot(M(:, k), S) / S(k);
    end

end

function M = rev_dist(A)
    m = size(A, 1);
    M = zeros(m, m);
        for k = 1:m-1
            for l = k+1:m 
                % Расчет обратного расстояния
                M(k, l) = 1 / define_distance(A(k, :), A(l, :));
                M(l, k) = M(k, l);
            end
        end
end

function s = define_distance(v1, v2)
    s = norm(v1 - v2);
end