[x, y] = meshgrid(-5:0.1:5,-5:0.1:5);

r = sqrt(x.^2+y.^2);
z = (besselj(1,0.5*r).^2)./(r.^2);

surf(x, y, z);
title('Поверхностный график для функции I(x,y)', 'FontSize', 14)
xlabel('x', 'FontSize', 12)
ylabel('y', 'FontSize', 12)
zlabel('I(x,y)', 'FontSize', 12)
colorbar;