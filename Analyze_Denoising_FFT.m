function Analyze_Denoising_FFT(colored_img, img_name)
    R = [0.35, 0.40, 0.45]; % Cutoff ratios
    figure('Name', ['FFT Denoising: ' img_name], 'NumberTitle', 'off');
    
    subplot(1, length(R)+1, 1);
    imshow(colored_img);
    title('Noisy Input', 'Interpreter', 'latex');
    
    for i = 1:length(R)
        subplot(1, length(R)+1, i+1);
        res = FFT_denoising(colored_img, R(i));
        imshow(res);
        title(['FFT (r=' num2str(R(i)) ')'], 'Interpreter', 'latex');
    end
end