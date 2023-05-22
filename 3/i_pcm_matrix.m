function M = i_pcm_matrix(P, N, S) 
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