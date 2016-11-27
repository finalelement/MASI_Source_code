% Calls the success_fraction_two_fiber for repeating success fraction for
% one fiber case for different N samples in this case 12 samples exist.

function out = report_dev_two_fiber_sf_three_trials
    overall_output = [];
    for i = 1:11
        fa_file = 'gold_fa.nii';
        gold_file = 'gold_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = success_fraction_two_fiber(fa_file,gold_file,peaks_file,5);
        
        sf_col = variable.(my_field_1)(:,2);
        
        overall_output = [overall_output,sf_col];
    end
    
    sf_std = std(overall_output,0,2);
    sf_std_matrix = variable.(my_field_1)(:,1);
    sf_std_matrix = [sf_std_matrix,sf_std];
    
    sf_mean = mean(overall_output,2);
    sf_mean_matrix = variable.(my_field_1)(:,1);
    sf_mean_matrix = [sf_mean_matrix,sf_mean];
    
    out = figure(1);
    hold on;
    a1 = errorbar(sf_mean_matrix(:,1),sf_mean_matrix(:,2),sf_std_matrix(:,2),'linewidth',1.5); M1 = 'tolerance-5';
    
    
    overall_output = [];
    for i = 1:11
        fa_file = 'gold_fa.nii';
        gold_file = 'gold_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = success_fraction_two_fiber(fa_file,gold_file,peaks_file,10);
      
        sf_col = variable.(my_field_1)(:,2);
        
        overall_output = [overall_output,sf_col];
    end
    
    sf_std = std(overall_output,0,2);
    sf_std_matrix = variable.(my_field_1)(:,1);
    sf_std_matrix = [sf_std_matrix,sf_std];
    
    sf_mean = mean(overall_output,2);
    sf_mean_matrix = variable.(my_field_1)(:,1);
    sf_mean_matrix = [sf_mean_matrix,sf_mean];
    
    a2 = errorbar(sf_mean_matrix(:,1),sf_mean_matrix(:,2),sf_std_matrix(:,2),'linewidth',1.5); M2 = 'tolerance-10';
    
    
    overall_output = [];
    for i = 1:11
        fa_file = 'gold_fa.nii';
        gold_file = 'gold_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = success_fraction_two_fiber(fa_file,gold_file,peaks_file,15);
      
        sf_col = variable.(my_field_1)(:,2);
        
        overall_output = [overall_output,sf_col];
    end
    
    sf_std = std(overall_output,0,2);
    sf_std_matrix = variable.(my_field_1)(:,1);
    sf_std_matrix = [sf_std_matrix,sf_std];
    
    sf_mean = mean(overall_output,2);
    sf_mean_matrix = variable.(my_field_1)(:,1);
    sf_mean_matrix = [sf_mean_matrix,sf_mean];
    
    a3 = errorbar(sf_mean_matrix(:,1),sf_mean_matrix(:,2),sf_std_matrix(:,2),'linewidth',1.5); M3 = 'tolerance-15';
    t1 = text(sf_mean_matrix(:,1),sf_mean_matrix(:,2),num2str(variable.A1(:,3)),'Color','red');
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('SF for two fiber','fontweight','demi','fontsize',12);
    legend([a1,a2,a3],M1,M2,M3);
    title('SF 2 Fiber case for 11 samples');
    
        
    
end