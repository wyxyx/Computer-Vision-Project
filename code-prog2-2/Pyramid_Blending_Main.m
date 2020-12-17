clear all;
close all;
clc;
image_a = imread('palm.jpg');
image_b = imread('face.jpg');
mask = imread('mask.jpg');
maskr = double(mask(:,:,1)) / 255;
% First image - Mask pixels that belong to label 0
a_im = uint8(zeros(size(image_a)));
for i = 1 : 3
    b = image_a(:,:,i);
    out = zeros([size(image_a,1) size(image_a,2)]);
    out(maskr == 0) = b(maskr == 0);
    a_im(:,:,i) = out;
end
a_im = uint8(a_im);

% Second image - Mask pixels that belong to label 1
b_im = uint8(zeros(size(image_b)));
for i = 1 : 3
    b = image_b(:,:,i);
    out = zeros([size(image_b,1) size(image_b,2)]);
    out(maskr == 1) = b(maskr == 1);
    b_im(:,:,i) = out;
end
b_im = uint8(b_im);

% Laplacian blending
blendResult = pyramid_blending(image_a, image_b, mask);

% Show results
figure;
subplot(131), imshow(image_a);
title('First Image');
subplot(132), imshow(image_b);
title('Second Image');
subplot(133), imshow(mask);
title('Mask');

Show_Pyramids(image_a);
Show_Pyramids(image_b);

figure;
imshow(blendResult);
title('Result of Pyramid Blending');