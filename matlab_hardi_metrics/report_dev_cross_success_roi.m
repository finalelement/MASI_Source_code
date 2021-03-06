function report_dev_cross_success_roi
    final_output_min = [];
    final_sf = [];
    label_file = 'multi_atlas_labels.nii';
    fa_file = '501_gold_fa.nii';
    pas_gold = '501_gold_peaks.Bdouble';
    roi_index = 10;
    
    for i = 1:12
        
        pas_test = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        [variable.(my_field_1),variable.(my_field_2)] = success_fraction_roi_f(label_file, ...
            roi_index,fa_file,pas_gold,pas_test);
        
        field_1 = strcat('A',num2str(1));
        matrix_dim_check = size(variable.(field_1)(:,2),1);
        sample_dim_check = size(variable.(my_field_1)(:,2),1);
        
        if (sample_dim_check == matrix_dim_check)
        
            min_col = variable.(my_field_1)(:,2);
            final_output_min = [final_output_min,min_col]; 
        
            sf_col = variable.(my_field_2)(:,1);
            final_sf = [final_sf;sf_col];
        end
    end
    
    
        
    min_std = std(final_output_min,0,2);
    
    min_std_matrix = variable.A1(:,1);
    min_std_matrix = [min_std_matrix,min_std];
    
    min_mean = mean(final_output_min,2);
    
    min_mean_matrix = variable.A1(:,1);
    min_mean_matrix = [min_mean_matrix,min_mean];
    
    mean_sf = mean(final_sf);
    
    figure(2)
    scatter(min_mean_matrix(:,1),min_mean_matrix(:,2));
    hold on;
    a1 = errorbar(min_mean_matrix(:,1),min_mean_matrix(:,2),min_std_matrix(:,2),'linewidth',1.5); 
    M1 = sprintf('Min Angle w STD & Angle Tolerance 5 degrees (%0.2f)',mean_sf);
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Minimum Crossing Angle b/w 2 Fibers','fontweight','demi','fontsize',12);
    
    
    % For 15 degree tolerance
    
    final_output_min = [];
    final_sf = [];
    
    for i = 1:12
        
        pas_test = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        [variable.(my_field_1),variable.(my_field_2)] = success_fraction_roi_f10(label_file, ...
            roi_index,fa_file,pas_gold,pas_test);
        
        field_1 = strcat('A',num2str(1));
        matrix_dim_check = size(variable.(field_1)(:,2),1);
        sample_dim_check = size(variable.(my_field_1)(:,2),1);
        
        if (sample_dim_check == matrix_dim_check)
        
            min_col = variable.(my_field_1)(:,2);
            final_output_min = [final_output_min,min_col]; 
        
            sf_col = variable.(my_field_2)(:,1);
            final_sf = [final_sf;sf_col];
        end
    end

    field_1 = strcat('A',num2str(1));
    matrix_dim_check = size(variable.(field_1)(:,2),1);
        
    min_std = std(final_output_min,0,2);
    
    min_std_matrix = variable.A1(:,1);
    min_std_matrix = [min_std_matrix,min_std];
    
    min_mean = mean(final_output_min,2);
    
    min_mean_matrix = variable.A1(:,1);
    min_mean_matrix = [min_mean_matrix,min_mean];
    
    mean_sf = mean(final_sf);
    
    a2 = errorbar(min_mean_matrix(:,1),min_mean_matrix(:,2),min_std_matrix(:,2),'--','linewidth',1.5); 
    M2 = sprintf('Min Angle w STD & Angle Tolerance 15 degrees (%0.2f)',mean_sf);
    
    legend([a1,a2],M1,M2);
    title('Crossing Angle of Test set w Success Fraction/ROI Brain Stem WM');
end
