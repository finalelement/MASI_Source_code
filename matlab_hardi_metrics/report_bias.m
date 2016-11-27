% This will report the bias across all the samples which is the average of
% the errors from the observed/truth when compared to the predicted/test.

function report_bias
    [gold_max,gold_min] = min_reported_angle_f('501_gold_fa.nii','501_gold_peaks.Bdouble');
    
    % Calculating the min reported angles for the test sets
    % A is max angle and B is min angle
    final_output = [gold_max;gold_min];
    final_output_min = [];
    final_output_max = [];
    for i = 1:12
        fa_file = '501_gold_fa.nii';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        my_field_2 = strcat('B',num2str(i));
        [variable.(my_field_1),variable.(my_field_2)] = min_reported_angle_f(fa_file,peaks_file);
        
        max_col = variable.(my_field_1)(:,2);
        min_col = variable.(my_field_2)(:,2);
        
        final_output_max = [final_output_max,max_col];
        final_output_min = [final_output_min,min_col];
        
    end
    min_bias = gold_min(:,2) - mean(final_output_min,2);
    max_bias = gold_max(:,2) - mean(final_output_max,2);
    
    min_bias_matrix = gold_min(:,1);
    min_bias_matrix = [min_bias_matrix,min_bias];
    
    max_bias_matrix = gold_max(:,1);
    max_bias_matrix = [max_bias_matrix,max_bias];
    
    figure(1)
    scatter(final_output(:,1),final_output(:,2));
    hold on;
    a1 = errorbar(gold_max(:,1),gold_max(:,2),max_bias_matrix(:,2),'linewidth',1.5); M1 = 'Max Angle w bias';
    a2 = errorbar(gold_min(:,1),gold_min(:,2),min_bias_matrix(:,2),'--','linewidth',1.5); M2 = 'Min Angle w bias';
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Minimum Crossing Angle b/w 2 Fibers','fontweight','demi','fontsize',12);
    legend([a1,a2],M1,M2);
    title('Crossing Angle b/w two fibres of WM');
end