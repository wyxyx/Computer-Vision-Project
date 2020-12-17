function OutImg = show_gaussian_pyramid(img,levels)
% Create kernel
a = 0.375;
w_1d = [0.25 - a/2 0.25 a 0.25 0.25 - a/2];
kernel = w_1d' * w_1d;
for i = 1:levels
    if i == 1
        % Blur the image
        im = imfilter(img,kernel,'conv');
        OutImg(i).img = im;
    else 
        % Blur the image
        im = imfilter(OutImg(i-1).img,kernel,'conv');
        im1 = im(:,1:2:size(OutImg(i-1).img,2));
        im2 = im1(1:2:size(OutImg(i-1).img,1),:);
        OutImg(i).img = im2;
    end
end

