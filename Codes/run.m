i=3;

[A_32,E_32]=ctv_alm_spcp(temp3);
list(4,2*i-1)=toc;

list(1,2*i-1)=psnr(simu_indian,A_32);

list(2,2*i-1)=ssim(simu_indian,A_32);

list(3,2*i-1)=ergas(simu_indian,A_32);

