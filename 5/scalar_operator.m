function D = scalar_operator(nx, hx, ny, hy, nn, lambda)
    nn = sparse(diag(nn(:)));
    L = Laplasian_2D(nx,hx, ny, hy);
    D = L + (2*pi/lambda)^2*(nn.^2);
end


