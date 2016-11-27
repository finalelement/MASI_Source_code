function out = plot_2dhist_cross_angle_two_fiber_alldata(mask)

    accum_angles = [];
    
    for i = 1:11
        fa_file = 'gold_fa.nii';
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        [variable.(my_field_1)] = min_cross_angle_two_fibers_2dhist(fa_file,peaks_file,mask);
        accum_angles = [accum_angles;variable.(my_field_1)];
        
        %angle_col = variable.(my_field_1)(:,2);
        %accum_angles = [accum_angles,angle_col];
    end
    
    out = figure(1);
    clf;
    hold on;
    if(isempty(accum_angles))
        accum_angles = [0 0];
    end
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
    title('Two Fiber Case:Angle of Separation 11 samples & Intensity Map');
    grid on
    view(3);
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    ylabel('Angle of Separation','fontweight','demi','fontsize',12);
    zlabel('Number of Voxels','fontweight','demi','fontsize',12);

    
    %overall_matrix = variable.(A1)(:,1);
    %overall_matrix = [overall_matrix,mean(accum_angles)];
    
end