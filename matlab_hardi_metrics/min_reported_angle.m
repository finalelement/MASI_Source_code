% Minimum reported angle curves per region for a gold/reference set and a
% test set.

function min_reported_angle(fa,pas_gold,pas_test)
    fileID = fopen(pas_gold,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    fileID = fopen(pas_test,'rb','ieee-be');
    B = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    BB = reshape(B,[30 96 96 50]);
    BBB = permute(BB,[2 3 4 1]); % test Pas peaks
    
    gold_output = [];
    test_output = [];
    
    for x = 1:96
        for y = 1:96
            for z = 1:50    % z is the slice number
                if frac_an.img(x,y,z) >= 0.1
                    frac_val = frac_an.img(x,y,z);
                    %Defining vectors for gold pas
                    u = [AAA(x,y,z,7) AAA(x,y,z,8) AAA(x,y,z,9)];
                    v = [AAA(x,y,z,15) AAA(x,y,z,16) AAA(x,y,z,17)];
                    cross_angle_gold = atan2d(norm(cross(u,v)),dot(u,v));
                    if (cross_angle_gold > 90)
                        cross_angle_gold = 180 - cross_angle_gold;
                    end
                    
                    % Appending to output matrix if angle is not zero.
                    if (cross_angle_gold ~= 0)
                        row1 = [frac_val cross_angle_gold];
                        gold_output = [gold_output;row1];
                    end
                    
                    %Defining vectors for test pas
                    i = [BBB(x,y,z,7) BBB(x,y,z,8) BBB(x,y,z,9)];
                    j = [BBB(x,y,z,15) BBB(x,y,z,16) BBB(x,y,z,17)];
                    cross_angle_test = atan2d(norm(cross(i,j)),dot(i,j));
                    if (cross_angle_test > 90)
                        cross_angle_test = 180 - cross_angle_test;
                    end
                    
                    % Appending to output matrix if angle is not zero.
                    if (cross_angle_test ~= 0)
                        row2 = [frac_val cross_angle_test];
                        test_output = [test_output;row2];
                    end
                end
            end
        end
    end
    
    figure(3);
    temp = 0.1;
    gold_min_output = [];
    gold_max_output = [];
    
    test_min_output = [];
    test_max_output = [];
    
    final_output = [];

    max_fa = max(max(max(frac_an.img)));
    while (temp < max_fa)
        beg_limit = temp;
        end_limit = temp + 0.1;
        fa_val = (beg_limit + end_limit)/2;
        
        %Gold Calculations
        gold_col1 = gold_output(:,1);
        gold_col2 = gold_output(:,2);
        gold_index = find((beg_limit < gold_col1) & (gold_col1 < end_limit));
        
        gold_max1 = max(gold_col2(gold_index));
        gold_min1 = min(gold_col2(gold_index));
        
        gold_row1 = [fa_val gold_max1];
        gold_row2 = [fa_val gold_min1];
        
        gold_max_output = [gold_max_output;gold_row1];
        gold_min_output = [gold_min_output;gold_row2];
        
        %Test Calculations
        test_col1 = test_output(:,1);
        test_col2 = test_output(:,2);
        test_index = find((beg_limit < test_col1) & (test_col1 < end_limit));
        
        test_max1 = max(test_col2(test_index));
        test_min1 = min(test_col2(test_index));
        
        test_row1 = [fa_val test_max1];
        test_row2 = [fa_val test_min1];
        
        test_max_output = [test_max_output;test_row1];
        test_min_output = [test_min_output;test_row2];
        
        final_output = [final_output;gold_row1];
        final_output = [final_output;gold_row2];
        final_output = [final_output;test_row1];
        final_output = [final_output;test_row2];
                        
        temp = temp + 0.1;
    end
    scatter(final_output(:,1),final_output(:,2));
    hold on;
    a1 = plot(gold_max_output(:,1),gold_max_output(:,2)); M1 = 'Gold Max Angle';
    a2 = plot(gold_min_output(:,1),gold_min_output(:,2)); M2 = 'Gold Min Angle';
    a3 = plot(test_max_output(:,1),test_max_output(:,2)); M3 = 'Test Max Angle';
    a4 = plot(test_min_output(:,1),test_min_output(:,2)); M4 = 'Test Min Angle';
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12)
    ylabel('Crossing Angle b/w 2 Fibers','fontweight','demi','fontsize',12);
    legend([a1;a2;a3;a4], M1,M2,M3,M4);
    title('Crossing Angle Comparsion b/w Gold and Test set');
    
end