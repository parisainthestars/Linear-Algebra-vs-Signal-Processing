function Analyze_Compression_Color(img, img_name)
    K = [0.10, 0.02, 0.005]; % Different ratios for variety
    figure('Name', ['Color Analysis: ' img_name], 'NumberTitle', 'off');
    
    for i = 1:length(K)
        subplot(2, length(K), i);
        imshow(compress_img_svd_colored(img, K(i)));
        title(['SVD (k=' num2str(K(i)) ')'], 'Interpreter', 'latex');
        
        subplot(2, length(K), i + length(K));
        imshow(compress_img_fft_colored(img, K(i)));
        title(['FFT (k=' num2str(K(i)) ')'], 'Interpreter', 'latex');
    end
end