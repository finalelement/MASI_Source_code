function spatial_map_gold_pas_qball_reps_agreement_b3000

    mask = 'WM_nuero_mask.nii'; 
    title('Spatial map, Qball gold and PAS reps');
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS_gold_Qball_reps'))
    
    [sf_mean_matrix1,sf_std_matrix1,spatial_data1] = report_dev_single_fiber_sf_three_trials_spatial(mask);
    
    clf;
    figure(1)
    imagesc(spatial_data1(:,:,40));
    
    mycolormap = jet(256);
    mycolormap(1,:) = [1 1 1];
    colormap(mycolormap)
    axis equal
    caxis([0 11])
    colorbar
    drawnow;
    title('Single Fiber - b3000');
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    file_name = sprintf('single_fiber_spatial_pas_gold_b3000');
    print(file_name,'-depsc2','-r0')
    
    [sf_mean_matrix2,sf_std_matrix2,spatial_data2] = report_dev_two_fiber_sf_three_trials_spatial(mask);
    
    clf;
    figure(1)
    imagesc(spatial_data2(:,:,40));
    
    mycolormap = jet(256);
    mycolormap(1,:) = [1 1 1];
    colormap(mycolormap)
    axis equal
    caxis([0 11])
    colorbar
    drawnow;
    title('Two Fiber - b3000');
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    file_name = sprintf('two_fiber_spatial_pas_gold_b3000');
    print(file_name,'-depsc2','-r0')

    [sf_mean_matrix3,sf_std_matrix3,spatial_data3] = report_dev_three_fiber_sf_three_trials_spatial(mask);
    
    clf;
    figure(1)
    imagesc(spatial_data3(:,:,40));
    
    mycolormap = jet(256);
    mycolormap(1,:) = [1 1 1];
    colormap(mycolormap)
    axis equal
    caxis([0 11])
    colorbar
    drawnow;
    title('Three Fiber - b3000');
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    file_name = sprintf('three_fiber_spatial_pas_gold_b3000');
    print(file_name,'-depsc2','-r0')

    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS_gold_Qball_reps'))

end