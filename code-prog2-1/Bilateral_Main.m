% Clear everything
clear all;
close all;
clc;
% read image
g = double(imread('face1.jpg'))/255.0;
G = g;
sigma_s = 4;
sigma_r = 0.2;
filterSize = double(uint8(sigma_s)*6+1);
filterRadius=ceil((filterSize-1)/2);
G = padarray(G,[filterRadius,filterRadius],'replicate');
I = bilateral_filtering(G,sigma_s,sigma_r,filterRadius); 
figure;
subplot(121), imshow(g);
title('Input Image');
subplot(122), imshow(I);
title('Output Image');
