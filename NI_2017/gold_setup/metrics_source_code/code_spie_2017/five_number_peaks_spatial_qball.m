function five_number_peaks_spatial_qball

   % title('Minimum Crossing Angle Gold Models Intensity Map');
    fa = 'gold_fa.nii';
    %gold_peaks = 'gold_peaks.Bdouble';
    test_peaks = 'test_1_peaks.Bdouble';
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1000/Qball_sh8')) 
    
    number_peaks_spatial(fa,test_peaks,1000)
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1000/Qball_sh8'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1500/Qball_sh8')) 
    
    number_peaks_spatial(fa,test_peaks,1500)
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1500/Qball_sh8'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2000/Qball_sh8')) 
    
    number_peaks_spatial(fa,test_peaks,2000)
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2000/Qball_sh8'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2500/Qball_sh8')) 
    
    number_peaks_spatial(fa,test_peaks,2500)
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2500/Qball_sh8'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b3000/Qball_sh8')) 
    
    number_peaks_spatial(fa,test_peaks,3000)
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b3000/Qball_sh8'))


end