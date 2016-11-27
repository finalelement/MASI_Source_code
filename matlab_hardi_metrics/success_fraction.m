% Success fraction classified by FA. Conditions for a Succesful trial.
% - Number of peaks of test PAS with the gold PAS should match.
% - Most prominent peaks should only have an angular tolerance of 5
% degrees, 10 degrees, 15 degrees, 20 degrees (4 cases)
% - The amplitude of the second fiber orientation being picked should be
% atleast 10% of the amplitude of the first one.

function success_fraction(fa,pas_gold,pas_test)
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
    output_10 = [];
    output_15 = [];
    output_20 = [];
    total_count = 0;
    success_5 = 0;
    success_10 = 0;
    success_15 = 0;
    success_20 = 0;
    for x = 1:96
        for y = 1:96
            for z = 1:50    % z is the slice number
                if frac_an.img(x,y,z) >= 0.0001
                    frac_val = frac_an.img(x,y,z);
                    total_count = total_count + 1;
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
                            
                            % Storing for tolerance of 5 degrees
                            if (angle_ui < 5)
                                row_5 = [frac_val cross_angle_test];
                                output_5 = [output_5;row_5];
                                success_5 = success_5 + 1;
                            end
                            
                            % Storing for tolerance of 10 degrees
                            if (angle_ui < 10)
                                row_10 = [frac_val cross_angle_test];
                                output_10 = [output_10;row_10];
                                success_10 = success_10 + 1;
                            end
                            
                            % Storing for tolerance of 15 degrees
                            if (angle_ui < 15)
                                row_15 = [frac_val cross_angle_test];
                                output_15 = [output_15;row_15];
                                success_15 = success_15 + 1;
                            end
                            
                            % Storing for tolerance of 20 degrees
                            if (angle_ui < 20)
                                row_20 = [frac_val cross_angle_test];
                                output_20 = [output_20;row_20];
                                success_20 = success_20 + 1;
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
    output_10_min = [];
    output_15_min = [];
    output_20_min = [];
    temp = 0.1;
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
        
        %output at tolerance of 10 degrees calculation
        output_10_col1 = output_10(:,1);
        output_10_col2 = output_10(:,2);
        output_10_index = find((beg_limit < output_10_col1) & (output_10_col1 < end_limit));
        
        output_10_min_1 = min(output_10_col2(output_10_index));
        output_10_row = [fa_val output_10_min_1];
        output_10_min = [output_10_min;output_10_row];
        final_output = [final_output;output_10_row];
        
        %output at tolerance of 15 degrees calculation
        output_15_col1 = output_15(:,1);
        output_15_col2 = output_15(:,2);
        output_15_index = find((beg_limit < output_15_col1) & (output_15_col1 < end_limit));
        
        output_15_min_1 = min(output_15_col2(output_15_index));
        output_15_row = [fa_val output_15_min_1];
        output_15_min = [output_15_min;output_15_row];
        final_output = [final_output;output_15_row];
        
        %output at tolerance of 20 degrees calculation
        output_20_col1 = output_20(:,1);
        output_20_col2 = output_20(:,2);
        output_20_index = find((beg_limit < output_20_col1) & (output_20_col1 < end_limit));
        
        output_20_min_1 = min(output_20_col2(output_20_index));
        output_20_row = [fa_val output_20_min_1];
        output_20_min = [output_20_min;output_20_row];
        final_output = [final_output;output_20_row];
        
        temp = temp + 0.1;
    end
    percent_5 = (success_5/total_count) * 100;
    percent_10 = (success_10/total_count) * 100;
    percent_15 = (success_15/total_count) * 100;
    percent_20 = (success_20/total_count) * 100;
    
    scatter(final_output(:,1),final_output(:,2));
    hold on;
    a1 = plot(output_5_min(:,1),output_5_min(:,2)); M1 = sprintf('5 Degree Tolerance - %0.2f',percent_5);
    a2 = plot(output_10_min(:,1),output_10_min(:,2)); M2 = sprintf('10 Degree Tolerance - %0.2f',percent_10);
    a3 = plot(output_15_min(:,1),output_15_min(:,2)); M3 = sprintf('15 Degree Tolerance - %0.2f',percent_15);
    a4 = plot(output_20_min(:,1),output_20_min(:,2)); M4 = sprintf('20 Degree Tolerance - %0.2f',percent_20);
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Crossing Angle b/w 2 Fibers','fontweight','demi','fontsize',12);
    legend([a1,a2,a3,a4], M1,M2,M3,M4);
    title('Crossing Angle of Test set based on Success Fraction');
end