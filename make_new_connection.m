function new_combinations = make_new_connection(combinations, vertices)
    new_combinations = struct('pair_ids',{}, 'regions', {});

    for combination = combinations
        for region_id = 1: length(combination.regions)
            region = combination.regions(region_id);
            if isempty(region.outflow_ids)
                continue;
            end

            for outflow_id = region.outflow_ids
                for inflow_id = region.inflow_ids
                    if inflow_id == vertices(outflow_id).pair
                        continue;
                    end
                    
                    point1 = vertices(inflow_id).coordinates;
                    point2 = vertices(outflow_id).coordinates;

                    func = @(x) line_equation(point1, point2, x);

                    new_region1 = struct('inflow_ids', [], 'outflow_ids', []);
                    new_region2 = struct('inflow_ids', [], 'outflow_ids', []);
                    for inflow_id2 = region.inflow_ids
                        if vertices(inflow_id2).coordinates(2) >= func(vertices(inflow_id2).coordinates(1))
                            new_region1.inflow_ids = [new_region1.inflow_ids, inflow_id2];
                        end

                        if vertices(inflow_id2).coordinates(2) <= func(vertices(inflow_id2).coordinates(1))
                            new_region2.inflow_ids = [new_region2.inflow_ids, inflow_id2];
                        end
                    end

                    for outflow_id2 = region.outflow_ids
                        if outflow_id2 == outflow_id
                            continue;
                        end

                        if vertices(outflow_id2).coordinates(2) > func(vertices(outflow_id2).coordinates(1))
                            new_region1.outflow_ids = [new_region1.outflow_ids, outflow_id2];
                        end

                        if vertices(outflow_id2).coordinates(2) < func(vertices(outflow_id2).coordinates(1))
                            new_region2.outflow_ids = [new_region2.outflow_ids, outflow_id2];
                        end
                    end

                    pair_ids = combination.pair_ids;
                    pair_ids(end+1) = struct('inflow_id', inflow_id, 'outflow_id', outflow_id);

                    regions = combination.regions;

                    regions(region_id) = [];
                    regions(end+1) = new_region1;
                    regions(end+1) = new_region2;

                    is_overlap = false;
                    for new_combination = new_combinations
                        if is_struct_array_equal(new_combination.pair_ids, pair_ids)
                            is_overlap = true;
                            break;
                        end
                    end

                    if ~is_overlap
                        new_combinations(end+1) = struct('pair_ids', pair_ids, 'regions', regions);
                    end

                end
            end
        end

    clear combinations;
end
