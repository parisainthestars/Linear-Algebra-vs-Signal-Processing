% --- Helper: Calculate PSNR ---
function [psnr_val] = get_psnr(original, processed)
    orig = double(original);
    proc = double(processed);
    [M, N, ~] = size(orig);
    mse = sum((orig(:) - proc(:)).^2) / (M * N);
    if mse > 0
        psnr_val = 10 * log10((255^2) / mse);
    else
        psnr_val = 99; % Perfect match
    end
end