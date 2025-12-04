# Comparative Analysis: SVD vs. FFT for Image Compression & Denoising

## 📝 Project Overview
As an engineering student, I have always been fascinated by the mathematics behind digital image processing. This project is a comparative study of two distinct mathematical approaches to handling image data:
1.  **Linear Algebra (Algebraic Approach):** Using Singular Value Decomposition (**SVD**).
2.  **Signal Processing (Frequency Approach):** Using the Fast Fourier Transform (**FFT**).

Rather than just implementing the code, my goal was to understand the *theoretical trade-offs* between these methods. I investigated how they behave when compressing data (dimensionality reduction) and removing Gaussian noise, validating the results with PSNR metrics and Energy distribution plots.



## 📚 Theoretical Framework (The "Why")

The core difference between these two methods lies in how they decompose the image.

### 1. Singular Value Decomposition (SVD) – *The Data-Dependent Basis*
SVD is a factorization technique from linear algebra. We treat the grayscale image as a matrix $A$ (size $m \times n$).
$$A = U \Sigma V^T$$
* **The Math:** $U$ and $V$ contain the "singular vectors" (orthonormal basis), and $\Sigma$ contains the singular values (strengths).
* **Why it works:** SVD is optimal in a "least-squares" sense. It calculates the basis vectors **from the image data itself**. It finds the specific correlations within *this specific image* and aligns the axes ($U$ and $V$) to capture the maximum variance.
* **Compression Mechanism:** By keeping only the first $k$ singular values (Truncated SVD), we reconstruct the "Best Rank-$k$ Approximation" of the matrix, effectively filtering out low-energy details (noise).

### 2. Fast Fourier Transform (FFT) – *The Fixed Basis*
FFT transforms the image from the **Spatial Domain** to the **Frequency Domain**.
$$F(u,v) = \sum_{x} \sum_{y} f(x,y) e^{-j2\pi(\dots)}$$
* **The Math:** FFT projects the image onto a **fixed set of basis functions** (sine and cosine waves of different frequencies). Unlike SVD, these basis functions are the *same* for every image.
* **Why it works:** Natural images tend to have most of their energy in low frequencies (smooth gradients). Noise and sharp edges are found in high frequencies.
* **Compression Mechanism:** We apply a "mask" to zero out high-frequency coefficients.

### ⚡ The Critical Difference
> **SVD learns the features** of the image (it adapts to the data).
> **FFT fits the image** into a pre-defined set of waves.



## 🚀 Experimental Results

### 1. Compression Analysis
I tested both methods at various compression ratios ($k$).

**Visual Analysis:**
* **SVD Behavior:** When SVD compresses an image too much, it creates "blocky" or "streaky" artifacts. It struggles with textures (like the grass).
* **FFT Behavior:** FFT preserves the overall structure better, but it creates "ripples" or "waves" around sharp edges (this is known as the Gibbs Phenomenon).

<div align="center">
  <img width="400" alt="Screenshot 2025-12-05 015653" src="https://github.com/user-attachments/assets/84e98c72-3366-4229-92d0-72f2c4bacca9" />
  <br>
  <em>Figure 1: Comparison of artifacts at high compression (k=0.5%). Note the "streaking" blocks in SVD (top right) vs. "blurring" in FFT (bottom right).</em>
</div>

### 2. Energy Compaction
To understand why compression is possible, I plotted the **Cumulative Energy**.

<div align="center">
  <img width="400" alt="Screenshot 2025-12-05 015715" src="https://github.com/user-attachments/assets/7ee7e7c8-e016-4b04-a1c6-676de134cc61" />
  <br>
  <em>Figure 2: The Scree Plot. This confirms that natural images are "Low Rank." The red line shows we can discard the tail end of the curve (80-90% of the data) because it contributes very little to the visual structure.</em>
</div>

### 3. Denoising Performance
I added Gaussian noise to the inputs and attempted to recover the signal. SVD uses thresholding on singular values, while FFT uses a Low-Pass Filter.

<div align="center">
<table border="0">
  <tr>
    <td align="center" width="45%">
      <strong>Method A: SVD Reconstruction</strong><br>
      <img width="400" alt="Screenshot 2025-12-05 015746" src="https://github.com/user-attachments/assets/ac46a99f-b84e-4729-bed2-ac4bcb23b4c0" />
      <br>
      <em>Cleaned by truncating small singular values.</em>
    </td>
    <td align="center" width="45%">
      <strong>Method B: FFT Low-Pass Filter</strong><br>
      <img width="400" alt="Screenshot 2025-12-05 015808" src="https://github.com/user-attachments/assets/b0f8681d-6f90-41e2-9e42-5814a1e0b9d9" />
      <br>
      <em>Cleaned by cutting high frequencies.</em>
    </td>
  </tr>
</table>
<em>Figure 3: Side-by-side comparison of denoising techniques on the Mandrill image.</em>
</div>



## 📊 Key Findings & Conclusion

1.  **Metric Analysis (PSNR):**
    * **FFT generally won** on geometric images (like the Pentagon). It is more robust at capturing structural layouts than SVD at very low compression rates.
    * **SVD was competitive** on smooth, natural images (like the Flower) because they closely approximate low-rank matrices.

2.  **Theoretical Insight:**
    * **SVD** is computationally heavier because it must calculate the basis vectors for every new image. However, it separates "structure" from "noise" effectively if the noise is uncorrelated.
    * **FFT** is incredibly fast ($O(N \log N)$), but using a strict frequency cutoff can blur fine textures (like the mandrill's fur) because texture looks like high-frequency noise to the FFT.



## 💻 How to Run the Code

The project is built in MATLAB.

1.  **Prerequisites:** Ensure you have MATLAB installed with the Image Processing Toolbox.
2.  **Setup:**
    * Clone the repository.
    * **Step 1:** Run `dataGen.m` to generate the noisy test images (this script creates `.jpeg` files from the source `.tiff`s).
    * **Step 2:** Run `main.m` to execute the full analysis calling the modular functions.
3.  **Output:** The script will process all images in the directory and automatically generate the comparison figures.
