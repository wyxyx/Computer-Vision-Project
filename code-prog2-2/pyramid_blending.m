% Function that blends two images together using Laplacian Pyramids
function [out] = pyramid_blending(image_a, image_b, mask)
    % Cast each of the images to double
    a_img = double(image_a);
    b_img = double(image_b);
    mask_img = double(mask) / 255.0;
    
    % Figure out how many levels we need for the image pyramid   
    min_size = min([size(a_img,1) size(a_img,2)]);
    depth = floor(log(min_size) / log(2)) - 4;
    
    % Create Gaussian pyramids for the two images and the mask
    gauss_pyr_mask = gauss_pyramid(mask_img, depth);
    gauss_pyr_a = gauss_pyramid(a_img, depth);
    gauss_pyr_b = gauss_pyramid(b_img, depth);
    
    % Create the Laplacian pyramids for the two images
    laplacian_pyr_a = laplacian_pyramid(gauss_pyr_a);
    laplacian_pyr_b = laplacian_pyramid(gauss_pyr_b);
    
    % Blend the two Laplacian pyramids together    
    outpyr = cell(1, length(laplacian_pyr_b));
    for i = 1 : length(laplacian_pyr_b)
        bImg = laplacian_pyr_b{i};
        aImg = laplacian_pyr_a{i};
        maskPyr = gauss_pyr_mask{i};
        outpyr{i} = maskPyr.*bImg + (1-maskPyr).*aImg;
    end
    
    % Create final image    
    lapl_pyr_copy = outpyr;
    for i = length(outpyr) : -1 : 2
        tmp = expand(lapl_pyr_copy{i});
        rows = size(lapl_pyr_copy{i-1},1);
        cols = size(lapl_pyr_copy{i-1},2);
        tmp = tmp(1:rows, 1:cols, :);
        lapl_pyr_copy{i-1} = lapl_pyr_copy{i-1} + tmp;
    end
    out = lapl_pyr_copy{1};
    
    % Cap and cast
    out(out < 0) = 0;
    out(out > 255) = 255;
    out = uint8(out);
end

