function plot_all_bvalues_report_dev_sf_cross_angle_error

    figure(1);
    hold on;
    title('SF for Crossing Angle for 11 samples across bvalues 1000,1500,2000,2500,3000');

    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    [sf_mean_matrix1,sf_std_matrix1,t11] = report_dev_sf_cross_angle_error;
    
    a1 = errorbar(sf_mean_matrix1(:,1),sf_mean_matrix1(:,2),sf_std_matrix1(:,2),'linewidth',1.5); M1 = 'b1000';
    % t1 = text(sf_mean_matrix1(:,1),sf_mean_matrix1(:,2),t11,'Color','red');

    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1500/PAS16')) 
    
    [sf_mean_matrix2,sf_std_matrix2,t22] = report_dev_sf_cross_angle_error;
    
    a2 = errorbar(sf_mean_matrix2(:,1),sf_mean_matrix2(:,2),sf_std_matrix2(:,2),'linewidth',1.5); M2 = 'b1500';
    % t2 = text(sf_mean_matrix2(:,1),sf_mean_matrix2(:,2),t22,'Color','red');

    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1500/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b2000/PAS16')) 

    [sf_mean_matrix3,sf_std_matrix3,t33] = report_dev_sf_cross_angle_error;
    
    a3 = errorbar(sf_mean_matrix3(:,1),sf_mean_matrix3(:,2),sf_std_matrix3(:,2),'linewidth',1.5); M3 = 'b2000';
    % t3 = text(sf_mean_matrix3(:,1),sf_mean_matrix3(:,2),t33,'Color','red');
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b2000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b2500/PAS16')) 
    
    [sf_mean_matrix4,sf_std_matrix4,t44] = report_dev_sf_cross_angle_error;
    
    a4 = errorbar(sf_mean_matrix4(:,1),sf_mean_matrix4(:,2),sf_std_matrix4(:,2),'linewidth',1.5); M4 = 'b2500';
    % t4 = text(sf_mean_matrix4(:,1),sf_mean_matrix4(:,2),t44,'Color','red');
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b2500/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16')) 
    
    [sf_mean_matrix5,sf_std_matrix5,t55] = report_dev_sf_cross_angle_error;
    
    a5 = errorbar(sf_mean_matrix5(:,1),sf_mean_matrix5(:,2),sf_std_matrix5(:,2),'linewidth',1.5); M5 = 'b3000';
    % t5 = text(sf_mean_matrix5(:,1),sf_mean_matrix5(:,2),t55,'Color','red');
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16'))
    
    xlabel('Crossing Angles','fontweight','demi','fontsize',12)
    ylabel('Success Fraction','fontweight','demi','fontsize',12);
    legend([a1,a2,a3,a4,a5],M1,M2,M3,M4,M5);

end