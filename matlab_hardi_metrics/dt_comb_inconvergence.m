% Angle inconvergence when taking the minimum angle between combinations of
% all three directions with DTI, adapted from dt_inconvergence where only
% do that from first direction

function dt_comb_inconvergence(fa,pas_peaks,dt_vector)
    
    % Reading the files one by one, DTI and PAS in order
    fileID = fopen(dt_vector,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(pas_peaks,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID);
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);
    %l = int32(size(frac_an.img));
    
    % Reshaping and permuting both DT and PAS in order
    AA = reshape(A,[12 96 96 50]);
    AAA = permute(AA,[2 3 4 1]);   % Dteig
    
    BB = reshape(B,[30 96 96 50]);
    BBB = permute(BB,[2 3 4 1]); % Pas peaks
    
    output = [];
    % Looping over all the elements and creating vectors
    for x = 1:96
        for y = 1:96
            for z = 1:50    % z is the slice number
                if frac_an.img(x,y,z) >= 0.1
                    %Defining vectors
                    u = [AAA(x,y,z,2) AAA(x,y,z,3) AAA(x,y,z,4)];
                    v = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                    w = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                    frac_val = frac_an.img(x,y,z);
                    
                    angle_error1 = atan2d(norm(cross(u,v)),dot(u,v));
                    if (angle_error1 > 90)
                        angle_error1 = 180 - angle_error1;
                    end
                    
                    angle_error2 = atan2d(norm(cross(u,w)),dot(u,w));
                    if (angle_error2 > 90)
                        angle_error2 = 180 - angle_error2;
                    end
                    
                    angle_error = angle_error1;
                    if angle_error2 <= angle_error
                        angle_error = angle_error2;
                    end
                    
                    row = [frac_val angle_error];
                    output = [output;row];
                end
            end
        end
    end
    figure(2);
    
    temp = 0.1;
    mean_output = [];
    max_output = [];
    min_output = [];
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
        fa_val = (beg_limit + end_limit)/2;
        row1 = [fa_val min1];
        row2 = [fa_val max1];
        row3 = [fa_val mean1];
        min_output = [min_output;row1];
        max_output = [max_output;row2];
        mean_output = [mean_output;row3];
        final_output = [final_output;row1];
        final_output = [final_output;row2];
        final_output = [final_output;row3];
        temp = temp + 0.1;
        
    end
    scatter(final_output(:,1),final_output(:,2));
    hold on;
    a1 = plot(min_output(:,1),min_output(:,2)); M1 = 'Min Angle';
    a2 = plot(max_output(:,1),max_output(:,2)); M2 = 'Max Angle';
    a3 = plot(mean_output(:,1),mean_output(:,2)); M3 = 'Mean Angle';
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Angle Inconvergence','fontweight','demi','fontsize',12);
    legend([a1;a2;a3], M1,M2,M3);
    title('Comparing two PAS Directions with PD');
end