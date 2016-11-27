function final_output = sf_cross_angle_error(fa,peaks_gold,peaks_test)

    fileID = fopen(peaks_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
    % Loading up the WM mask
    wm_mask = load_untouch_nii('WMmask.nii');
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks

    angle_out = [];
    
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Validating voxel from the WM mask
                    % if (frac_an.img(x,y,z) >= 0.2)
                    if (wm_mask.img(x,y,z) == 1)    
                        % Validating only voxels with two or more peaks from gold set
                        if (AAA(x,y,z,3) >= 2)

                            % Gold peaks
                            u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            v = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                            w = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];

                            % Test Peaks
                            j = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                            k = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                            l = [BBB(x,y,z,23) BBB(x,y,z,24) BBB(x,y,z,25)];

                            % Crossing angles between fibers in gold peaks
                            min_angle_gold = minimum_crossing_angle_per_voxel(u,v,w);
                            min_angle_test = minimum_crossing_angle_per_voxel(j,k,l);
                            min_angle_error = abs(min_angle_gold - min_angle_test);

                            if (min_angle_error <= 20)
                                success = 1;
                            else
                                success = 0;
                            end
                            row = [min_angle_gold min_angle_test min_angle_error success];
                            angle_out = [angle_out;row];

                        end
                    end
                end
            end
        end
    end
    
    final_output = [];
    temp = 0;
   
    maxes = max(angle_out);
    while_end_limit = maxes(1) + 1;
    
    while (temp < while_end_limit)
       beg_limit = temp;
       end_limit = temp + 5;
       %angle_val = (beg_limit + end_limit)/2;
       
       total_col1 = angle_out(:,1);
       total_index = find((beg_limit < total_col1) & (total_col1 < end_limit));
       
       truncated_angles = angle_out(total_index,:); 
       angle_val = mean(truncated_angles(:,1));
       tc = numel(truncated_angles(:,1));
       sc = sum(truncated_angles(:,4));
       
       sf = sc/tc * 100;
       
       row2 = [angle_val sf tc];
       final_output = [final_output;row2];
       
       temp = temp + 5; 
        
    end
    
end