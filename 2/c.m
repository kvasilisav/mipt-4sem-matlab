function [h] = c(a,b,c)

    % вычисление координат узлов ячейки Вигнера-Зейтца
    M = cell(7,1);
    M{1} = [0 0 0];
    M{2} = [0.5 0.5 0.5];
    M{3} = [0.5 0.5 0];
    M{4} = [0.5 0 0.5];
    M{5} = [0 0.5 0.5];
    M{6} = [0 0.5 0];
    M{7} = [0 0 0.5];
    
    % вычисление координат центра ячейки Вигнера-Зейтца
    c_v = (a+b+c)/2;
    
    % вычисление периодических векторов ячейки
    e1 = cross(b,c)/norm(cross(b,c));
    e2 = cross(c,a)/norm(cross(c,a));
    e3 = cross(a,b)/norm(cross(a,b));
    
    % вычисление координат узлов ячейки Вигнера-Зейтца в новой системе координат
    Mxyz = zeros(3,7);
    for i = 1:7
        Mxyz(:,i) = e1*M{i}(1) + e2*M{i}(2) + e3*M{i}(3);
    end
    
    % построение поверхности ячейки Вигнера-Зейтца
    h = figure;
    hold on;
    for i = 1:7
        for j = 1:7
            if i ~= j
                r = Mxyz(:,j) - Mxyz(:,i);
                s1 = cross(r,e1);
                s2 = cross(r,e2);
                s3 = cross(r,e3);
                for k = 1:2
                    for l = 1:2
                        for m = 1:2
                            p = c_v + r*(k-1/2) + s1*(l-1/2) + s2*(m-1/2);
                            if dot(p-a,r) >= 0 && dot(p-b,r) >= 0 && dot(p-c,r) >= 0
                                plot3(p(1),p(2),p(3),'k.','MarkerSize',10)
                            end
                        end
                    end
                end
            end
        end
    end
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis equal;
    grid on;
end