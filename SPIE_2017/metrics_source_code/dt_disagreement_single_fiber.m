% Diffusion tensor angle disagreement with single fiber case of PAS

function[min_output,max_output,mean_output] = dt_disagreement_single_fiber(fa,dt_file,peaks_file)
    % Reading the files one by one, DTI and PAS in order
    fileID = fopen(dt_file,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    %l = int32(size(frac_an.img));
    
    % Reshaping and permuting both DT and PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]);   % Pas peaks
    
    BB = reshape(B,[12 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % Dteig
    
    output = [];
    
    % Looping over all the elements and creating vectors
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)  % z is the slice number
                % Validate voxels with exit code of peaks
                if (AAA(x,y,z,1) == 0)
                    % Validating single fiber voxels from test set
                    if (AAA(x,y,z,3) == 1)
                        % Create vectors of DT and single fiber PAS voxels
                        u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                        v = [BBB(x,y,z,2) BBB(x,y,z,3) BBB(x,y,z,4)];
                        
                        frac_val = frac_an.img(x,y,z);
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
    
    temp = 0;
    mean_output = [];
    max_output = [];
    min_output = [];
    %std_output = [];
    final_output = [];
    max_fa = max(max(max(frac_an.img)));
    
    while (temp < max_fa)
       beg_limit = temp;
       end_limit = temp + 0.1;
       col1 = output(:,1);
       col2 = output(:,2);
       index = find((beg_limit < col1) & (col1 < end_limit));
       
       mean1 = mean(col2(index));
       max1 = max(col2(index));
       min1 = min(col2(index));
       %std1 = std(col2(index));
       fa_val = (beg_limit + end_limit)/2;
       
       row1 = [fa_val min1];
       row2 = [fa_val max1];
       row3 = [fa_val mean1];
       %row4 = [fa_val std1];
       
       min_output = [min_output;row1];
       max_output = [max_output;row2];
       mean_output = [mean_output;row3];
       %std_output = [std_output;row4];
       
       final_output = [final_output;row1];
       final_output = [final_output;row2];
       final_output = [final_output;row3];
       temp = temp + 0.1;
    end
    
end