function five_gold_fa

    % title('Minimum Crossing Angle Gold Models Intensity Map');
    fa = 'gold_fa.nii';
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1000/PAS16')) 
    
    fa_gold_runner(fa,1000);
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1500/PAS16')) 
    
    fa_gold_runner(fa,1500);
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1500/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2000/PAS16')) 
    
    fa_gold_runner(fa,2000);
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2500/PAS16')) 
    
    fa_gold_runner(fa,2500);
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2500/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b3000/PAS16')) 
    
    fa_gold_runner(fa,3000);
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b3000/PAS16'))