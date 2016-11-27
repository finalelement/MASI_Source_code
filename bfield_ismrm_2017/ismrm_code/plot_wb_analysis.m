function plot_wb_analysis
    
    r1_x = [1 2 3 4];
    [means_roi1,stds_roi1] = diff_of_diffs(1);
    
    figure(1)
    clf;
    hold on;
    a1=errorbar(r1_x,means_roi1,stds_roi1,'x');
    
    ylabel('Agreement')
    xlabel('b-values')
    title('MD pre and after correction Agreement (16 NG)')
    grid on;
end