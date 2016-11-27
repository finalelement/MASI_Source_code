function number_of_peaks_kappa(number_of_fibers)
    
    accum_matrix = [];
    peaks_gold = 'gold_peaks.Bdouble';
    fa = 'gold_fa.nii';
    for i = 1:11
       
        peaks_file = sprintf('test_%d_peaks.Bdouble',i);
        my_field_1 = strcat('A',num2str(i));
        
        variable.(my_field_1) = single_scan_peaks(fa,peaks_gold,peaks_file,number_of_fibers);
        
        accum_matrix = [accum_matrix,variable.(my_field_1)];
        
        
    end
   
    dims = size(accum_matrix);
    % 5 is the number of categories here for the number of peaks 0,1,2,3
    kappa_feed = zeros(dims(1),4);
    for j = 1:dims(1)
       
       count_0 = 0;
       count_1 = 0;
       count_2 = 0;
       count_3 = 0;
       
       for k = 1:11
           
           if (accum_matrix(j,k) == 0)
               count_0 = count_0 + 1;
           end
           
           if (accum_matrix(j,k) == 1)
               count_1 = count_1 + 1;
           end

           if (accum_matrix(j,k) == 2)
               count_2 = count_2 + 1;
           end
           
           if (accum_matrix(j,k) == 3)
               count_3 = count_3 + 1;
           end
           
       end
       
       kappa_feed(j,1:4) = [count_0 count_1 count_2 count_3];
         
    end
    
    fleiss(kappa_feed)
end