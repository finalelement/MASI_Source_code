function report_deviation
    
    [gold_max,gold_min] = min_reported_angle_f('501_gold_fa.nii','501_gold_peaks.Bdouble');
    final_output_min = [];
    final_output_max = [];
    for i = 1:12
        fa_file = '501_gold_fa.nii';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        [variable.(my_field_1),variable.(my_field_2)] = min_reported_angle_f(fa_file,peaks_file);
        
        max_col = variable.(my_field_1)(:,2);
        min_col = variable.(my_field_2)(:,2);
        
        final_output_max = [final_output_max,max_col];
        final_output_min = [final_output_min,min_col]; 
    end
    
    min_std = std(final_output_min,0,2);
    max_std = std(final_output_max,0,2);
    
    min_std_matrix = gold_min(:,1);
    min_std_matrix = [min_std_matrix,min_std];
    
    max_std_matrix = gold_max(:,1);
    max_std_matrix = [max_std_matrix,max_std];
    
    min_mean = mean(final_output_min,2);
    max_mean = mean(final_output_max,2);
    
    min_mean_matrix = gold_min(:,1);
    min_mean_matrix = [min_mean_matrix,min_mean];
    
    max_mean_matrix = gold_max(:,1);
    max_mean_matrix = [max_mean_matrix,max_mean];
    
    final_output = [min_mean_matrix;max_mean_matrix];
    
    figure(2)
    scatter(final_output(:,1),final_output(:,2));
    hold on;
    a1 = errorbar(max_mean_matrix(:,1),max_mean_matrix(:,2),max_std_matrix(:,2),'linewidth',1.5); M1 = 'Max Angle w std';
    a2 = errorbar(min_mean_matrix(:,1),min_mean_matrix(:,2),min_std_matrix(:,2),'--','linewidth',1.5); M2 = 'Min Angle w std';
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Minimum Crossing Angle b/w 2 Fibers','fontweight','demi','fontsize',12);
    legend([a1,a2],M1,M2);
    title('Crossing Angle b/w two fibres of WM');
end