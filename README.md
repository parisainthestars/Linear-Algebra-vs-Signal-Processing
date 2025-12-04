# Comparative Analysis: SVD vs. FFT for Image Compression & Denoising

## 📝 Project Overview
As an engineering student, I have always been fascinated by the mathematics behind digital image processing. This project is a comparative study of two distinct mathematical approaches to handling image data:
1.  **Linear Algebra (Algebraic Approach):** Using Singular Value Decomposition (**SVD**).
2.  **Signal Processing (Frequency Approach):** Using the Fast Fourier Transform (**FFT**).

Rather than just implementing the code, my goal was to understand the *theoretical trade-offs* between these methods. I investigated how they behave when compressing data (dimensionality reduction) and removing Gaussian noise, validating the results with PSNR metrics and Energy distribution plots.

---

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

---

## 🚀 Experimental Results

### 1. Compression Analysis
I tested both methods at various compression ratios ($k$).

**Visual Observations:**
* **SVD Artifacts:** When $k$ is too low, SVD produces "blocky" vertical and horizontal streaks. This is because we are trying to rebuild the image using too few rank-1 matrices.
* **FFT Artifacts:** FFT preserves the overall shape better but introduces "ringing" or "ripples" near sharp edges. This is theoretically known as the **Gibbs Phenomenon**—it is impossible to perfectly recreate a sharp edge using a finite sum of smooth sine waves.

<img width="400" alt="Screenshot 2025-12-05 015653" src="https://github.com/user-attachments/assets/def1dbe4-d4ff-4b98-a257-7232801e9ec2" />
*Figure 1: Comparison of artifacts at high compression (k=1%). Note the "streaking" in SVD vs. "ringing" in FFT.*

### 2. Energy Compaction
To understand why compression is possible, I plotted the **Cumulative Energy**.
<img width="400" alt="Screenshot 2025-12-05 015715" src="https://github.com/user-attachments/assets/fe5ccffb-8b10-4509-a8a9-dce31e005c48" />
*Figure 2: The Scree Plot. This confirms that natural images are "Low Rank." We can discard the tail end of the curve (80-90% of the data) because it contributes very little to the visual structure.*

### 3. Denoising Performance
I added Gaussian noise to the inputs and attempted to recover the signal. SVD uses thresholding on singular values, while FFT uses a Low-Pass Filter.

<table align="center">
  <tr>
    <td align="center">
      <img width="602" height="185" alt="Screenshot 2025-12-05 015746" src="https://github.com/user-attachments/assets/83093970-1beb-4370-8e54-722304f4e389" />
      <br />
      <b>Method A: SVD Reconstruction</b><br />
      <i>Cleaned by truncating small singular values.</i>
    </td>
    <td align="center">
      <img width="579" height="169" alt="Screenshot 2025-12-05 015808" src="https://github.com/user-attachments/assets/b1049d2d-b7cb-46ca-9756-f36cb031b379" />
      <br />
      <b>Method B: FFT Low-Pass Filter</b><br />
      <i>Cleaned by cutting high frequencies.</i>
    </td>
  </tr>
</table>
*Figure 3: Side-by-side comparison of denoising techniques on the Mandrill image.*

---

## 📊 Key Findings & Conclusion

1.  **Metric Analysis (PSNR):**
    * **FFT generally won** on geometric images (like the Pentagon). It is more robust at capturing structural layouts than SVD at very low compression rates.
    * **SVD was competitive** on smooth, natural images (like the Flower) because they closely approximate low-rank matrices.

2.  **Theoretical Insight:**
    * **SVD** is computationally heavier because it must calculate the basis vectors for every new image. However, it separates "structure" from "noise" effectively if the noise is uncorrelated.
    * **FFT** is incredibly fast ($O(N \log N)$), but using a strict frequency cutoff can blur fine textures (like the mandrill's fur) because texture looks like high-frequency noise to the FFT.

---

## 💻 Usage

1.  **Prerequisites:** MATLAB with Image Processing Toolbox.
2.  **Run the Analysis:**
    * Run `main_project.m`.
    * The script will automatically process 5 different image types and generate the comparison figures shown above.

---

### Author
**[Your Name]**
*Engineering Student | Exploring Linear Algebra & Signal Processing*
