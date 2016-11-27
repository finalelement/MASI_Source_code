function all_fiber_pas_gold_qball_reps_sf
    
    mask = 'WM_nuero_mask.nii';
    
    figure(2);
    hold on;
    
    title('SF Single Fiber Peaks Gold PAS & Q-ball reps at b-value 1000');
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS_gold_Qball_reps'))
    
    [sf_mean_matrix1,sf_std_matrix1] = report_dev_single_fiber_sf_three_trials(mask);
    a1 = errorbar(sf_mean_matrix1(:,1),sf_mean_matrix1(:,2),sf_std_matrix1(:,2),'--','linewidth',1,'Color','red'); M1 = '1-fiber';
    
    [sf_mean_matrix2,sf_std_matrix2] = report_dev_two_fiber_sf_three_trials(mask);
    a2 = errorbar(sf_mean_matrix2(:,1),sf_mean_matrix2(:,2),sf_std_matrix2(:,2),'linewidth',1,'Color','black'); M2 = '2-fiber';
    
    [sf_mean_matrix3,sf_std_matrix3] = report_dev_three_fiber_sf_three_trials(mask);
    a3 = errorbar(sf_mean_matrix3(:,1),sf_mean_matrix3(:,2),sf_std_matrix3(:,2),':','linewidth',1,'Color','blue'); M3 = '3-fiber';

    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS_gold_Qball_reps'))
    xlabel('FA','fontweight','demi','fontsize',12)
    ylabel('Success Fraction','fontweight','demi','fontsize',12);
    leg = legend([a1,a2,a3],M1,M2,M3);
    set(leg,'Location','northwest')
    xlim([0 1])
    ylim([0 100])
    set(gca,'XTick',0:0.1:1)
    grid on


end