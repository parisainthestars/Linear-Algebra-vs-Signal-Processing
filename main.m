clc;
clear;
close all;

%% 1. Setup and Configuration
comp_images = {'1.tiff', '2.tiff', '3.tiff', '4.tiff', '5.tiff'};
noise_images = {'1.jpeg', '2.jpeg', '3.jpeg', '4.jpeg', '5.jpeg'};

disp('-------------------------------------------------');
disp('Starting Image Analysis Pipeline...');
disp('-------------------------------------------------');

%% 2. Compression Analysis
disp('>> Phase 1: Compression Analysis (SVD vs FFT)');

for i = 1:length(comp_images)
    filename = comp_images{i};
    
    if ~isfile(filename)
        warning('File %s not found. Skipping.', filename);
        continue;
    end
    
    fprintf('Processing: %s\n', filename);
    img = imread(filename);
    
    % --- Analysis A: Grayscale (Detailed Metrics & Energy Plot) ---
    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end
    
    % Call the enhanced function with Energy Plot and PSNR
    Analyze_Compression_Gray(img_gray, filename);
    
    % --- Analysis B: Colored (Visual Comparison) ---
    if size(img, 3) == 3
        Analyze_Compression_Color(img, filename);
    end
end

%% 3. Denoising Analysis
disp(' ');
disp('>> Phase 2: Denoising Analysis (SVD vs FFT)');

for i = 1:length(noise_images)
    filename = noise_images{i};
    
    if ~isfile(filename)
        warning('File %s not found. Skipping.', filename);
        continue;
    end
    
    fprintf('Denoising: %s\n', filename);
    img_noisy = imread(filename);
    
    % SVD Denoising Plot
    Analyze_Denoising_SVD(img_noisy, filename);
    
    % FFT Denoising Plot
    Analyze_Denoising_FFT(img_noisy, filename);
end

disp('-------------------------------------------------');
disp('Analysis Complete. Check generated figures.');
