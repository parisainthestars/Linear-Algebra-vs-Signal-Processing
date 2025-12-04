function [compressed_img] = compress_img_fft(img, k)
    img_f = fft2(img);
    sorted_vals = sort(abs(img_f(:)), 'descend');
    idx = ceil(k * length(sorted_vals));
    if idx < 1, idx = 1; end
    thr = sorted_vals(idx);
    
    mask = abs(img_f) >= thr;
    compressed_img = uint8(abs(ifft2(mask .* img_f)));
end

function [compressed_img] = compress_img_fft_colored(img, k)
    compressed_img = img;
    for i = 1:3
        compressed_img(:,:,i) = compress_img_fft(img(:,:,i), k);
    end
end