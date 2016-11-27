% Report deviation across 12 sample sets of PAS and DT. 

function dt_disagreement_single_fiber_report_deviation
    
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
        
        [variable.(my_field_1),variable.(my_field_2),variable.(my_field_3)] = dt_disagreement_single_fiber(fa_file,dt_file,peaks_file);
        
        min_col = variable.(my_field_1)(:,2);
        max_col = variable.(my_field_2)(:,2);
        mean_col = variable.(my_field_3)(:,2);
        
        final_output_max = [final_output_max,max_col];
        final_output_min = [final_output_min,min_col];
        final_output_mean = [final_output_mean,mean_col];
    end
    
    min_std = std(final_output_min,0,2);
    max_std = std(final_output_max,0,2);
    mean_std = std(final_output_mean,0,2);
    
    min_std_matrix = variable.(my_field_1)(:,1);
    min_std_matrix = [min_std_matrix,min_std];
    
    max_std_matrix = variable.(my_field_2)(:,1);
    max_std_matrix = [max_std_matrix,max_std];
    
    mean_std_matrix = variable.(my_field_3)(:,1);
    mean_std_matrix = [mean_std_matrix,mean_std];
    
    min_mean = mean(final_output_min,2);
    max_mean = mean(final_output_max,2);
    mean_mean = mean(final_output_mean,2);
    
    min_mean_matrix = variable.(my_field_1)(:,1);
    min_mean_matrix = [min_mean_matrix,min_mean];
    
    max_mean_matrix = variable.(my_field_2)(:,1);
    max_mean_matrix = [max_mean_matrix,max_mean];
    
    mean_mean_matrix = variable.(my_field_3)(:,1);
    mean_mean_matrix = [mean_mean_matrix,mean_mean];
    
    figure(1)
    hold on;
    
    a1 = errorbar(max_mean_matrix(:,1),max_mean_matrix(:,2),max_std_matrix(:,2),'linewidth',1.5); M1 = 'Max Angle w std';
    a2 = errorbar(min_mean_matrix(:,1),min_mean_matrix(:,2),min_std_matrix(:,2),'--','linewidth',1.5); M2 = 'Min Angle w std';
    a3 = errorbar(mean_mean_matrix(:,1),mean_mean_matrix(:,2),mean_std_matrix(:,2),'-.','linewidth',1.5); M3 = 'Mean Angle w std';
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Angle b/w DT and PAS direction','fontweight','demi','fontsize',12);
    legend([a1,a2,a3],M1,M2,M3);
    title('PAS Disagreement w DT 1 Fiber case across 12 samples');
    
end
