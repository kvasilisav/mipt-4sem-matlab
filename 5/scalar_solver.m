function [F,sB] = scalar_solver(D,sb_min,sb_max, k_max, inds)

    sB = [];
    SS = [];
    sg  = sb_max;
    while length(SS) < k_max && sg > sb_min
        % starting meanings of parametres
        b = rand(length(D(:, 1)), 1);
        tol = 0.01;
    
        [T,Q] = inv_Lanczoh(D,sg,b,k_max);
        M = eig(full(T));
        S = bisection_eig_sym(T,sb_min,sb_max,tol);
        S = sort(S, "descend");
        S = S(S <= sg);
        len_S = min(length(S), round(k_max/3));
        SS = horzcat(SS, S(1:len_S));
        if len_s > 0
            sg = S(len_S);
        end
    end
    SS = SS(1:min(k_max, length(S)));
    Y = zeros(length(T(:, 1)), length(S));
    for k=1:length(S)
        [S(k), Y(:, k)] = reverse_iteration(T, S(k));
    end
    F = zeros(length(D(:, 1)), 0);
    F_0 = Q*Y;
    for k = 1:length(S)
        x = F_0(:,k);
        if (norm(x(inds, 1))>0.5)
            [S(k), x] = reverse_iteration(D, S(k));
            F = horzcat(F, x);
            sB = horzcat(sB, S(k));
        end
    end

end