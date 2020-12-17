% Create a Gaussian pyramid
function [gout] = gauss_pyramid(image, levels)
    gout = cell(1,levels+1);
    gout{1} = image;
    subsample = image;
    for i = 2 : levels+1
        subsample = reduce(subsample);
        gout{i} = subsample;
   end
end