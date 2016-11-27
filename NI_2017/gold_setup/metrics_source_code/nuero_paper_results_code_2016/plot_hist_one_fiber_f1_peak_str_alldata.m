function accum_angles = plot_hist_one_fiber_f1_peak_str_alldata(mask)

    accum_angles = [];
    fa_file = 'gold_fa.nii';
    
    for i = 1:11
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = peak_strength_f1_one_fiber_2dhist(fa_file,peaks_file,mask);
        accum_angles = [accum_angles;variable.(my_field_1)];
        
        %angle_col = variable.(my_field_1)(:,2);
        %accum_angles = [accum_angles,angle_col];
    end
    
end

    