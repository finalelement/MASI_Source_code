function [output,mean_output] = peak_to_peak_disagreement_three_fiber(fa,peaks_gold,peaks_test)
    
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
                    % Validating three fiber voxels from gold set
                    if (AAA(x,y,z,3) == 3)
                        frac_val = frac_an.img(x,y,z);
                        %condition for matching number of peaks match
                        if (AAA(x,y,z,3) == BBB(x,y,z,3))
                            % Defining vectors for the test and gold sets
                            % and calculating the angle error between the
                            % corresponding peaks
                            
                            % first peak
                            u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            v = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                            
                            angle_error1 = atan2d(norm(cross(u,v)),dot(u,v));
                            if (angle_error1 > 90)
                                angle_error1 = 180 - angle_error1;
                            end
                            
                            % Defining vectors for second peak
                            j = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                            k = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                            
                            angle_error2 = atan2d(norm(cross(j,k)),dot(j,k));
                            if (angle_error2 > 90)
                                angle_error2 = 180 - angle_error2;
                            end
                            
                            % Defining vectors for third peak
                            l = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];
                            m = [BBB(x,y,z,23) BBB(x,y,z,24) BBB(x,y,z,25)];
                            
                            angle_error3 = atan2d(norm(cross(l,m)),dot(l,m));
                            if (angle_error3 > 90)
                                angle_error3 = 180 - angle_error3;
                            end
                            
                            % Symmetrizing the angle errors of the two
                            % peaks
                            angles = [angle_error1 angle_error2 angle_error3];
                            row = [frac_val mean(angles)];
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