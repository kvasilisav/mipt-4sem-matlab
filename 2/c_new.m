function c_new(a, b, c)
    % a, b, c – non-coplanar vectors

    grid_points = [];
    % creating a 3D grid
    ll = 1;
    for ii = -1 : 1
        for jj = -1 : 1
            for kk = -1 : 1
                grid_points(end+1, :) = a * ii + jj * b + kk * c;
                if (ii ~= 0) || (jj ~= 0) || (kk ~= 0)
                    ll = ll + 1;
                else
                    cell_idx = ll;
                end
            end
        end
    end

    a = (0.5 * a) / norm(a);
    b = (0.5 * b) / norm(b);
    c = (0.5 * c) / norm(c);

    [V, C] = voronoin(grid_points);

    vert = V(C{cell_idx}, :) - repmat([0, 0, 0], size(V(C{cell_idx}, :), 1), 1);

    hold on;
    scatter3(vert(:, 1), vert(:, 2), vert(:, 3), 'b')
    scatter3(grid_points(:, 1), grid_points(:, 2), grid_points(:, 3), 'r')

    bound = boundary(vert, 1);
    trisurf(bound, vert(:, 1), vert(:, 2), vert(:, 3),'FaceColor', 'green', 'FaceAlpha', 0.2)

    bound = boundary(grid_points, 1);
    trisurf(bound, grid_points(:, 1), grid_points(:, 2), grid_points(:, 3),'FaceColor', 'red', 'FaceAlpha', 0.2)

    plot3([0, a(1)], [0, a(2)], [0, a(3)], '-r', 'LineWidth', 3);
    plot3([0, b(1)], [0, b(2)], [0, b(3)], '-g', 'LineWidth' ,3);
    plot3([0, c(1)], [0, c(2)], [0, c(3)],' -b', 'LineWidth', 3);

    xlabel('x')
    ylabel('y')
    zlabel('z')
    axis equal

end