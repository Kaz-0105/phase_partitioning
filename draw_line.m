function draw_line(vertice1, vertice2, color)
    
    num_points = 100;

    x_vectors = linspace(vertice1(1), vertice2(1), num_points);
    y_vectors = linspace(vertice1(2), vertice2(2), num_points);

    plot(x_vectors, y_vectors, 'LineWidth', 2, 'Color', color);
    
end