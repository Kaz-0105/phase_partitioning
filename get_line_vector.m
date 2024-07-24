function [x_vectors, y_vectors] = get_line_vector(vertice1, vertice2)
    
    num_points = 100;

    x_vectors = linspace(vertice1(1), vertice2(1), num_points);
    y_vectors = linspace(vertice1(2), vertice2(2), num_points);
    
end