clear;
close all;

vertices = struct('coordinates', {}, 'type', {}, 'pair', {});

road_num = input('Enter the number of roads: ');

% 頂点の設定
for road_id = 1: road_num
    inflow_id = road_id*2-1;
    outflow_id = road_id*2;

    vertices(inflow_id) = struct('coordinates', [cos(2*pi*inflow_id/(2*road_num)), sin(2*pi*inflow_id/(2*road_num))], 'type', 'inflow', 'pair', outflow_id);
    vertices(outflow_id) = struct('coordinates', [cos(2*pi*outflow_id/(2*road_num)), sin(2*pi*outflow_id/(2*road_num))], 'type', 'outflow', 'pair', inflow_id);

end

combinations = struct('pair_ids',struct('inflow_id',{}, 'outflow_id',{}), 'regions', struct('inflow_ids', {}, 'outflow_ids', {}));


combinations(1) = struct('pair_ids',struct('inflow_id',{}, 'outflow_id', {}), 'regions', struct('inflow_ids', 1:2:road_num*2-1, 'outflow_ids', 2:2:road_num*2));

while should_continue_search(combinations)
    combinations = make_new_connection(combinations, vertices);
end


figure(1);
    axis equal;
    hold on;

    for vertice = vertices
        if strcmp(vertice.type, 'inflow')
            plot(vertice.coordinates(1), vertice.coordinates(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
        else
            plot(vertice.coordinates(1), vertice.coordinates(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
        end
    end

    used_vertices = [];

    for link_id = 1: length(vertices)
        vertice = vertices(link_id);

        if ismember(link_id, used_vertices)
            continue;
        else 
            pair_vertice = vertices(vertice.pair);
            used_vertices = [used_vertices, link_id, vertice.pair];

            draw_line(vertice.coordinates, pair_vertice.coordinates, 'g');
        end 
    end


for i = 1: length(combinations)
    combination = combinations(i);
    
    x_vectors = [];
    y_vectors = [];
    for pair_id = combination.pair_ids
        [x, y] = get_line_vector(vertices(pair_id.inflow_id).coordinates, vertices(pair_id.outflow_id).coordinates);
        x_vectors = [x_vectors; x];
        y_vectors = [y_vectors; y];
    end

    if i == 1
        for j = 1: road_num
            h(j) = plot(x_vectors(j, :), y_vectors(j, :), 'b', 'LineWidth', 2);
        end
    else
        for j = 1: road_num
            set(h(j), 'XData', x_vectors(j, :), 'YData', y_vectors(j, :));
            drawnow;
        end
    end
    
    title(['Combination: ', num2str(i)]);

    if i == 1
        pause(15);
    else
        pause(1);
    end
end









