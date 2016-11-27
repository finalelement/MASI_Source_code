% Peak strength of second fiber in three fiber case. The peak strengths have
% been normalized

function [test_output] = peak_strength_f1_one_fiber_2dhist(fa,peaks_file,mask)
    
    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
    % Loading the ROI file
    mask_mask = load_untouch_nii(mask);
    
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % test Pas peaks
    
    test_output = [];
    
    % Calculating the normalization value
    f1_sum = 0;
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code 
                if (AAA(x,y,z,1) == 0)
                    % Segmentation mask
                    if(mask_mask.img(x,y,z) == 1)
                        % Validating only single fiber voxels from the set
                        if (AAA(x,y,z,3) == 1)
                            f1_sum = f1_sum + AAA(x,y,z,10);
                        end
                    end
                end
            end
        end
    end

    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code 
                if (AAA(x,y,z,1) == 0)
                    % Segmentation mask
                    if(mask_mask.img(x,y,z) == 1)
                        % Validating only single fiber voxels from the set
                        if (AAA(x,y,z,3) == 1)
                            frac_val = frac_an.img(x,y,z);

                            %Defining vectors for the PAS set
                            f1 = AAA(x,y,z,10);
                            f2 = AAA(x,y,z,18);
                            f3 = AAA(x,y,z,26);

                            norm_strength = f1;

                            row = [frac_val norm_strength/f1_sum];
                            test_output = [test_output;row];

                        end
                    end
                end
            end
        end
    end
    
end