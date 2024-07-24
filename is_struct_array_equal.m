function result = is_struct_array_equal(structArray1, structArray2)
    % 構造体配列の長さが異なる場合、一致していない
    if numel(structArray1) ~= numel(structArray2)
        result = false;
        return;
    end
    
    % 各構造体を比較
    for i = 1:numel(structArray1)
        foundMatch = false;
        for j = 1:numel(structArray2)
            if isequal(structArray1(i), structArray2(j))
                foundMatch = true;
                break;
            end
        end
        % 一致する構造体が見つからなかった場合、一致していない
        if ~foundMatch
            result = false;
            return;
        end
    end
    
    % すべての構造体が一致する場合、一致している
    result = true;
end
