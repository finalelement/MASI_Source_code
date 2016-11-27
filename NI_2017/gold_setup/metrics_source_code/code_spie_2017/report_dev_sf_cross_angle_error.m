function [sf_mean_matrix,sf_std_matrix,text_values] = report_dev_sf_cross_angle_error
    overall_output = [];
    for i = 1:11
        fa_file = 'gold_fa.nii';
        gold_file = 'gold_peaks.Bdouble';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        disp(peaks_file)
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = sf_cross_angle_error(fa_file,gold_file,peaks_file);
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
    
    text_values = num2str(variable.A1(:,3));
    %{
    a1 = errorbar(sf_mean_matrix(:,1),sf_mean_matrix(:,2),sf_std_matrix(:,2),'linewidth',1.5); M1 = 'b1000';
    t1 = text(sf_mean_matrix(:,1),sf_mean_matrix(:,2),text_values,'Color','red');
    
    
    xlabel('Crossing Angles','fontweight','demi','fontsize',12)
    ylabel('Success Fraction','fontweight','demi','fontsize',12);
    legend([a1,a2,a3],M1,M2,M3);
    title('SF for Crossing Angle for 11 samples');
    %}