function fa_slice
    
    % Obtain size from the fa which will be used for pas files
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/Qball_sh8'))
    fa = 'gold_fa.nii';
    frac_an = load_untouch_nii(fa);
    slice_fa = frac_an.img(:,:,40);
    
    figure(1)
    imagesc(slice_fa);
    
    mycolormap = jet(256);
    mycolormap(1,:) = [1 1 1];
    colormap(mycolormap)
    axis equal
    caxis([0 1])
    colorbar
    drawnow;
    title('b3000-FA');
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    file_name = sprintf('gold_fa_b3000');
    print(file_name,'-depsc2','-r0')
  
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/Qball_sh8'))
end