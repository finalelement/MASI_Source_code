% Two fiber case, Success fraction for a single set referencing to the gold
% set

% Define Success Fraction for two fiber case. The peak number of the test
% set must match to the gold which is 2 and the angular tolerance of the
% corresponding fibers should not be more than 5/10/15 degrees. Will plot
% graphs for all three on account of gold set's FA.

function [final_output,suc_spa] = success_fraction_two_fiber_spatial(fa,peaks_gold,peaks_test,tolerance,mask)
   
    fileID = fopen(peaks_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
    % Loading the ROI file
    mask_mask = load_untouch_nii(mask);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    s_voxels = 0;
    total_voxels = 0;
    
    total = [];
    success = [];
    suc_spa = zeros(78,93,75);
    
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Segmentation mask
                    if(mask_mask.img(x,y,z) == 1)
                        % Validating only two fiber voxels from gold set
                        if (AAA(x,y,z,3) == 2)

                            total_voxels = total_voxels + 1;
                            frac_val = frac_an.img(x,y,z);
                            row_1 = [frac_val 1];
                            total = [total;row_1];


                            if (AAA(x,y,z,3) == BBB(x,y,z,3))
                                % Defining vectors for the test and gold sets
                                % for testing angular tolerance
                                
                                
                                
                                % Gold fibers
                                u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                                v = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                                w = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];
                                
                                % Test fibers
                                j = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                                k = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                                l = [BBB(x,y,z,23) BBB(x,y,z,24) BBB(x,y,z,25)];

                                angle_tolerances = tolerance_angles(u,v,w,j,k,l);   
                                % Count if all three fibers match the
                                % tolerance level
                               
                                % Testing without the angular tolerance
                                if (angle_tolerances(1,1) <= tolerance && angle_tolerances(1,2) <= tolerance)
                                    s_voxels = s_voxels + 1;
                                    row_2 = [frac_val 1];
                                    success = [success;row_2]; 
                                    suc_spa(x,y,z) = 1;
                                end
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
        if(~isempty(total))
            total_col1 = total(:,1);
            total_index = find((beg_limit < total_col1) & (total_col1 < end_limit));
            
            if(~isempty(success))
                success_col1 = success(:,1);
                success_index = find((beg_limit < success_col1) & (success_col1 < end_limit));

                sc = numel(success_index);
                tc = numel(total_index);

                sf = sc/tc * 100;
            else
                sf = 0;
                tc = numel(total_index);
            end

            row3 = [fa_val sf tc];
            final_output = [final_output;row3];
        else
            row3 = [fa_val 0 0];
            final_output = [final_output;row3];
        end
        temp = temp + 0.1;
    end
    
                            

end