function r1_means = roi_fa1_mean(roi)
   
    % Load the results file
    load('ts00_results.mat');
    %load('ts00_16_dir_results.mat');
    
    % Load the handrawn regions
    rois_mask = load_untouch_nii('target_processed_4_rois_2_5_mm.nii');
    
    r1_means = [];
    r1_std = [];
    
    %Looping over b-vals
    for j = 1:4
        % Looping over the sites !
        r1_row = [];
        for i = 1:4

            % Comment here eventually
            roi_one = [];

            % Lets loop !
            for x = 1:78
                for y = 1:93
                    for z = 1:75

                        %if(rois_mask.img(x,y,z) == roi)
                            roi_one = [roi_one,results(j,i).md1(x,y,z)];
                        %end
                    end
                end
            end

            r1_row = [r1_row,nanmean(roi_one)];
            r1_std = [r1_std,nanstd(roi_one)];

        end
        r1_means = [r1_means;r1_row];
        %display(r1_means)
    end
end