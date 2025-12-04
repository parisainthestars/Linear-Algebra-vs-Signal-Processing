function Analyze_Compression_Gray(img, img_name)
    % Compression Ratios (k)
    K = [0.15, 0.05, 0.01]; % Top 15%, 5%, 1%
    
    f = figure('Name', ['Gray Analysis: ' img_name], 'NumberTitle', 'off');
    f.Position = [50 50 1200 700];
    
    % 1. Mathematical Insight: Energy Plot (Singular Values)
    [~, S, ~] = svd(double(img));
    s_diag = diag(S);
    energy = cumsum(s_diag) / sum(s_diag);
    
    subplot(3, 3, [1, 2, 3]); % Span top row
    plot(energy, 'LineWidth', 2, 'Color', '#D95319');
    yline(0.90, '--b', '90% Energy Threshold', 'LineWidth', 1.5);
    title(['\textbf{Singular Value Energy Distribution} (' img_name ')'], 'Interpreter', 'latex', 'FontSize', 12);
    xlabel('k (Singular Value Index)', 'Interpreter', 'latex');
    ylabel('Cumulative Energy \%', 'Interpreter', 'latex');
    grid on; xlim([0, length(s_diag)]); ylim([0, 1.1]);
    
    % 2. Compression Visuals
    for i = 1:length(K)
        % SVD
        img_svd = compress_img_svd(img, K(i));
        psnr_svd = get_psnr(img, img_svd);
        
        subplot(3, 3, i + 3);
        imshow(img_svd);
        title({['\textbf{SVD} (k=' num2str(K(i)) ')']; ['PSNR: ' num2str(psnr_svd, '%.1f') ' dB']}, ...
              'Interpreter', 'latex');
          
        % FFT
        img_fft = compress_img_fft(img, K(i));
        psnr_fft = get_psnr(img, img_fft);
        
        subplot(3, 3, i + 6);
        imshow(img_fft);
        title({['\textbf{FFT} (k=' num2str(K(i)) ')']; ['PSNR: ' num2str(psnr_fft, '%.1f') ' dB']}, ...
              'Interpreter', 'latex');
    end
end