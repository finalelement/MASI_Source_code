function plot_2dhist_peak_strength_two_fiber_alldata

    accum_angles = [];
    
    for i = 1:12
        fa_file = '501_gold_fa.nii';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = peak_strength_two_fiber(fa_file,peaks_file);
        accum_angles = [accum_angles;variable.(my_field_1)];
        
        %angle_col = variable.(my_field_1)(:,2);
        %accum_angles = [accum_angles,angle_col];
    end
    
    figure(1);
    hold on;
    hist3(accum_angles,[20 20]);
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    
    % Extract histogram data
    n = hist3(accum_angles,[20 20]);
    n1 = n';
    n1(size(n,1) + 1, size(n,2) + 1) = 0;
    
    % Generate grid for 2-D projected view of intensities.
    xb = linspace(min(accum_angles(:,1)),max(accum_angles(:,1)),size(n,1)+1);
    yb = linspace(min(accum_angles(:,2)),max(accum_angles(:,2)),size(n,1)+1);
    
    % Make a pseudocolor plot.
    h = pcolor(xb,yb,n1);
    
    h.ZData = ones(size(n1)) * -max(max(n));
    colormap(jet); % spring heat map
    title('Two Fiber Case:Peak Strength 12 samples & Intensity Map');
    grid on
    view(3);
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    ylabel('Peak Strength','fontweight','demi','fontsize',12);
    zlabel('Number of Voxels','fontweight','demi','fontsize',12);

    
    %overall_matrix = variable.(A1)(:,1);
    %overall_matrix = [overall_matrix,mean(accum_angles)];
    
end