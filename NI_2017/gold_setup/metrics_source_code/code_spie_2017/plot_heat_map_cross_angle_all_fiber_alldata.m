function [out,n1] = plot_heat_map_cross_angle_all_fiber_alldata

    accum_angles = [];
    
    fa_file = 'gold_fa.nii';
    gold_peaks = sprintf('gold_peaks.Bdouble');

    output = min_cross_angle_all_fibers_2dhist(fa_file,gold_peaks);
    accum_angles = [accum_angles;output];
            
    % Extract histogram data
    % n = hist3(accum_angles,[20 20]);
    % n = hist3(accum_angles,{0.025:.05:.975;0.025:.05:.975});
    n = hist3(accum_angles,{0.025:.05:.975,linspace(50,90,20)});
    n1 = n';
    % n1(size(n,1) + 1, size(n,2) + 1) = 0;
    
    % Generate grid for 2-D projected view of intensities.
    % xb = linspace(min(accum_angles(:,1)),max(accum_angles(:,1)),size(n,1)+1);
    % yb = linspace(min(accum_angles(:,2)),max(accum_angles(:,2)),size(n,1)+1);
    
    % Make a pseudocolor plot.
    % k = ones(size(n1)) * -max(max(n));
    
    out = pcolor(0.025:.05:.975,linspace(50,90,20),n1);
    
    
    %overall_matrix = variable.(A1)(:,1);
    %overall_matrix = [overall_matrix,mean(accum_angles)];
    
end