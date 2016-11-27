function [sf_mean_matrix,sf_std_matrix,spatial_data] = report_dev_three_fiber_sf_three_trials_spatial(mask)
    
    overall_output = [];
    for i = 1:11
        fa_file = 'gold_fa.nii';
        gold_file = 'gold_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        
        [variable.(my_field_1),variable.(my_field_2)] = success_fraction_three_fiber_spatial(fa_file,gold_file,peaks_file,20,mask);
        
        sf_col = variable.(my_field_1)(:,2);
        
        overall_output = [overall_output,sf_col];
    end
    spatial_data = variable.B1 + variable.B2 + variable.B3 + variable.B4 + variable.B5 + variable.B6 + variable.B7 + variable.B8 + variable.B9 + variable.B10 + variable.B11;

    sf_std = std(overall_output,0,2);
    sf_std_matrix = variable.(my_field_1)(:,1);
    sf_std_matrix = [sf_std_matrix,sf_std];
    
    sf_mean = mean(overall_output,2);
    sf_mean_matrix = variable.(my_field_1)(:,1);
    sf_mean_matrix = [sf_mean_matrix,sf_mean];
    
end