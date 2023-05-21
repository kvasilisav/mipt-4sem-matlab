function [P, sgP] = NonLinApproximator(y,r,fun, P_)

% определяем константы (размеры матрицы, итерационные параметры)
N = size(y,2);
M = size(P_,2);
K = size(r,1);
delta = 1e-6;
N_i = 1000;

% вспомогательная функция для расчета Якобиана
function J = calcJ(P_)
    J = zeros(N,K);
    for i = 1:N
        f = fun(r(:,i),P_);
        for k = 1:M        
            B = P_; 
            B(k) = B(k) + delta*abs(B(k));
            b = P_;
            b(k) = b(k) - delta*abs(b(k));
            J(i,k)=0.5*(fun(r(:,i),B)-fun(r(:,i),b))/delta;
        end
    end
end

% инициализация
for it = 1:N_i  
    f = zeros(N,1);
    J = calcJ(P_);
    
    % расчет функции F(i)
    for i = 1:N
        f(i) = fun(r(:,i),P_);
    end
    
    % вычисление результата и приращения d_b
    res = y' - f; 
    d_b = (((J' * J) \ J') * res);
    
    % обновление P_
    if ~any(isnan(d_b)) && max(abs(d_b'./P_)) >= delta
        P_ = P_ + d_b';  
    end
    
    % условие выхода из цикла
    if max(abs(d_b'./P_)) < delta || any(isnan(d_b)) 
        break;
    end
end

% возвращаем результаты
P = P_;
sgP = norm(y' - f)^2*diag(inv(J' * J))';

end