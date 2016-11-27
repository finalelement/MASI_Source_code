% Two fiber case, Success fraction for a single set referencing to the gold
% set

% Define Success Fraction for two fiber case. The peak number of the test
% set must match to the gold which is 2 and the angular tolerance of the
% corresponding fibers should not be more than 5/10/15 degrees. Will plot
% graphs for all three on account of gold set's FA.

function [final_output] = success_fraction_two_fiber(fa,peaks_gold,peaks_test,tolerance)
   
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
    
    s_voxels = 0;
    total_voxels = 0;
    
    total = [];
    success = [];
    
    for x = 1:96
        for y = 1:96
            for z = 1:50
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Validating only two fiber voxels from gold set
                    if (AAA(x,y,z,3) == 2)
                        
                        total_voxels = total_voxels + 1;
                        frac_val = frac_an.img(x,y,z);
                        row_1 = [frac_val 1];
                        total = [total;row_1];
                        
                        
                        if (AAA(x,y,z,3) == BBB(x,y,z,3))
                            % Defining vectors for the test and gold sets
                            % for testing angular tolerance
                            % Fiber 1
                            u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            v = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                            angle1 = atan2d(norm(cross(u,v)),dot(u,v));
                            if (angle1 > 90)
                                angle1 = 180 - angle1;
                            end
                        
                            % Fiber 2
                            j = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                            k = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                            angle2 = atan2d(norm(cross(j,k)),dot(j,k));
                            if (angle2 > 90)
                                angle2 = 180 - angle2;
                            end
                            
                            if (angle1 <= tolerance && angle2 <= tolerance)
                                s_voxels = s_voxels + 1;
                                row_2 = [frac_val 1];
                                success = [success;row_2];
                            end
                            
                        end
                    end
                end
            end
        end
    end
    
    max_fa = max(max(max(frac_an.img)));
    final_output = [];
    temp = 0;
    
    while (temp < max_fa)
        beg_limit = temp;
        end_limit = temp + 0.1;
        fa_val = (beg_limit + end_limit)/2;
        
        total_col1 = total(:,1);
        total_index = find((beg_limit < total_col1) & (total_col1 < end_limit));
        
        success_col1 = success(:,1);
        success_index = find((beg_limit < success_col1) & (success_col1 < end_limit));
        
        sc = numel(success_index);
        tc = numel(total_index);
        
        sf = sc/tc * 100;
        
        row3 = [fa_val sf tc];
        final_output = [final_output;row3];
        
        temp = temp + 0.1;
    end
    
                            

end