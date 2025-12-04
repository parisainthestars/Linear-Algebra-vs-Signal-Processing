function [img_rec] = SVD_denoising(colored_img, thr)
    img_rec = colored_img;
    for i = 1:size(colored_img,3)
        img = colored_img(:,:,i);
        [U,S,V] = svd(double(img));
        x = diag(S);
        y = x(1:end-1)-x(2:end); % Gradient of singular values
        mask = [(y>thr); 0]; 
        % Handle dimension mismatch if S is not square
        if length(mask) < length(x)
            mask = [mask; zeros(length(x)-length(mask),1)];
        end
        S_new = diag(x .* mask);
        
        % Reconstruct (handle non-square matrices)
        S_final = zeros(size(S));
        S_final(1:length(x), 1:length(x)) = S_new;
        
        img_rec(:,:,i) = uint8(U*S_final*V');
    end
end
