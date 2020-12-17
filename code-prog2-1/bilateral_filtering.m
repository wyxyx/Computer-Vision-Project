function I = bilateral_filtering(G,sigma_s,sigma_r,filterRadius)
x = -filterRadius:filterRadius;
y = -filterRadius:filterRadius;
[xx,yy] = meshgrid(x,y);
spatialKernel = exp(- (xx.^2+yy.^2)/(2*sigma_s^2));
[rows,cols,~] = size(G);
% read R G B values of color
rc = zeros(size(G(:,:,1)));
gc = zeros(size(rc));
bc = zeros(size(gc));
if size(G,3)==1
    temp = G;
    G(:,:,1) = temp;
    G(:,:,2) = temp;
    G(:,:,3) = temp;
end
 
for y = filterRadius+1:rows-filterRadius
    for x = filterRadius+1:cols-filterRadius
        roi = G(y-filterRadius:y+filterRadius,x-filterRadius:x+filterRadius,:);
        roidif = zeros(size(roi));
        roidif(:,:,1) = roi(:,:,1)-G(y,x,1);
        roidif(:,:,2) = roi(:,:,2)-G(y,x,2);
        roidif(:,:,3) = roi(:,:,3)-G(y,x,3);
        roidif = roidif(:,:,1)+roidif(:,:,2)+roidif(:,:,3);
        roidif = roidif.^2;
        rangeKernel = exp(- roidif/(2*sigma_r^2));
        W = (rangeKernel.*spatialKernel);
        k = sum(W(:));
        RC = W.*roi(:,:,1);
        GC = W.*roi(:,:,2);
        BC = W.*roi(:,:,3);
        rc(y,x) = sum(RC(:))/k;
        gc(y,x) = sum(GC(:))/k;
        bc(y,x) = sum(BC(:))/k;
    end
end
rc = rc(filterRadius+1:end-filterRadius,filterRadius+1:end-filterRadius);
gc = gc(filterRadius+1:end-filterRadius,filterRadius+1:end-filterRadius);
bc = bc(filterRadius+1:end-filterRadius,filterRadius+1:end-filterRadius);
I = cat(3,rc,gc,bc);
end