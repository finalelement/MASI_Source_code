function single_scan_peak_agreement(fa,gold_peaks,test_peaks,bval)
    
    fileID = fopen(gold_peaks,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(test_peaks,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    % Load the WM mask for validation
    wm_mask = load_untouch_nii('WMmask.nii');
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    output = zeros(dims(1),dims(2),dims(3));
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Validating mask
                    if (wm_mask.img(x,y,z) == 1)
                        %frac_val = frac_an.img(x,y,z);
                        %condition for matching number of peaks match
                        if (AAA(x,y,z,3) == BBB(x,y,z,3))
                            output(x,y,z) = 1;
                        else
                            output(x,y,z) = 0;
                        end
                    end
                end
            end
        end
    end
    
    clf;
    figure(1)
    imagesc(output(:,:,40));
    
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
    file_name = sprintf('b%d_gold_single_scan_agreement_qball',bval);
    print(file_name,'-depsc2','-r0')

end