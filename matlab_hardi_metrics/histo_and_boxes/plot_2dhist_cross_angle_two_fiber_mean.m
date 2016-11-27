function plot_2dhist_cross_angle_two_fiber_mean

    accum_angles = [];
    gold_peaks_file = '501_gold_peaks.Bdouble';
    fa_file = '501_gold_fa.nii';
    gold_matrix = min_cross_angle_two_fibers_2dhist(fa_file,gold_peaks_file);
    gold_size = size(gold_matrix(:,1));
    
    for i = 1:12
        
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = min_cross_angle_two_fibers_2dhist(fa_file,peaks_file);
        
        temp_size = size(variable.(my_field_1)(:,1));
        temp_accum = [];
        
        for j = 1:gold_size
            g_val = gold_matrix(j,1);
            
            for k = 1:temp_size
                t_val = variable.(my_field_1)(k,1);
                
                row = 0;
                if (g_val == t_val)
                    row = variable.(my_field_1)(k,2);
                    break
                end
                
            end
            temp_accum = [temp_accum;row];
        end
        
        
    end
    
    
end