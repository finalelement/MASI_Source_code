function five_mask_histos    
    
    fa_file = 'gold_fa.nii';
    wm_mask = 'WMmask.nii';

    figure(1);
    hold on;
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1000/Qball_sh8')) 
    out1 = in_mask_fa_histo(fa_file,wm_mask);
    mean(out1)
    hist(out1)
    xlabel('FA in mask')
    ylabel('Number of voxels')
    title('b1000')
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1000/Qball_sh8'))
    hold off
    
    figure(2);
    hold on;
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1500/Qball_sh8')) 
    out2 = in_mask_fa_histo(fa_file,wm_mask);
    mean(out2)
    hist(out2)
    xlabel('FA in mask')
    ylabel('Number of voxels')
    title('b1500')
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1500/Qball_sh8'))
    hold off
    
    figure(3);
    hold on;
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2000/Qball_sh8')) 
    out3 = in_mask_fa_histo(fa_file,wm_mask);
    mean(out3)
    hist(out3)
    xlabel('FA in mask')
    ylabel('Number of voxels')
    title('b2000')
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2000/Qball_sh8'))
    hold off
    
    figure(4);
    hold on;
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2500/Qball_sh8')) 
    out4 = in_mask_fa_histo(fa_file,wm_mask);
    mean(out4)
    hist(out4)
    xlabel('FA in mask')
    ylabel('Number of voxels')
    title('b2500')
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2500/Qball_sh8'))
    hold off
    
    figure(5);
    hold on;
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b3000/Qball_sh8')) 
    out5 = in_mask_fa_histo(fa_file,wm_mask);
    mean(out5)
    hist(out5)
    xlabel('FA in mask')
    ylabel('Number of voxels')
    title('b3000')
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b3000/Qball_sh8'))
    hold off