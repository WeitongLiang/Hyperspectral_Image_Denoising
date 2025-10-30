# Hyperspectral Image Denoising and SVD Acceleration

This repository presents a unified framework for **hyperspectral image denoising** leveraging low-rank structure and local smoothness priors. The project explores several robust PCA-based techniques, alongside multiple accelerated **Singular Value Decomposition (SVD)** algorithms to enhance computational efficiency in large-scale denoising tasks.

The project includes:
- Implementation of **LRTV**, **CTV**, and **WNNM** denoising models using low-rank and smoothness priors
- Integration of **accelerated SVD methods** based on randomized matrix approximations
- Evaluation on benchmark hyperspectral datasets with added **Gaussian** and **salt-and-pepper noise**

**Full report**: [Hyperspectral Image Denoising and SVD Acceleration.pdf](./Hyperspectral%20Image%20Denoising%20and%20SVD%20Acceleration.pdf)  

---

## Project Overview

Image denoising is a fundamental preprocessing step for image analysis and downstream tasks. Hyperspectral images (HSIs), due to their rich spectral information, are particularly sensitive to noise, making robust denoising essential.

This project addresses the denoising problem via matrix decomposition methods that assume the clean image is **low-rank** and **locally smooth**, while noise is sparse or unstructured. The general model is:

\[
D = C + N
\]

where \( D \) is the noisy image, \( C \) is the clean image, and \( N \) is the noise component.

---

## Denoising Methods

### Robust Low-Rank Denoising

We explore several model-based algorithms:

- **RPCA**: Decomposes images using nuclear norm (sum of singular values) and ℓ₁ norm minimization
- **WNNM**: Applies weighted nuclear norm minimization to emphasize larger singular values
- **LRTV**: Combines low-rank recovery with Total Variation (TV) to preserve edge smoothness
- **CTV**: Converts local smoothness to low-rankness post-TV transformation, removing dependency on hyperparameter tuning

These models are solved using **ALM** or **ADMM** optimization, and employ **FFT-based TV regularization** to enforce smoothness.

---

## Accelerated SVD Methods

As SVD is a computational bottleneck in many low-rank methods, we investigate **randomized SVD (rSVD)** strategies to speed up matrix decompositions:

- **Method1_R**: rSVD with additional QR decomposition on matrix \( B \)
- **IEEE_R**: Adds another QR step and decomposes \( R_1^T \)
- **Method2_R**: Transforms SVD into an eigenproblem of \( C = BB^T \) to shorten both rows and columns

We also test a **variable-rank rSVD** strategy that starts with small ranks to accelerate early iterations and increases rank later to ensure convergence.

---

## Experimental Results

### Setup

- Dataset: `simu_Indian` (hyperspectral)
- Noise: Gaussian (e.g., \( \sigma = 0.1 \)), Salt-and-pepper
- Metrics: **PSNR**, **SSIM**, and runtime

### Key Findings

- All methods successfully utilize low-rank and smoothness priors to recover clean images
- **CTV** performs best in quality and stability across noise settings
- **rSVD** methods reduce single SVD runtime by ~64.2%, but tradeoffs in convergence and precision are observed
- Variable-rank rSVD mitigates this by adjusting decomposition depth dynamically

---

## References

1. Cai, J. F., Candes, E. J., & Shen, Z. (2010). A singular value thresholding algorithm for matrix completion. *SIAM Journal on Optimization*, 20(4), 1956–1982.  
2. Gu, S., Zhang, L., Zuo, W., & Feng, X. (2014). Weighted nuclear norm minimization with application to image denoising. *CVPR*.  
3. Liu, G., Lin, Z., Yan, S., et al. (2010). Robust recovery of subspace structures by low-rank representation. *TPAMI*, 35(1), 171–184.  
4. Otazo, R., Candès, E. J., & Sodickson, D. K. (2015). Low-rank plus sparse matrix decomposition for accelerated dynamic MRI with separation of background and dynamic components. *Magnetic Resonance in Medicine*.  
5. Halko, N., Martinsson, P. G., & Tropp, J. A. (2011). Finding structure with randomness: Probabilistic algorithms for constructing approximate matrix decompositions. *SIAM Review*, 53(2), 217–288.  
6. Zhang, J., Zhao, D., & Gao, W. (2015). Group-based sparse representation for image restoration. *IEEE Transactions on Image Processing*, 23(8), 3336–3351.  
7. He, Y., Zhang, Y., & Liu, Y. (2019). Accelerated low-rank matrix approximation with randomized SVD. *IEEE Access*, 7, 64739–64748.

---

## Author

- **Weitong Liang**
