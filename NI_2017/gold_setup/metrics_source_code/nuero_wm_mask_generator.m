% Creating a mask for ROI labels 44 and 45.

function nuero_wm_mask_generator(nifti)
    nii = load_untouch_nii(nifti);
    dims = [78 93 75];
    gen_mask = zeros(dims);
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                if (nii.img(x,y,z) == 44 || nii.img(x,y,z) == 45)
                    gen_mask(x,y,z) = 1;
                end
            end
        end
    end
    
    nii.img = gen_mask;
    save_untouch_nii(nii,'WM_nuero_mask')
             


end