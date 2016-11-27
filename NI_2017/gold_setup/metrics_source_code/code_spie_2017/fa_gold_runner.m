function fa_gold_runner(fa,bval)
    
    % Obtain size from the fa which will be used for pas files
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
    title(bval);
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    file_name = sprintf('b%d_gold_fa',bval);
    print(file_name,'-depsc2','-r0')
  
end