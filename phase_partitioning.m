close all;
clear;
figure(1);
axis equal;
hold on;
grid on;

N = 4;

vertices = [];

for i = 1: 2*N
    vertices = [vertices; [cos(2*pi*i/(2*N)), sin(2*pi*i/(2*N))]];
end

for i = 1: N
    plot(vertices(2*i-1, 1), vertices(2*i-1, 2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    plot(vertices(2*i, 1), vertices(2*i, 2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
end

%{
for i = 1: 2*N
    if i == 2*N
        [x_vectors, y_vectors] = get_line(vertices(i, :), vertices(1, :), 100);
    else
        [x_vectors, y_vectors] = get_line(vertices(i, :), vertices(i+1, :), 100);
    end
    plot(x_vectors, y_vectors, 'r', 'LineWidth', 2);
end
%}

for i = 1: N
    for j = 1: N
        [x_vectors, y_vectors] = get_line(vertices(2*i-1, :), vertices(2*j, :), 100);
        if i == j
            plot(x_vectors, y_vectors, 'g', 'LineWidth', 3);
        else
            
            plot(x_vectors, y_vectors, 'b');
        end
    end
    
end

function [x_vectors, y_vectors] = get_line(vertice1, vertice2, num_points)

    for i = 1: num_points
        x_vectors = linspace(vertice1(1), vertice2(1), num_points);
        y_vectors = linspace(vertice1(2), vertice2(2), num_points);
    end
end