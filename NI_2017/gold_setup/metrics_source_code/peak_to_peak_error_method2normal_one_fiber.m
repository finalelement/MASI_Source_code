% Takes all the magnitudes and angles of the peaks present into account.

function [output,mean_output] = peak_to_peak_error_method2normal_one_fiber(fa,peaks_gold,peaks_test)
    
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
                        
                        total_count = total_count + 1;
                        % Defining all single fiber vector from gold and all vectors for test in
                        % order
                        m = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                        n = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                        o = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];
                        
                        j = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                        k = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                        l = [BBB(x,y,z,23) BBB(x,y,z,24) BBB(x,y,z,25)];
                        
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
                            
                        angle_error4 = atan2d(norm(cross(n,j)),dot(n,j));
                        if (angle_error4 > 90)
                            angle_error4 = 180 - angle_error4;
                        end
                            
                        angle_error5 = atan2d(norm(cross(n,k)),dot(n,k));
                        if (angle_error5 > 90)
                            angle_error5 = 180 - angle_error5;
                        end
                            
                        angle_error6 = atan2d(norm(cross(n,l)),dot(n,l));
                        if (angle_error6 > 90)
                            angle_error6 = 180 - angle_error6;
                        end
                            
                        angle_error7 = atan2d(norm(cross(o,j)),dot(o,j));
                        if (angle_error7 > 90)
                            angle_error7 = 180 - angle_error7;
                        end
                            
                        angle_error8 = atan2d(norm(cross(o,k)),dot(o,k));
                        if (angle_error8 > 90)
                            angle_error8 = 180 - angle_error8;
                        end
                            
                        angle_error9 = atan2d(norm(cross(o,l)),dot(o,l));
                        if (angle_error9 > 90)
                            angle_error9 = 180 - angle_error9;
                        end
                            
                        angy = [angle_error1 angle_error2 angle_error3, ...
                                angle_error4 angle_error5 angle_error6, ... 
                                angle_error7 angle_error8 angle_error9];
                        
                        error = [];
                        
                        [error1,p] = min(angy(angy>0));
                        [prow,pcol] = ind2sub(size(angy),p);
                        
                        angy(prow,:) = [];
                        angy(:,pcol) = [];
                        
                        [error2,q] = min(angy(angy>0));
                        [qrow,qcol] = ind2sub(size(angy),q);
                        
                        angy(qrow,:) = [];
                        angy(:,qcol) = [];
                        
                        [error3,r] = min(angy(angy>0));
                        
                        if (error1 ~= 0)
                            error = [error,error1];
                        end
                        
                        if (error2 ~= 0)
                            error = [error,error2];
                        end
                        
                        if (error3 ~= 0)
                            error = [error,error3];
                        end
                        
                        row = [frac_val mean(error)];            
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
        
        col3 = col2(index);
        mean_error = mean(col3(~isnan(col3)));
        
        row1 = [fa_val mean_error];
        
        mean_output = [mean_output;row1];
        temp = temp + 0.1;
    end
                        
end