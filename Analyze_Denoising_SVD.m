function Analyze_Denoising_SVD(colored_img, img_name)
    Thr = [1.5, 2.5, 3.5]; % Thresholds for singular value gradients
    figure('Name', ['SVD Denoising: ' img_name], 'NumberTitle', 'off');
    
    subplot(1, length(Thr)+1, 1);
    imshow(colored_img);
    title('Noisy Input', 'Interpreter', 'latex');
    
    for i = 1:length(Thr)
        subplot(1, length(Thr)+1, i+1);
        res = SVD_denoising(colored_img, Thr(i));
        imshow(res);
        title(['SVD (Thr=' num2str(Thr(i)) ')'], 'Interpreter', 'latex');
    end
end