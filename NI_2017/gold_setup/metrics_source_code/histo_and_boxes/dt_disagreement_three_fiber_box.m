function [output,mean_output] = dt_disagreement_three_fiber_box(fa,dt_file,peaks_file,mask)

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
  
    % Loading the ROI file
    mask_mask = load_untouch_nii(mask);
    
    % Reshaping and permuting both DT and PAS in order
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]);   % Pas peaks
    
    BB = reshape(B,[12 dims(1) dims(2) dims(3)]);
    BBB = permute(BB,[2 3 4 1]); % Dteig
    
    output = [];
    
    % Looping over all the elements and creating vectors
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)    % z is the slice number
                % Validate voxels with exit code of peaks
                if (AAA(x,y,z,1) == 0)
                    % Segmentation mask
                    if(mask_mask.img(x,y,z) == 1)
                        % Validating three fiber voxels from test set
                        if (AAA(x,y,z,3) == 3)
                            % Create vectors of DT and three fiber PAS voxels

                            u = [BBB(x,y,z,2) BBB(x,y,z,3) BBB(x,y,z,4)];

                            i = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                            j = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                            k = [AAA(x,y,z,23) AAA(x,y,z,24) AAA(x,y,z,25)];

                            frac_val = frac_an.img(x,y,z);

                            % Disagreement between PAS fiber 1 and DT
                            angle_error1 = atan2d(norm(cross(u,i)),dot(u,i));
                            if (angle_error1 > 90)
                                angle_error1 = 180 - angle_error1;
                            end

                            % Disagreement between PAS fiber 2 and DT
                            angle_error2 = atan2d(norm(cross(u,j)),dot(u,j));
                            if (angle_error2 > 90)
                                angle_error2 = 180 - angle_error2;
                            end

                            % Disagreement between PAS fiber 3 and DT
                            angle_error3 = atan2d(norm(cross(u,k)),dot(u,k));
                            if (angle_error3 > 90)
                                angle_error3 = 180 - angle_error3;
                            end

                            angles = [angle_error1 angle_error2 angle_error3];
                            min_angle = min(angles);

                            row = [frac_val min_angle];
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
        if(~isempty(output))
            col1 = output(:,1);
            col2 = output(:,2);

            index = find((beg_limit < col1) & (col1 < end_limit));
        else
            col1 = 0;
            col2 = 0;
            index = int16.empty;
        end
        if(~isempty(index))
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
    
    title('PAS Disagreement with DT Three Fiber (Gold set)');
                           
    %}                    
end