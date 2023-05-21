function [Q, R ] = QR(A)

    Q = A;
    N = length(Q(:, 1));
    
    %ортогонализация
    for ii = 2:N
       for jj = 1:(ii-1)
           Q(:, ii) = Q(:, ii) - dot(Q(:, ii), Q(:, jj))*Q(:, jj)/dot(Q(:, jj), Q(:, jj));
       end
    end

    %нормализация
    for ii = 1:N
      Q(:,ii) = Q(:, ii) / sqrt(dot( Q(:, ii),  Q(:, ii)));
    end

    R = Q'*A;

end
