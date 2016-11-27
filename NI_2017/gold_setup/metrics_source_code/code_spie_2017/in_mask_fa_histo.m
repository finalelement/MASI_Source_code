function new_img = in_mask_fa_histo(fa_file,wm_mask)

    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa_file);
    dims = size(frac_an.img);
    
    % Loading the WM mask
    wm_mask = load_untouch_nii(wm_mask);
    new_img = [];
    
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                if (wm_mask.img(x,y,z) == 1)
                    new_img = [new_img;frac_an.img(x,y,z)];
                end
            end
        end
    end



end