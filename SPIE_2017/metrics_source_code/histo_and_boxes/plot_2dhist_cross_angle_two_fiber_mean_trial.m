function plot_2dhist_cross_angle_two_fiber_mean_trial

    accum_angles = [];
    gold_peaks_file = '501_gold_peaks.Bdouble';
    fa_file = '501_gold_fa.nii';
    gold_matrix = min_cross_angle_two_fibers_2dhist(fa_file,gold_peaks_file);
    gold_size = size(gold_matrix(:,1));
    %gold_matrix = sort(gold_matrix(:,1));
    
    for i = 1:12
        
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = min_cross_angle_two_fibers_2dhist(fa_file,peaks_file);
        accum_angles = [accum_angles;variable.(my_field_1)];
        
        
    end
    
    
end