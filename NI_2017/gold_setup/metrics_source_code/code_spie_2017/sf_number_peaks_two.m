% SF just on peaks
function [final_output] = sf_number_peaks_two(fa,peaks_gold,peaks_test)
    
    fileID = fopen(peaks_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks

    s_voxels = 0;
    total_voxels = 0;
    
    total = [];
    success = [];
    
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code of Gold peaks
                if (AAA(x,y,z,1) == 0)
                    % Validating only two fiber voxels from gold set
                    if (AAA(x,y,z,3) == 2)
                        
                        total_voxels = total_voxels + 1;
                        frac_val = frac_an.img(x,y,z);
                        row_1 = [frac_val 1];
                        total = [total;row_1];
                        
                        if (BBB(x,y,z,3) == 2)

                            s_voxels = s_voxels + 1;
                            row_2 = [frac_val 1];
                            success = [success;row_2];
                            
                        end
                    end
                end
            end
        end
    end
    
    max_fa = max(max(max(frac_an.img)));
    final_output = [];
    voxel_count = [];
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

