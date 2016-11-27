function sf_pas_sf_3_qball_sf_3_b1000
    
    mask = 'WM_nuero_mask.nii';
    
    figure(2);
    hold on;
    
    title('SF of Peaks PAS & Q-ball at b-value 1000');
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    [sf_mean_matrix1,sf_std_matrix1] = report_dev_single_fiber_sf_three_trials(mask);
    a1 = errorbar(sf_mean_matrix1(:,1),sf_mean_matrix1(:,2),sf_std_matrix1(:,2),'--','linewidth',1,'Color','red'); M1 = 'PAS-1-fiber';
    
    [sf_mean_matrix2,sf_std_matrix2] = report_dev_two_fiber_sf_three_trials(mask);
    a2 = errorbar(sf_mean_matrix2(:,1),sf_mean_matrix2(:,2),sf_std_matrix2(:,2),'--','linewidth',1,'Color','blue'); M2 = 'PAS-2-fiber';
    
    [sf_mean_matrix3,sf_std_matrix3] = report_dev_three_fiber_sf_three_trials(mask);
    a3 = errorbar(sf_mean_matrix3(:,1),sf_mean_matrix3(:,2),sf_std_matrix3(:,2),'--','linewidth',1,'Color','green'); M3 = 'PAS-3-fiber';
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/Qball_sh8'))
    
    [sf_mean_matrix4,sf_std_matrix4] = report_dev_single_fiber_sf_three_trials(mask);
    a4 = errorbar(sf_mean_matrix4(:,1),sf_mean_matrix4(:,2),sf_std_matrix4(:,2),'linewidth',1,'Color','black'); M4 = 'Qball-1-fiber';
    
    [sf_mean_matrix5,sf_std_matrix5] = report_dev_two_fiber_sf_three_trials(mask);
    a5 = errorbar(sf_mean_matrix5(:,1),sf_mean_matrix5(:,2),sf_std_matrix5(:,2),'linewidth',1,'Color','yellow'); M5 = 'Qball-2-fiber';
    
    [sf_mean_matrix6,sf_std_matrix6] = report_dev_three_fiber_sf_three_trials(mask);
    a6 = errorbar(sf_mean_matrix6(:,1),sf_mean_matrix6(:,2),sf_std_matrix6(:,2),'linewidth',1,'Color','magenta'); M6 = 'Qball-3-fiber';
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/Qball_sh8'))
    
    xlabel('FA','fontweight','demi','fontsize',12)
    ylabel('Success Fraction','fontweight','demi','fontsize',12);
    legend([a1,a2,a3,a4,a5,a6],M1,M2,M3,M4,M5,M6);
    
    xlim([0 1])
    ylim([0 100])

end