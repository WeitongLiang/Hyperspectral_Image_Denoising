list=zeros(20,20);
temp1=Ori_H;
temp2=OriData3;
temp3=simu_indian;
for i=1:4
    temp1= imnoise(Ori_H,'gaussian',0,0.1*i);
    temp2= imnoise(OriData3,'gaussian',0,0.1*i);
    temp3= imnoise(simu_indian,'gaussian',0,0.1*i);
    Omat1=reshape(temp1,[200*200,160]);
    [A_11,E_11]=alm_nq_rpca(Omat1);
    list(4*i,1)=toc;
    [A_12,E_12]=ctv_alm_spcp(temp1);
    list(4*i,2)=toc;
    [A_13,E_13]=inexact_alm_WNNMrpca(Omat1,0.01);
    list(4*i,3)=toc;
    A_14=LRTV(temp1,0.008,0.1,60);
    E_14=abs(temp1-A_14);
    list(4*i,4)=toc;
    A_11=reshape(A_11,[200,200,160]);
    A_13=reshape(A_13,[200,200,160]);
    E_11=reshape(E_11,[200,200,160]);
    E_13=reshape(E_13,[200,200,160]);

    Omat2=reshape(temp2,[200*200,80]);
    [A_21,E_21]=alm_rpca(Omat2);    
    list(4*i,5)=toc;
    [A_22,E_22]=ctv_rsvd_spcp(OriData3);
    list(4*i,6)=toc;
    [A_23,E_23]=inexact_rsvd_WNNMrpca(Omat2,0.04);
    list(4*i,7)=toc;
    A_24=LRTV(temp2,0.01,0.05,10);
    E_24=abs(temp2-A_24);
    list(4*i,8)=toc;
    A_21=reshape(A_21,[200,200,80]);
    A_23=reshape(A_23,[200,200,80]);
    E_21=reshape(E_21,[200,200,80]);    
    E_23=reshape(E_23,[200,200,80]);

    Omat3=reshape(temp3,[145*145,224]);
    [A_31,E_31]=alm_rpca(Omat3);
    list(4*i,9)=toc;
    [A_32,E_32]=ctv_rsvd_spcp(simu_indian);
    list(4*i,10)=toc;
    [A_33,E_33]=inexact_rsvd_WNNMrpca(Omat3,0.03);
    list(4*i,11)=toc;
    A_34=LRTV(temp3,0.008,0.06,9);
    E_34=abs(temp3-A_34);
    list(4*i,12)=toc;
    A_31=reshape(A_31,[145,145,224]);
    A_33=reshape(A_33,[145,145,224]);
    E_31=reshape(E_31,[145,145,224]);
    E_33=reshape(E_33,[145,145,224]);

    list(4*(i-1)+1,1)=psnr(Ori_H(:,:,1),A_11(:,:,1));
    list(4*(i-1)+1,2)=psnr(Ori_H(:,:,1),A_12(:,:,1));
    list(4*(i-1)+1,3)=psnr(Ori_H(:,:,1),A_13(:,:,1));
    list(4*(i-1)+1,4)=psnr(Ori_H(:,:,1),A_14(:,:,1));
    list(4*(i-1)+1,5)=psnr(OriData3,A_21);
    list(4*(i-1)+1,6)=psnr(OriData3,A_22);
    list(4*(i-1)+1,7)=psnr(OriData3,A_23);
    list(4*(i-1)+1,8)=psnr(OriData3,A_24);
    list(4*(i-1)+1,9)=psnr(simu_indian,A_31);
    list(4*(i-1)+1,10)=psnr(simu_indian,A_32);
    list(4*(i-1)+1,11)=psnr(simu_indian,A_33);
    list(4*(i-1)+1,12)=psnr(simu_indian,A_34);
    
    list(4*(i-1)+2,1)=ssim(Ori_H(:,:,1),A_11(:,:,1));
    list(4*(i-1)+2,2)=ssim(Ori_H(:,:,1),A_12(:,:,1));
    list(4*(i-1)+2,3)=ssim(Ori_H(:,:,1),A_13(:,:,1));
    list(4*(i-1)+2,4)=ssim(Ori_H(:,:,1),A_14(:,:,1));
    list(4*(i-1)+2,5)=ssim(OriData3,A_21);
    list(4*(i-1)+2,6)=ssim(OriData3,A_22);
    list(4*(i-1)+2,7)=ssim(OriData3,A_23);
    list(4*(i-1)+2,8)=ssim(OriData3,A_24);
    list(4*(i-1)+2,9)=ssim(simu_indian,A_31);   
    list(4*(i-1)+2,10)=ssim(simu_indian,A_32);
    list(4*(i-1)+2,11)=ssim(simu_indian,A_33);
    list(4*(i-1)+2,12)=ssim(simu_indian,A_34);

    list(4*(i-1)+3,1)=ergas(Ori_H(:,:,1),A_11(:,:,1));
    list(4*(i-1)+3,2)=ergas(Ori_H(:,:,1),A_12(:,:,1));
    list(4*(i-1)+3,3)=ergas(Ori_H(:,:,1),A_13(:,:,1));
    list(4*(i-1)+3,4)=ergas(Ori_H(:,:,1),A_14(:,:,1));
    list(4*(i-1)+3,5)=ergas(OriData3,A_21);
    list(4*(i-1)+3,6)=ergas(OriData3,A_22);
    list(4*(i-1)+3,7)=ergas(OriData3,A_23);
    list(4*(i-1)+3,8)=ergas(OriData3,A_24);
    list(4*(i-1)+3,9)=ergas(simu_indian,A_31);
    list(4*(i-1)+3,10)=ergas(simu_indian,A_32);
    list(4*(i-1)+3,11)=ergas(simu_indian,A_33);
    list(4*(i-1)+3,12)=ergas(simu_indian,A_34);
end

svdl=zeros(4,10);
for i=1:4
    for j=1:10
        tic
        [u,s,v]=rSVD(Omat1,round(min(size(Omat1))/(5*i)));
        toc
        svdl(i,j)=toc;
    end
end
        

figure(1)
subplot(2,3,1)
imshow(Ori_H(:,:,1),[])
title("original(Ori H)")
subplot(2,3,2)
imshow(temp1(:,:,1),[])
title("noisy")
subplot(2,3,3)
imshow(A_11(:,:,1),[])
title("RPCA")
subplot(2,3,4)
imshow(A_12(:,:,1),[])
title("CTV")
subplot(2,3,5)
imshow(A_13(:,:,1),[])
title("WNNM")
subplot(2,3,6)
imshow(A_14(:,:,1),[])
title("LRTV")

figure(2)
subplot(2,3,1)
imshow(OriData3(:,:,1),[])
title("original(OriData3)")
subplot(2,3,2)
imshow(temp2(:,:,1),[])
title("noisy")
subplot(2,3,3)
imshow(A_21(:,:,1),[])
title("RPCA")
subplot(2,3,4)
imshow(A_22(:,:,1),[])
title("CTV")
subplot(2,3,5)
imshow(A_23(:,:,1),[])
title("WNNM")
subplot(2,3,6)
imshow(A_24(:,:,1),[])
title("LRTV")

figure(3)
subplot(2,3,1)
imshow(simu_indian(:,:,1),[])
title("original(simu indian)")
subplot(2,3,2)
imshow(temp3(:,:,1),[])
title("noisy")
subplot(2,3,3)
imshow(A_31(:,:,1),[])
title("RPCA")
subplot(2,3,4)
imshow(A_32(:,:,1),[])
title("CTV")
subplot(2,3,5)
imshow(A_33(:,:,1),[])
title("WNNM")
subplot(2,3,6)
imshow(A_34(:,:,1),[])
title("LRTV")

Omat=reshape(Ori_H,[200*200,160]);
list=zeros(10,10);
for i=1:10
    tic
    [u,s,v]=svd(Omat,'econ');
    toc;
    list(10,i)=toc;
    for j=1:3
        [u,s,v]=ieee_know_r(Omat,8*j);
        list(3*j-2,i)=toc;
        [u,s,v]=method1_r(Omat,8*j);
        list(3*j-1,i)=toc;
        [u,s,v]=method2_r(Omat,8*j);
        list(3*j,i)=toc;
    end
end
%%历时 9.313950 秒。
%%历时 100.730824 秒。
%%历时 22.494266 秒。
%%历时 5.482027 秒。
%%历时 58.196880 秒。
%%历时 7.038681 秒。
%%历时 8.615557 秒。
%%历时 106.112079 秒。
%%历时 16.278561 秒。
%%[44.9198360218772,49.0755209530699,41.9538240075696,41.5013806156543,48.2851436777656,44.3807606193737,44.8031004745653,50.8165106288591,39.0227264160248;0.998965343043038,0.999325427122396,0.996632612940429,0.998150855870632,0.998714925904134,0.996166726560241,0.998197136006508,0.999417533786576,0.992609384990041]