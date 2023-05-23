function V = vector_operator(F,sB,n,xx,yy, lambda) 

n = n(:);
D_x = partial_x(length(xx), xx(2) - xx(1), length(yy));
D_y = partial_y(length(xx), length(yy), yy(2) - yy(1));

P1 = - 2*(D_y*(ln(n))).*D_y;
P2 = 2*(D_y*(ln(n))).*D_x;
P3 = 2*(D_x*(ln(n))).*D_y;
P4 = - 2*(D_x*(ln(n))).*D_x;
P = vertcat(horzcat(P1, P2), horzcat(P3, P4));
Psi = zeros(2*length(F(:, 1)), 0);
for k = 1:length(sB)
    Psi = horzcat(Psi, blkdiag(F(:, k), F(:, k)));
end
P = Psi' * P * Psi;

M = diag(repelem(sB,2));
V = M + P;
end

function D = partial_x(n_x, h_x, n_y)
    D = sparse(n_x * n_y, n_x * n_y);
    for ii = 1:n_x
        for jj = 1:n_y
             if jj < n_x
                D(n_y*(jj-1)+ii, n_y*jj+ii) = D(n_y*(jj-1)+ii, n_y*jj+ii) + 1/h_x;
             end
             D(n_y*(jj-1)+ii, n_y*(jj-1)+ii) = D(n_y*(jj-1)+ii, n_y*(jj-1)+ii) - 1/h_x;
        end
    end
end

function D = partial_y(n_x, n_y, h_y)
    D = sparse(n_x * n_y, n_x * n_y);
    for ii = 1:n_x
        for jj = 1:n_y
             if ii < n_y
                D(n_y*(jj-1)+ii+1, n_y*(jj-1)+ii) = D(n_y*(jj-1)+ii+1, n_y*(jj-1)+ii) + 1/h_y;
             end
             D(n_y*(jj-1)+ii, n_y*(jj-1)+ii) = D(n_y*(jj-1)+ii, n_y*(jj-1)+ii) - 1/h_y;
        end
    end
end