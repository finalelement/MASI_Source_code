% Takes all the magnitudes and angles of the peaks present into account.

function [output,mean_output] = peak_to_peak_error_one_fiber(fa,peaks_gold,peaks_test)
    
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
    
    total_count = 0;
    one_count = 0;
    two_count = 0;
    three_count = 0;
    for x = 1:96
        for y = 1:96
            for z = 1:50
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Validating single fiber voxels from gold set
                    if (AAA(x,y,z,3) == 1)
                        frac_val = frac_an.img(x,y,z);
                        row = [0 0];
                        total_count = total_count + 1;
                        % Defining all three vectors from gold and test in
                        % order
                        m = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
            
                        
                        j = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                        k = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                        l = [BBB(x,y,z,23) BBB(x,y,z,24) BBB(x,y,z,25)];
                        
                        % Test set one fiber case
                        if (BBB(x,y,z,3) == 1)
                            one_count = one_count + 1;
                            
                            angle_error1 = atan2d(norm(cross(m,j)),dot(m,j));
                            if (angle_error1 > 90)
                                angle_error1 = 180 - angle_error1;
                            end
                            
                            angy = [angle_error1];
                            angle_error = sum(angy);
                            row = [frac_val angle_error];
                        end
                        
                        % Test set two fiber case
                        if (BBB(x,y,z,3) == 2)
                            two_count = two_count + 1;
                            % Normalizing peak strengths
                            ps = BBB(x,y,z,10) + BBB(x,y,z,18);
                            normps = [BBB(x,y,z,10)/ps BBB(x,y,z,18)/ps];
                            
                            angle_error1 = atan2d(norm(cross(m,j)),dot(m,j));
                            if (angle_error1 > 90)
                                angle_error1 = 180 - angle_error1;
                            end
                            
                            angle_error2 = atan2d(norm(cross(m,k)),dot(m,k));
                            if (angle_error2 > 90)
                                angle_error2 = 180 - angle_error2;
                            end
                            
                            angy = [angle_error1 angle_error2];
                            angy = angy.*normps;
                            angle_error = sum(angy);
                            row = [frac_val angle_error];
                        end
                        
                        % Test set three fiber case
                        if (BBB(x,y,z,3) == 3)
                            three_count = three_count + 1;
                            % Normalizing peak strengths
                            ps = BBB(x,y,z,10) + BBB(x,y,z,18) + BBB(x,y,z,26);
                            normps = [BBB(x,y,z,10)/ps BBB(x,y,z,18)/ps BBB(x,y,z,26)/ps]; 
                            
                            angle_error1 = atan2d(norm(cross(m,j)),dot(m,j));
                            if (angle_error1 > 90)
                                angle_error1 = 180 - angle_error1;
                            end
                            
                            angle_error2 = atan2d(norm(cross(m,k)),dot(m,k));
                            if (angle_error2 > 90)
                                angle_error2 = 180 - angle_error2;
                            end
                            
                            angle_error3 = atan2d(norm(cross(m,l)),dot(m,l));
                            if (angle_error3 > 90)
                                angle_error3 = 180 - angle_error3;
                            end
                            
                            angy = [angle_error1 angle_error2 angle_error3];
                            angy = angy.*normps;
                            angle_error = sum(angy);
                            row = [frac_val angle_error];
                        end
                        
                        output = [output;row];
                        
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