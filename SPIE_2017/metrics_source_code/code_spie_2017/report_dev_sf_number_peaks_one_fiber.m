function out = report_dev_sf_number_peaks_one_fiber
    overall_output = [];
    for i = 1:11
        fa_file = 'gold_fa.nii';
        gold_file = 'gold_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = sf_number_peaks_one(fa_file,gold_file,peaks_file);
        
        sf_col = variable.(my_field_1)(:,2);
        
        overall_output = [overall_output,sf_col];
    end
    
    sf_std = std(overall_output,0,2);
    sf_std_matrix = variable.(my_field_1)(:,1);
    sf_std_matrix = [sf_std_matrix,sf_std];
    
    sf_mean = mean(overall_output,2);
    sf_mean_matrix = variable.(my_field_1)(:,1);
    sf_mean_matrix = [sf_mean_matrix,sf_mean];
    
    a1 = errorbar(sf_mean_matrix(:,1),sf_mean_matrix(:,2),sf_std_matrix(:,2),'linewidth',1.5); M1 = sprintf('No. of peaks - 1');
    t1 = text(sf_mean_matrix(:,1),sf_mean_matrix(:,2),num2str(variable.A1(:,3)),'Color','red');
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('SF for one fiber','fontweight','demi','fontsize',12);
    legend([a1],M1);
    title('Success Fraction for One fiber case for 11 samples');
    
    
end