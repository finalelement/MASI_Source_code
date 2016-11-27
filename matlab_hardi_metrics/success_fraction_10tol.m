% Success fraction classified by FA. Conditions for a Succesful trial.
% - Number of peaks of test PAS with the gold PAS should match.
% - Most prominent peaks should only have an angular tolerance of 5
% degrees, 10 degrees, 15 degrees, 20 degrees (4 cases)
% - The amplitude of the second fiber orientation being picked should be
% atleast 10% of the amplitude of the first one.

function success_fraction_10tol(fa,pas_gold,pas_test)
    fileID = fopen(pas_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(pas_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 96 96 50]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    output_5 = [];
    
    for x = 1:96
        for y = 1:96
            for z = 1:50    % z is the slice number
                if frac_an.img(x,y,z) >= 0.0001
                    frac_val = frac_an.img(x,y,z);
                    
                    % Check if the number of peaks are equal
                    if AAA(x,y,z,3) == BBB(x,y,z,3)
                    
                        % Defining vectors for gold pas and test pas
                        u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                        v = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                        
                        i = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                        j = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                        
                        cross_angle_test = atan2d(norm(cross(i,j)),dot(i,j));
                        if (cross_angle_test > 90)
                            cross_angle_test = 180 - cross_angle_test;
                        end
                        
                        mag_u = norm(u);
                        mag_v = norm(v);
                        
                        mag_i = norm(i);
                        mag_j = norm(j);
                        
                        if (mag_v > (0.1 * mag_u)) & (mag_j > (0.1 * mag_i))
                            angle_ui = atan2d(norm(cross(u,i)),dot(u,i));
                            
                            if (angle_ui < 10)
                                row_5 = [frac_val cross_angle_test];
                                output_5 = [output_5;row_5];
                            end
                        end
                            
                    end
                end
            end
        end
    end
    figure(4)
    %scatter(output_5(:,1),output_5(:,2));
    max_fa = max(max(max(frac_an.img)));
    final_output = [];
    output_5_min = [];
    temp = 0.0001;
    while (temp < max_fa)
        beg_limit = temp;
        end_limit = temp + 0.1;
        fa_val = (beg_limit + end_limit)/2;
        
        %output at tolerance of 5 degrees calculation
        output_5_col1 = output_5(:,1);
        output_5_col2 = output_5(:,2);
        output_5_index = find((beg_limit < output_5_col1) & (output_5_col1 < end_limit));
        
        output_5_min_1 = min(output_5_col2(output_5_index));
        output_5_row = [fa_val output_5_min_1];
        output_5_min = [output_5_min;output_5_row];
        final_output = [final_output;output_5_row];
        
        
        temp = temp + 0.1;
    end
    scatter(final_output(:,1),final_output(:,2));
    hold on;
    a2 = plot(output_5_min(:,1),output_5_min(:,2)); M2 = '5 Degree Tolerance';
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Crossing Angle b/w 2 Fibers','fontweight','demi','fontsize',12);
    legend([a2], M2);
    title('Crossing Angle of Test set based on Success Fraction');
end