function [sf_mean_matrix,sf_std_matrix] = report_dev_three_fiber_sf_three_trials(mask)
    %{
    overall_output = [];
    for i = 1:10
        fa_file = 'test_11_fa.nii';
        gold_file = 'test_11_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = success_fraction_three_fiber(fa_file,gold_file,peaks_file,5,rois,rois_region);
        
        sf_col = variable.(my_field_1)(:,2);
        
        overall_output = [overall_output,sf_col];
    end
    
    sf_std = std(overall_output,0,2);
    sf_std_matrix = variable.(my_field_1)(:,1);
    sf_std_matrix = [sf_std_matrix,sf_std];
    
    sf_mean = mean(overall_output,2);
    sf_mean_matrix = variable.(my_field_1)(:,1);
    sf_mean_matrix = [sf_mean_matrix,sf_mean];
    
    
    a1 = errorbar(sf_mean_matrix(:,1),sf_mean_matrix(:,2),sf_std_matrix(:,2),'linewidth',1.5); M1 = 'tolerance-5';
    %}
    
    %out = figure(1);
    %hold on;
    
    %{
    overall_output = [];
    for i = 1:10
        fa_file = 'test_11_fa.nii';
        gold_file = 'test_11_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = success_fraction_three_fiber(fa_file,gold_file,peaks_file,10,rois,rois_region);
        
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
    %}
    
    overall_output = [];
    for i = 1:11
        fa_file = 'gold_fa.nii';
        gold_file = 'gold_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = success_fraction_three_fiber(fa_file,gold_file,peaks_file,20,mask);
        
        sf_col = variable.(my_field_1)(:,2);
        
        overall_output = [overall_output,sf_col];
    end
    
    sf_std = std(overall_output,0,2);
    sf_std_matrix = variable.(my_field_1)(:,1);
    sf_std_matrix = [sf_std_matrix,sf_std];
    
    sf_mean = mean(overall_output,2);
    sf_mean_matrix = variable.(my_field_1)(:,1);
    sf_mean_matrix = [sf_mean_matrix,sf_mean];
    
    %{
    a3 = errorbar(sf_mean_matrix(:,1),sf_mean_matrix(:,2),sf_std_matrix(:,2),'linewidth',1.5); M3 = 'tolerance-NA';
    t1 = text(sf_mean_matrix(:,1),sf_mean_matrix(:,2),num2str(variable.A1(:,3)),'Color','red');
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('SF for three fiber','fontweight','demi','fontsize',12);
    legend(a3,M3);
    title('SF 3 Fiber case for 11 samples');
    %}
end