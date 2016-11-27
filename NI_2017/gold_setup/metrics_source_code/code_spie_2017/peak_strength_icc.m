function peak_strength_icc(number_of_fibers)
    
    accum_matrix_nf1 = [];
    accum_matrix_nf2 = [];
    accum_matrix_nf3 = [];
    peaks_gold = 'gold_peaks.Bdouble';
    fa = 'gold_fa.nii';
    for i = 1:11
       
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        my_field_3 = strcat('C',num2str(i));
        
        [variable.(my_field_1),variable.(my_field_2),variable.(my_field_3)] = single_scan_peak_strengths(fa,peaks_gold,peaks_file,number_of_fibers);
        
        accum_matrix_nf1 = [accum_matrix_nf1,variable.(my_field_1)];
        accum_matrix_nf2 = [accum_matrix_nf2,variable.(my_field_2)];
        accum_matrix_nf3 = [accum_matrix_nf3,variable.(my_field_3)];
        
    end
    
    [r, LB, UB, F, df1, df2, p] = ICC(accum_matrix_nf1,'1-1',0.05,0)
    
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    
    [r, LB, UB, F, df1, df2, p] = ICC(accum_matrix_nf2,'1-1',0.05,0)
    
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    
    [r, LB, UB, F, df1, df2, p] = ICC(accum_matrix_nf3,'1-1',0.05,0)
     
end