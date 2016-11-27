function [output,mean_output] = peak_to_peak_disagreement_one_fiber(fa,peaks_gold,peaks_test)

    fileID = fopen(peaks_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 96 96 50]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    output = [];
    
    for x = 1:96
        for y = 1:96
            for z = 1:50
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Validating single fiber voxels from gold set
                    if (AAA(x,y,z,3) == 1)
                        frac_val = frac_an.img(x,y,z);
                        %condition for matching number of peaks match
                        if (AAA(x,y,z,3) == BBB(x,y,z,3))
                            % Defining vectors for the test and gold sets
                            % for testing angular tolerance
                            u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            v = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                            angle_error = atan2d(norm(cross(u,v)),dot(u,v));
                            if (angle_error > 90)
                                angle_error = 180 - angle_error;
                            end
                            
                            row = [frac_val angle_error];
                            output = [output;row];
                            
                        end
                    end
                end
            end
        end
    end
    
    max_fa = max(max(max(frac_an.img)));
    mean_output = [];
    temp = 0;
    
     while (temp < max_fa)
        beg_limit = temp;
        end_limit = temp + 0.1;
        fa_val = (beg_limit + end_limit)/2;
        
        col1 = output(:,1);
        col2 = output(:,2);
        
        index = find((beg_limit < col1) & (col1 < end_limit));
        
        mean_error = mean(col2(index));
        
        row1 = [fa_val mean_error];
        
        mean_output = [mean_output;row1];
        temp = temp + 0.1;
     end
        
        
end