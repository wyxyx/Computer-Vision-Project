% Create a Laplacian pyramid
function [lout] = laplacian_pyramid(gauss_pyr)
    lout = cell(1,length(gauss_pyr));
    
    for i = 1 : length(gauss_pyr)-1
        % Expand i+1'th scale
        tmp = expand(gauss_pyr{i+1});
        rows = size(gauss_pyr{i},1);
        cols = size(gauss_pyr{i},2);
        tmp = tmp(1:rows,1:cols,:);
        
        % Take i'th scale and subtract with expanded i+1'th scale
        lout{i} = gauss_pyr{i} - tmp;
    end
    lout{end} = gauss_pyr{end};
end

