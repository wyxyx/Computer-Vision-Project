function Show_Pyramids(A)
%A = imread('face.jpg');
A = rgb2gray(A);
A = im2double(A);
im = A;
M = size(A,1);
N = size(A,2);
num_levels = 4;
mrp = cell(1,num_levels);
smallest_size = [M N] / 2^(num_levels - 1);
smallest_size = ceil(smallest_size);
padded_size = smallest_size * 2^(num_levels - 1);
Ap = padarray(A,padded_size - [M N],'replicate','post');
mrp{1} = Ap;
for k = 2:num_levels
    mrp{k} = imresize(mrp{k-1},0.5,'lanczos3');
end
mrp{1} = A;

lapp = cell(size(mrp));
num_levels = numel(mrp);
lapp{num_levels} = mrp{num_levels};
for k = 1:(num_levels - 1)
   A = mrp{k};
   B = imresize(mrp{k+1},2,'lanczos3');
   [M,N,~] = size(A);
   lapp{k} = A - B(1:M,1:N,:);
end
lapp{end} = mrp{end};
%display three images in laplacian pyramid

show_laplacian_pyramid(im,lapp);
end