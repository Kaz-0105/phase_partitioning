function flag = should_continue_search(combinations)
    flag = false;
    for combination = combinations
        for region = combination.regions
            if ~isempty(region.outflow_ids) 
                flag = true;
            else
                continue;
            end
        end
    end
end