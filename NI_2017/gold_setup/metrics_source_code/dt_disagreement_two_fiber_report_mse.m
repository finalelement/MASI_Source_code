function out = dt_disagreement_two_fiber_report_mse(mask)

    fa_file = 'gold_fa.nii';
    [gold_min,gold_max,gold_mean] = dt_disagreement_two_fiber(fa_file,'gold_dteig.Bdouble','gold_peaks.Bdouble',mask);
    
    final_output_min = [];
    final_output_max = [];
    final_output_mean = [];
    
    for i = 1:11
        fa_file = 'gold_fa.nii';
        dt_file = sprintf('test_%d_dteig.Bdouble',i);
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        my_field_3 = strcat('C',num2str(i));
        
        [variable.(my_field_1),variable.(my_field_2),variable.(my_field_3)] = dt_disagreement_two_fiber(fa_file,dt_file,peaks_file,mask);
        
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
    
    min_std = std(final_output_min,0,2);
    max_std = std(final_output_max,0,2);
    mean_std = std(final_output_mean,0,2);
    
    min_bias_matrix = gold_min(:,1);
    min_bias_matrix = [min_bias_matrix,min_bias];
    
    max_bias_matrix = gold_max(:,1);
    max_bias_matrix = [max_bias_matrix,max_bias];
    
    mean_bias_matrix = gold_mean(:,1);
    mean_bias_matrix = [mean_bias_matrix,mean_bias];
    
    min_std_matrix = gold_min(:,1);
    min_std_matrix = [min_std_matrix,min_std];
    
    max_std_matrix = gold_max(:,1);
    max_std_matrix = [max_std_matrix,max_std];
    
    mean_std_matrix = gold_mean(:,1);
    mean_std_matrix = [mean_std_matrix,mean_std];
    
    min_mse_matrix = gold_min(:,1);
    min_mse_matrix = [min_mse_matrix,((min_bias_matrix(:,2).^2) + (min_std_matrix(:,2).^2))];
    
    max_mse_matrix = gold_max(:,1);
    max_mse_matrix = [max_mse_matrix,((max_bias_matrix(:,2).^2) + (max_std_matrix(:,2).^2))];
    
    mean_mse_matrix = gold_mean(:,1);
    mean_mse_matrix = [mean_mse_matrix,((mean_bias_matrix(:,2).^2) + (mean_std_matrix(:,2).^2))];
    out = figure(1);

    a1 = semilogy(min_mse_matrix(:,1),min_mse_matrix(:,2),'linewidth',1.5); M1 = 'Min Angle MSE with Gold';
    hold on;
    a2 = semilogy(max_mse_matrix(:,1),max_mse_matrix(:,2),'--','linewidth',1.5); M2 = 'Max Angle MSE with Gold';
    a3 = semilogy(mean_mse_matrix(:,1),mean_mse_matrix(:,2),'-.','linewidth',1.5); M3 = 'Mean Angle MSE with Gold';
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Mean Square Error','fontweight','demi','fontsize',12);
    legend([a1,a2,a3],M1,M2,M3);
    title('MSE Plot 2 Fiber DT Disagreement - 11 samples');
    
    
end