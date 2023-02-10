randmatrix = rand(110, 110);
T = trace(randmatrix); %сумма элементов главной диагонали

Dp=diag(rot90(randmatrix));
P = sum(Dp); %сумма элементов побочной диагонали

modifiedmatrix = zeros(110);
for k = 1:1:110
    for j = 1:1:110
        modifiedmatrix(k, j) = randmatrix(k, j);
    end
end

for m = 1:1:110
    modifiedmatrix(m, m) = randmatrix(m, abs(111-m));
end
disp(modifiedmatrix); %исходная матрица с замененными элементами на главной диагонали

D1 = det(randmatrix);
littlematrix = zeros(11);
for l = 1:11
    for q = 1:11
        littlematrix(l, q) = det(randmatrix((l*10 - 9):(l*10), (q*10-9):(q*10)));
    end
end
D2 = det(littlematrix);
disp(littlematrix); %матрица 11*11
disp(D1); %детерминант исходной матрицы
disp(D2); %детерминант матрицы 11*11

