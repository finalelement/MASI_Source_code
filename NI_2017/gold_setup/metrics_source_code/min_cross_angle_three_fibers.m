% Minimum Crossing angle reported between three fiber populations for the
% minimum angle found in all three combinations of the fibers 1,2,3

function [test_min_output,test_max_output,test_mean_output] = min_cross_angle_three_fibers(fa,peaks_file,mask)

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
    
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code 
                if (AAA(x,y,z,1) == 0)
                    
                    % Segmentation mask
                    if(mask_mask.img(x,y,z) == 1)
                        % Validating only three fiber voxels from the set
                        if (AAA(x,y,z,3) == 3)
                            frac_val = frac_an.img(x,y,z);

                            % Defining vectors for the PAS set
                            i = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            j = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                            k = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];

                            % Angle b/w fiber 1 and 2
                            cross_angle12 = atan2d(norm(cross(i,j)),dot(i,j));
                            if (cross_angle12 > 90)
                                cross_angle12 = 180 - cross_angle12;
                            end

                            % Angle b/w fiber 2 and 3
                            cross_angle23 = atan2d(norm(cross(j,k)),dot(j,k));
                            if (cross_angle23 > 90)
                                cross_angle23 = 180 - cross_angle23;
                            end

                            % Angle b/w fiber 1 and 3
                            cross_angle13 = atan2d(norm(cross(i,k)),dot(i,k));
                            if (cross_angle13 > 90)
                                cross_angle13 = 180 - cross_angle13;
                            end

                            angles = [cross_angle12 cross_angle23 cross_angle13];
                            min_angle = min(angles);

                            row2 = [frac_val min_angle];
                            test_output = [test_output;row2];

                        end
                    end
                end
            end
        end
    end
    
    test_min_output = [];
    test_max_output = [];
    test_mean_output = [];
    temp = 0;
    
    max_fa = max(max(max(frac_an.img)));
    
    while (temp < max_fa)
        beg_limit = temp;
        end_limit = temp + 0.1;
        fa_val = (beg_limit + end_limit)/2;
        
        %Test Calculations
        if(~isempty(test_output))
            test_col1 = test_output(:,1);
            test_col2 = test_output(:,2);
            test_index = find((beg_limit < test_col1) & (test_col1 < end_limit));
        else
            test_col1 = 0;
            test_col2 = 0;
            test_index = int16.empty;
        end
        
        if(~isempty(test_index))
            test_max1 = max(test_col2(test_index));
            test_min1 = min(test_col2(test_index));
            test_mean1 = mean(test_col2(test_index));
        
            test_row1 = [fa_val test_max1];
            test_row2 = [fa_val test_min1];
            test_row3 = [fa_val test_mean1];
        else
            test_row1 = [fa_val 0];
            test_row2 = [fa_val 0];
            test_row3 = [fa_val 0];
        end
   
        
        test_max_output = [test_max_output;test_row1];
        test_min_output = [test_min_output;test_row2];
        test_mean_output = [test_mean_output;test_row3];
                        
        temp = temp + 0.1;
    end
                          
end