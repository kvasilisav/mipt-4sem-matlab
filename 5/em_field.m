function [E,H, beta] = em_field(Q,sB,F,xx,yy, nn, lambda, m)

    D_x = partial_x(length(xx), xx(2) - xx(1), length(yy));
    D_y = partial_y(length(xx), length(yy), yy(2) - yy(1));
    
    Psi = zeros(2*length(F(:, 1)), 0);
    for k = 1:length(sB)
        Psi = horzcat(Psi, blkdiag(F(:, k), F(:, k)));
    end
    
    numbers = linspace(1, length(sB), length(sB));
    [sB,numbers] = sort(sB);
    beta = sqrt(sB(length(sB) - m + 1));
    H_xy = Q(numbers(length(sB) - m + 1));
    H_xy = Psi*H_xy*Psi';
    
    H_x = H_xy(1:length(H_xy)/2);
    H_y = H_xy(length(H_xy)/2+1 : length(H_xy));
    H_z = 1/(1i*beta)*(D_x*H_x + D_y*H_y);
    E_x = (-1/beta*(D_y*D_x*H_x+D_y*D_y*H_y) + beta*H_y)*lambda./(2*pi*nn.^2);
    E_y = (1/beta*(D_x*D_x*H_x+D_x*D_y*H_y) - beta*H_x)*lambda./(2*pi*nn.^2);
    E_z = (D_x*H_y-D_y*H_x)*lambda./(2*pi*1i*nn.^2);
    
    n_x = length(xx);
    n_y = length(yy);
    
    H = zeros(n_x, n_y, 3);
    E = zeros(n_x, n_y, 3);
    E(:, :, 1) = reshape(E_x, n_y, n_x);
    E(:, :, 2) = reshape(E_y, n_y, n_x);
    E(:, :, 3) = reshape(E_z, n_y, n_x);
    H(:, :, 1) = reshape(H_x, n_y, n_x);
    H(:, :, 2) = reshape(H_y, n_y, n_x);
    H(:, :, 3) = reshape(H_z, n_y, n_x);
end