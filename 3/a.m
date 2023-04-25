function [A] = a(Nx, Ny, Nz, Lx, Ly, Lz)
% Nx, Ny, Nz - число разбиений по каждому из направлений
% Lx, Ly, Lz - размеры рабочей области вдоль каждого из направлений
% A - искомая матрица оператора Лапласа в формате sparse

% Количество узлов сетки
N = Nx*Ny*Nz;

% Шаг сетки в каждом из направлений
hx = Lx/(Nx+1);
hy = Ly/(Ny+1);
hz = Lz/(Nz+1);

% Создание диагональной матрицы для оператора Лапласа на 1D, 2D или 3D сетке
if Nx == 1 % 1D случай
    A = spdiags([-2*ones(Nx,1),ones(Nx,1),ones(Nx,1)],[-1,0,1],Nx,Nx)/(hx^2);
elseif Nx > 1 && Ny == 1 % 2D случай
    D2x = spdiags([-2*ones(Nx,1),ones(Nx,1),ones(Nx,1)],[-1,0,1],Nx,Nx)/(hx^2);
    A = kron(speye(Ny),D2x) + kron(D2x,speye(Ny))/(hy^2);
else % 3D случай
    D2x = spdiags([-2*ones(Nx,1),ones(Nx,1),ones(Nx,1)],[-1,0,1],Nx,Nx)/(hx^2);
    D2y = spdiags([-2*ones(Ny,1),ones(Ny,1),ones(Ny,1)],[-1,0,1],Ny,Ny)/(hy^2);
    D2z = spdiags([-2*ones(Nz,1),ones(Nz,1),ones(Nz,1)],[-1,0,1],Nz,Nz)/(hz^2);
    A = kron(speye(Ny*Nz),D2x) + kron(speye(Nz),kron(D2y,speye(Nx))) + kron(D2z,kron(speye(Ny),spdiags(ones(Nx,1),0,Nx,Nx)));
end

end