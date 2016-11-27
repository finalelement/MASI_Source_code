function ab_difference_test
   
    input_matrix = mean_before_after_subplots;
    % Create before matrix
    before_diff_mat = [];
    after_diff_mat = [];
    
    
    jt = 1;
    for m = 1:4
        startvb = 1;
        for k = 1:4
            temp = abs(input_matrix(jt,:) - input_matrix(startvb,:));
            before_diff_mat = [before_diff_mat;temp];
            startvb = startvb + 2;
        end
        jt = jt + 2;
    end
    
    for n = 1:4
        startva = 2;
        for l = 1:4
            temp = abs(input_matrix(2*n,:) - input_matrix(startva,:));
            after_diff_mat = [after_diff_mat;temp];
            startva = startva + 2;
        end
    end
   
end