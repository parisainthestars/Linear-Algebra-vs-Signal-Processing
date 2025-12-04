function [compressed_img] = compress_img_svd(img, k)
    [U,S,V] = svd(double(img));
    n = ceil(size(S,2)*k);
    if n < 1, n = 1; end
    S_new = S; 
    S_new(:, n+1:end) = 0; % Zero out tail
    compressed_img = uint8(U*S_new*V');
end

function [compressed_img] = compress_img_svd_colored(img, k)
    compressed_img = img;
    for i = 1:3
        compressed_img(:,:,i) = compress_img_svd(img(:,:,i), k);
    end
end