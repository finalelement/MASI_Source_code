function cross_angle_two_fiber_report_bias

    fa_file = '501_gold_fa.nii';
    [gold_min,gold_max,gold_mean] = min_cross_angle_three_fibers(fa_file,'501_gold_peaks.Bdouble');
    
    final_output_min = [];
    final_output_max = [];
    final_output_mean = [];
    
    for i = 1:12
        fa_file = '501_gold_fa.nii';
        dt_file = sprintf('test_%d_dteig.Bdouble',i);
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        my_field_3 = strcat('C',num2str(i));
        
        [variable.(my_field_1),variable.(my_field_2),variable.(my_field_3)] = min_cross_angle_three_fibers(fa_file,peaks_file);
        
        min_col = variable.(my_field_1)(:,2);
        max_col = variable.(my_field_2)(:,2);
        mean_col = variable.(my_field_3)(:,2);
        
        final_output_max = [final_output_max,max_col];
        final_output_min = [final_output_min,min_col];
        final_output_mean = [final_output_mean,mean_col];
    end
    
    min_bias = gold_min(:,2) - mean(final_output_min,2);
    max_bias = gold_max(:,2) - mean(final_output_max,2);
    mean_bias = gold_mean(:,2) - mean(final_output_mean,2);
    
    min_bias_matrix = gold_min(:,1);
    min_bias_matrix = [min_bias_matrix,min_bias];
    
    max_bias_matrix = gold_max(:,1);
    max_bias_matrix = [max_bias_matrix,max_bias];
    
    mean_bias_matrix = gold_mean(:,1);
    mean_bias_matrix = [mean_bias_matrix,mean_bias];
    
    figure(1)
    hold on;
    
    a1 = plot(min_bias_matrix(:,1),min_bias_matrix(:,2),'linewidth',1.5); M1 = 'Min Angle bias with Gold';
    a2 = plot(max_bias_matrix(:,1),max_bias_matrix(:,2),'--','linewidth',1.5); M2 = 'Max Angle bias with Gold';
    a3 = plot(mean_bias_matrix(:,1),mean_bias_matrix(:,2),'-.','linewidth',1.5); M3 = 'Mean Angle bias with Gold';
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Bias','fontweight','demi','fontsize',12);
    legend([a1,a2,a3],M1,M2,M3);
    title('Bias Plot 3 Fiber Cross Angle - 12 samples');


end