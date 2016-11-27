function true_error_symmetric_pas_b1000

    mask = 'WM_nuero_mask.nii';
    
    figure(1);
    hold on;
    
    title('Symmetrized Error of Peaks PAS at b-value 1000');
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    [sf_mean_matrix1,sf_std_matrix1] = peak_to_peak_single_fiber_error_box_report_deviation_nuero(mask);
    a1 = errorbar(sf_mean_matrix1(:,1),sf_mean_matrix1(:,2),sf_std_matrix1(:,2),'linewidth',1,'Color','red'); M1 = '1-fiber';
    
    [sf_mean_matrix2,sf_std_matrix2] = peak_to_peak_two_fiber_error_box_report_deviation_nuero(mask);
    a2 = errorbar(sf_mean_matrix2(:,1),sf_mean_matrix2(:,2),sf_std_matrix2(:,2),'-.','linewidth',1,'Color','blue'); M2 = '2-fiber';
    
    [sf_mean_matrix3,sf_std_matrix3] = peak_to_peak_three_fiber_error_box_report_deviation_nuero(mask);
    a3 = errorbar(sf_mean_matrix3(:,1),sf_mean_matrix3(:,2),sf_std_matrix3(:,2),':','linewidth',1,'Color','green'); M3 = '3-fiber';
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))

    xlabel('FA','fontweight','demi','fontsize',12)
    ylabel('Symettric Error','fontweight','demi','fontsize',12);
    leg = legend([a1,a2,a3],M1,M2,M3);
    set(leg,'Location','northeast')
    xlim([0 1])
    ylim([0 40])
    set(gca,'XTick',0:0.1:1)
    grid on
    
    file_name = sprintf('pas_error_b1000');
    print(file_name,'-depsc2','-r0')

end
