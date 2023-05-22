function M = h_cosmo_matrix(P, S)
    n = size(P, 1);
    M = zeros(n);
    for k = 1:n
        for l = 1:n
            if k == l 
                M(k, l) = 2 * sqrt(pi * S(l));
            else
                M(k, l) = S(l) / dist(P(k, :), P(l, :));
            end
        end
    end
end

function r = dist(v1, v2)
    r = norm(v1 - v2);
end