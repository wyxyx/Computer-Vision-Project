function [eout] = expand(image)
    % expand
    rows = size(image, 1);
    cols = size(image, 2);
    eout = zeros([2*rows 2*cols 3]);
    eout(1:2:2*rows,1:2:2*cols,:) = image;

    % Smooth the image
    a = 0.375;
    w_1d = [0.25 - a/2 0.25 a 0.25 0.25 - a/2];
    kernel = w_1d' * w_1d;
    eout = imfilter(eout, kernel, 'conv');
    
    % Scale by 4 to ensure that net weight contributing to each output pixel is 1.
    eout = 4 * eout;
end

