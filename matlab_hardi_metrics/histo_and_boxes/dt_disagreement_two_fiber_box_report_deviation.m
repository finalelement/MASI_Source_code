% Report deviation across 12 sample sets of PAS and DT. 

function dt_disagreement_two_fiber_box_report_deviation
    
    accum_matrix = [];
    final_output_mean = [];

    for i = 1:12
        fa_file = '501_gold_fa.nii';
        dt_file = sprintf('test_%d_dteig.Bdouble',i);
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        
        [variable.(my_field_1),variable.(my_field_2)] = dt_disagreement_two_fiber_box(fa_file,dt_file,peaks_file);
        
        % Accumulating data from all 12 samples
        accum_matrix = [accum_matrix;variable.(my_field_1)];
        
        % Accumulating the mean column for all 12 samples
        mean_col = variable.(my_field_2)(:,2);
        final_output_mean = [final_output_mean,mean_col];
      
    end
    
    mean_std = std(final_output_mean,0,2);
    
    mean_std_matrix = variable.(my_field_2)(:,1);
    mean_std_matrix = [mean_std_matrix,mean_std];
    
    mean_mean = mean(final_output_mean,2);
    
    mean_mean_matrix = variable.(my_field_2)(:,1);
    mean_mean_matrix = [mean_mean_matrix,mean_mean];
  
    figure(1)
    hold on;
    
    temp = 0;
    
    max_fa = max(accum_matrix(:,1));
    i = 1;
    angles_out = [];
    fa_out = [];

    while (temp < max_fa)
       beg_limit = temp;
       end_limit = temp + 0.1;
       col1 = accum_matrix(:,1);
       col2 = accum_matrix(:,2);
       index = find((beg_limit < col1) & (col1 < end_limit));
       angles = col2(index);
       angles_out = [angles_out;angles];
       
       fa_val = ((beg_limit + end_limit)/2) * 1000;
       
       ty = zeros(length(angles),1) + i;
       fa_out = [fa_out;ty];
      
       temp = temp + 0.1;
       i = i + 1;
    end
    
    this_the_crap = boxplot(angles_out,fa_out);
    mean_plot = errorbar(mean_mean_matrix(:,2),mean_std_matrix(:,2),'xm','linewidth',1.5);
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Angle b/w DT and PAS direction','fontweight','demi','fontsize',12);

    title('PAS Disagreement w DT 2 Fiber case - 12 samples');
    
end
