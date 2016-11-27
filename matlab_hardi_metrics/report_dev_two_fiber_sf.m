% Calls the success_fraction_two_fiber for repeating success fraction for
% one fiber case for different N samples in this case 12 samples exist.

function report_dev_two_fiber_sf(tolerance)
    overall_output = [];
    for i = 1:12
        fa_file = '501_gold_fa.nii';
        gold_file = '501_gold_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = success_fraction_two_fiber(fa_file,gold_file,peaks_file,tolerance);
        
        sf_col = variable.(my_field_1)(:,2);
        
        overall_output = [overall_output,sf_col];
    end
    
    sf_std = std(overall_output,0,2);
    sf_std_matrix = variable.(my_field_1)(:,1);
    sf_std_matrix = [sf_std_matrix,sf_std];
    
    sf_mean = mean(overall_output,2);
    sf_mean_matrix = variable.(my_field_1)(:,1);
    sf_mean_matrix = [sf_mean_matrix,sf_mean];
    
    figure(1)
    hold on;
    a1 = errorbar(sf_mean_matrix(:,1),sf_mean_matrix(:,2),sf_std_matrix(:,2),'linewidth',1.5); M1 = 'SF two fiber w Std';
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('SF for two fiber','fontweight','demi','fontsize',12);
    legend([a1],M1);
    title('SF 2 Fiber case for 12 samples');
    
        
    
end