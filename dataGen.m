%% Image Preparation Script
%  Description: Reads clean .tiff images, adds noise, and saves as .jpeg
%  Run this ONCE before running your main project.

clc; clear; close all;

% List of your downloaded clean files
clean_files = {'1.tiff', '2.tiff', '3.tiff', '4.tiff', '5.tiff'};
noisy_files = {'1.jpeg', '2.jpeg', '3.jpeg', '4.jpeg', '5.jpeg'};

% Loop through each file
for i = 1:length(clean_files)
    if ~isfile(clean_files{i})
        warning('File %s not found. Please download it first.', clean_files{i});
        continue;
    end
    
    % 1. Read the clean image
    img = imread(clean_files{i});
    
    % 2. Add Gaussian Noise
    % '0.02' is the variance. Higher number = more noise.
    img_noisy = imnoise(img, 'gaussian', 0, 0.02);
    
    % 3. Save as JPEG
    % Quality 90 ensures we don't introduce too much compression artifacts, 
    % so we are mostly fighting the Gaussian noise we added.
    imwrite(img_noisy, noisy_files{i}, 'Quality', 90);
    
    fprintf('Generated %s from %s\n', noisy_files{i}, clean_files{i});
end

disp('All noisy images generated successfully.');