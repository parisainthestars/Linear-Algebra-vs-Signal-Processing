function [img_rec] = FFT_denoising(colored_img, r)
    img_rec = colored_img;
    for i = 1:size(colored_img,3)
        img = colored_img(:,:,i);
        [R, C] = size(img);
        nr = floor(r * R);
        nc = floor(r * C);
        
        img_f = fft2(img);
        % Low pass filter (remove high freq at edges of unshifted FFT)
        img_f(nr:end-nr, :) = 0; % Rows
        img_f(:, nc:end-nc) = 0; % Cols
        
        img_rec(:,:,i) = uint8(real(ifft2(img_f)));
    end
end