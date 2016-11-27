function plot_2dhist_cross_angle_two_fiber

    accum_angles = [];
    
    for i = 1:12
        fa_file = '501_gold_fa.nii';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = min_cross_angle_two_fibers_2dhist(fa_file,peaks_file);
        accum_angles = [accum_angles;variable.(my_field_1)];
        
        %angle_col = variable.(my_field_1)(:,2);
        %accum_angles = [accum_angles,angle_col];
    end
    
    figure(1);
    hold on;
    hist3(accum_angles,[20 20]);
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    colormap(spring)
    
    %overall_matrix = variable.(A1)(:,1);
    %overall_matrix = [overall_matrix,mean(accum_angles)];
    
end