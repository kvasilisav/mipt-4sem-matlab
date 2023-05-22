function [h] = c(a,b,c)
    x =(a+b)/2;
    y = -(a+c)/2;
    z = (c+b)/2;
    
    h = figure;
    hold on;
    grid on;
    
    pp = [2*x, -2*x, 2*y, -2*y, 2*z, -2*z, a, -a, b, -b, c, -c, (x-y+z), -x+y-z];
    
    connections = [13 4 10 6 12 1
         1 12 3 8 5 13
         4 13 5 8 2 10
         7 1 9 5 11 4
         10 6 12 3 8 2
         9 3 14 2 11 5
         11 4 7 6 14 2
         9 1 7 6 14 3];
    
    vectors = [7, 9, 11, 13, 14, 8, 10, 12];
    
    sz = size(connections);
    points = pp';
    hexes =[];
    
    % Пройдемся по всем шестиугольникам и вычислим точки пересечения плоскостей
    % перпендикулярных заданным векторам
    for jj = 1:sz(1) 
        v1 = points(vectors(jj),:);
        v2 = points(connections(jj, 6), :);
        v3 = points(connections(jj, 1), :);
        w = [Find_inter_faces(v1', v2', v3')]
    
        for kk = 1:5
            v2 = points(connections(jj, kk), :);
            v3 = points(connections(jj, kk+1), :);
            x = Find_inter_faces(v1', v2', v3');
            w = [w x]
        end
        % Сразу отображаем полученную поверхность
        patch('Faces',[1 2 3 4 5 6],'Vertices',w','FaceColor',[0 1 1],'FaceAlpha',0.4);
        hexes = [hexes; w];
    
    end
    
    % отображаем векторы, формирующие сетку
    plot3([0,a(1)],[0,a(2)],[0,a(3)],'-r','LineWidth',2);
    plot3([0,b(1)],[0,b(2)],[0,b(3)],'-g','LineWidth',2);
    plot3([0,c(1)],[0,c(2)],[0,c(3)],'-b','LineWidth',2);
    
    plot3(pp(1,:), pp(2,:), pp(3,:),'o','LineWidth',2);
    
    DT = delaunayTriangulation(points);
    [W,v] = convexHull(DT);
    trisurf(W,DT.Points(:,1),DT.Points(:,2),DT.Points(:,3), ...
           'FaceColor',[1 0 0],'FaceAlpha',0.2)
    axis equal;
    hold off
    
end

% Функция принимает 3 некомпланарных вектора и ищет точку пересечения 3 плоскостей, которые перпендикулярны каждому из векторов и проходят через их середины.
function x = Find_inter_faces(v1, v2, v3)
        A = [v1 v2 v3];
        q = [norm(v1)^2/2 norm(v2)^2/2 norm(v3)^2/2]';
        A_ = inv(A');
        x = A_*q;
end