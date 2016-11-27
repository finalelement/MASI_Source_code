% Diffusion tensor angle disagreement with single fiber case of PAS

function[output,mean_output] = dt_disagreement_single_fiber_box(fa,dt_file,peaks_file,mask)
    % Reading the files one by one, DTI and PAS in order
    fileID = fopen(dt_file,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    % Loading the ROI file
    mask_mask = load_untouch_nii(mask);
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);
    dims = size(frac_an.img);
    
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
                    % Segmentation mask
                    if(mask_mask.img(x,y,z) == 1)
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
    end
    
    max_fa = max(max(max(frac_an.img)));
    mean_output = [];
    temp = 0;
    
     while (temp < max_fa)
        beg_limit = temp;
        end_limit = temp + 0.1;
        fa_val = (beg_limit + end_limit)/2;
        if (~isempty(output))
            col1 = output(:,1);
            col2 = output(:,2);

            index = find((beg_limit < col1) & (col1 < end_limit));

            mean_error = mean(col2(index));

            row1 = [fa_val mean_error];
        else
            row1 = [fa_val 0];
        end

        mean_output = [mean_output;row1];
        temp = temp + 0.1;
     end
    
    %{
    
    figure(1)
    hold on;
    
    temp = 0;
    
    max_fa = max(max(max(frac_an.img)));
    i = 1;
    angles_out = [];
    fa_out = [];
    mean_out = [];
    std_out = [];
    
    while (temp < max_fa)
       beg_limit = temp;
       end_limit = temp + 0.1;
       col1 = output(:,1);
       col2 = output(:,2);
       index = find((beg_limit < col1) & (col1 < end_limit));
       angles = col2(index);
       angles_out = [angles_out;angles];
       
       mean_row = [mean(angles) i];
       mean_out = [mean_out;mean_row];
       
       std_row = [std(angles) i];
       std_out = [std_out;std_row];
       
       fa_val = ((beg_limit + end_limit)/2) * 1000;
       
       ty = zeros(length(angles),1) + i;
       fa_out = [fa_out;ty];
       %my_field_1 = strcat('A',num2str(i));
       
       %[variable.(my_field_1)] = boxplot(angles,fa_val);
       
       temp = temp + 0.1;
       i = i + 1;
    end
    
    this_the_crap = boxplot(angles_out,fa_out);
    mean_plot = errorbar(mean_out(:,1),std_out(:,1),'xm','linewidth',1.5);
    
    xlabel('Fractional Anisotropy * 10','fontweight','demi','fontsize',12)
    ylabel('Disagreement Angle','fontweight','demi','fontsize',12);
    
    title('PAS Disagreement with DT Single Fiber (Gold set)');
    
    %}
end