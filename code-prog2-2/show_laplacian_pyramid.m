function show_laplacian_pyramid(im,p)
M = size(p{1},1);
N = size(p{1},2);
stretch_factor = 3;
for k = 1:numel(p)
    Mk = size(p{k},1);
    Nk = size(p{k},2);
    Mpad1 = ceil((M - Mk)/2);
    Mpad2 = M - Mk - Mpad1;
    Npad1 = ceil((N - Nk)/2);
    Npad2 = N - Nk - Npad1;
    if (k < numel(p))
        pad_value = 1;
    end
    A = p{k};
    A = padarray(A,[Mpad1 Npad1],pad_value,'pre');
    A = padarray(A,[Mpad2 Npad2],pad_value,'post');
    p{k} = A;
end
for k = 1:(numel(p)-1)
    p{k} = (stretch_factor*p{k} + 0.5);
end

OutImg = show_gaussian_pyramid(im,3);
D1 = round((size(OutImg(1).img)-size(OutImg(2).img))/2) ;
I1 = padarray(OutImg(2).img,D1(1:2),255);
D2 = round((size(OutImg(1).img)-size(OutImg(3).img))/2) ;
I2 = padarray(OutImg(3).img,D2(1:2),255);

figure;
subplot(231), imshow(OutImg(1).img);
title('Gaussian: high level');
subplot(232), imshow(I1);
title('Gaussian: mid level');
subplot(233), imshow(I2);
title('Gaussian: low level');
subplot(234), imshow(p{1});
title('Laplacian: high level');
subplot(235), imshow(p{2});
title('Laplacian: mid level');
subplot(236), imshow(p{3});
title('Laplacian: low level');
end
