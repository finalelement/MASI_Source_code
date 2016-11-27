function plot_2dhist_cross_angle_two_fiber_gold
    
    fa_file = 'gold_fa.nii';
    peaks_file = sprintf('gold_peaks.Bdouble');
    accum_angles = min_cross_angle_two_fibers_2dhist(fa_file,peaks_file);
    
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
    title('Two Fiber Case:Angle of Separation & Intensity Map (Gold Sample)');
    grid on
    view(3);
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    ylabel('Angle of Separation','fontweight','demi','fontsize',12);
    zlabel('Number of Voxels','fontweight','demi','fontsize',12);
end