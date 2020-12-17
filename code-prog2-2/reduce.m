function [rout] = reduce(image)
    % Create kernel
    a = 0.375;
    w_1d = [0.25 - a/2 0.25 a 0.25 0.25 - a/2];
    kernel = w_1d' * w_1d;

    % Blur the image
    img_blur = imfilter(image, kernel, 'conv');

    % Subsample
    rows = size(image,1);
    cols = size(image,2);

    % Get every other row
    img_blur_rows = img_blur(1:2:rows,:,:);

    % Now get every other column
    rout = img_blur_rows(:,1:2:cols,:);
end
