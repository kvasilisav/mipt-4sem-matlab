function Dy = c(mesh)
    % mesh - структура, задающая триангулированную сетку
    
    N = size(mesh.Points,1); 
    triangles = size(mesh.ConnectivityList,1);
    
    line = zeros(9*triangles,1); 
    column = zeros(9*triangles,1);
    value = zeros(9*triangles,1); 
    
    k = 1;
    
    % Производные для каждой точки каждого треугольника
    for ii = 1:triangles
    
        point_number = mesh.ConnectivityList(ii,:);   
        x = mesh.Points(point_number,:);
    
        S = abs(det([ones(3,1) x]))/2; 

        % Матрица коэффициентов для производных
        d = [x(1,1) - x(2,1), x(1,1) - x(3,1), x(2,1)-x(3,1)]/(2*S);
    
        line(k) = point_number(1);
        column(k) = point_number(1);
        value(k) = -d(1) + d(2);
        
        line(k+1) = point_number(1);
        column(k+1) = point_number(2);
        value(k+1) = -d(2);
    
        line(k+2) = point_number(1);
        column(k+2) = point_number(3);
        value(k+2) = d(1);
    
        line(k+3) = point_number(2);
        column(k+3) = point_number(2);
        value(k+3) = -d(1) - d(3);
    
        line(k+4) = point_number(2);
        column(k+4) = point_number(3);
        value(k+4) = d(1);
    
        line(k+5) = point_number(2);
        column(k+5) = point_number(1);
        value(k+5) = d(3);
        
        line(k+6) = point_number(3);
        column(k+6) = point_number(3);
        value(k+6) = d(2) - d(3);
    
        line(k+7) = point_number(3);
        column(k+7) = point_number(1);
        value(k+7) = d(3);
    
        line(k+8) = point_number(3);
        column(k+8) = point_number(2);
        value(k+8) = -d(2);
    
        k= k+9;
    end
    
    % Создаем sparse-матрицу оператора частной по y производной
    Dy = sparse(line,column,value,N,N);
    [W,v] = convexHull(mesh);
    
    % Зануляем значения на граничных вершинах
    Dy(W,:) = 0;

end