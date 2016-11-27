function sf_two_fiber_pas_qball_b1000_b3000

    mask = 'WM_nuero_mask.nii';
    
    figure(2);
    hold on;
    
    title('Two Fiber Case');
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    [sf_mean_matrix1,sf_std_matrix1] = report_dev_two_fiber_sf_three_trials(mask);
    a1 = errorbar(sf_mean_matrix1(:,1),sf_mean_matrix1(:,2),sf_std_matrix1(:,2),'--','linewidth',1,'Color','red'); M1 = 'PAS-b1000';
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/Qball_sh8'))
    
    [sf_mean_matrix2,sf_std_matrix2] = report_dev_two_fiber_sf_three_trials(mask);
    a2 = errorbar(sf_mean_matrix2(:,1),sf_mean_matrix2(:,2),sf_std_matrix2(:,2),'linewidth',1,'Color','black'); M2 = 'Qball-b1000';
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/Qball_sh8'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16'))
    
    [sf_mean_matrix3,sf_std_matrix3] = report_dev_two_fiber_sf_three_trials(mask);
    a3 = errorbar(sf_mean_matrix3(:,1),sf_mean_matrix3(:,2),sf_std_matrix3(:,2),':','linewidth',1,'Color','blue'); M3 = 'PAS-b3000';
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/Qball_sh8'))
    
    [sf_mean_matrix4,sf_std_matrix4] = report_dev_two_fiber_sf_three_trials(mask);
    a4 = errorbar(sf_mean_matrix4(:,1),sf_mean_matrix4(:,2),sf_std_matrix4(:,2),'-.','linewidth',1,'Color','green'); M4 = 'Qball-b3000';
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/Qball_sh8'))
    
    
    xlabel('FA','fontweight','demi','fontsize',12)
    ylabel('Success Fraction','fontweight','demi','fontsize',12);
    leg = legend([a1,a2,a3,a4],M1,M2,M3,M4);
    set(leg,'Location','northeast')
    xlim([0 1])
    ylim([0 100])
    set(gca,'XTick',0:0.1:1)
    grid on
    
    file_name = sprintf('two_fiber_sf');
    print(file_name,'-depsc2','-r0')

end