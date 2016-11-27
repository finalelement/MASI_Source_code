function plot_diff_of_diffs
    
    r1_x = [0.8 1.8 2.8 3.8];
    r2_x = [0.9 1.9 2.9 3.9];
    r3_x = [1 2 3 4];
    r4_x = [1.1 2.1 3.1 4.1];
    
    % looping over different roi's
    [means_roi1,stds_roi1] = diff_of_diffs(1);
    [means_roi2,stds_roi2] = diff_of_diffs(2);
    [means_roi3,stds_roi3] = diff_of_diffs(3);
    [means_roi4,stds_roi4] = diff_of_diffs(4);
    
    figure(1)
    clf;
    hold on;
    a1=errorbar(r1_x,means_roi1,stds_roi1,'x');
    a2=errorbar(r2_x,means_roi2,stds_roi2,'o');
    a3=errorbar(r3_x,means_roi3,stds_roi3,'d');
    a4=errorbar(r4_x,means_roi4,stds_roi4,'*');
    
    ylabel('Agreement')
    xlabel('b-values')
    title('MD pre and after correction Agreement (16 NG)')
    legend([a1 a2 a3 a4],'CC','IC','Notsure','Cen Semiov');
    grid on;
end