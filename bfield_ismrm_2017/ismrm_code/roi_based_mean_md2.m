function [out1,out2,out3,out4] = roi_based_mean_md2(j)

    % Load the results file
    load('ts00_results.mat');
    
    % Load the handrawn regions
    rois_mask = load_untouch_nii('target_processed_4_rois_2_5_mm.nii');
    
    r1_means = [];
    r2_means = [];
    r3_means = [];
    r4_means = [];
    
    r1_std = [];
    r2_std = [];
    r3_std = [];
    r4_std = [];
     
    % Looping over the sites !
    for i = 1:4
    
        % Comment here eventually
        roi_one = [];
        roi_two = [];
        roi_three = [];
        roi_four = [];

        % Lets loop !
        for x = 1:78
            for y = 1:93
                for z = 1:75

                    if(rois_mask.img(x,y,z) == 1)
                        roi_one = [roi_one,results(j,i).md2(x,y,z)];
                    end

                    if(rois_mask.img(x,y,z) == 2)
                        roi_two = [roi_two,results(j,i).md2(x,y,z)];
                    end

                    if(rois_mask.img(x,y,z) == 3)
                        roi_three = [roi_three,results(j,i).md2(x,y,z)];
                    end

                    if(rois_mask.img(x,y,z) == 4)
                        roi_four = [roi_four,results(j,i).md2(x,y,z)];
                    end
                end
            end
        end
        
        r1_means = [r1_means,mean(roi_one)];
        r2_means = [r2_means,mean(roi_two)];
        r3_means = [r3_means,mean(roi_three)];
        r4_means = [r4_means,mean(roi_four)];
        
        r1_std = [r1_std,std(roi_one)];
        r2_std = [r2_std,std(roi_two)];
        r3_std = [r3_std,std(roi_three)];
        r4_std = [r4_std,std(roi_four)];
                
    end
    
    r1_x = [0.8 1.8 2.8 3.8];
    r2_x = [0.9 1.9 2.9 3.9];
    r3_x = [1 2 3 4];
    r4_x = [1.1 2.1 3.1 4.1];
    
    out1 = [r1_x;r1_means;r1_std];
    out2 = [r2_x;r2_means;r2_std];
    out3 = [r3_x;r3_means;r3_std];
    out4 = [r4_x;r4_means;r4_std];
    
    %{
    figure(2)
    clf;
    hold on;
    errorbar(r1_x,r1_means,r1_std,'x')
    errorbar(r2_x,r2_means,r2_std,'o')
    errorbar(r3_x,r3_means,r3_std,'d')
    errorbar(r4_x,r4_means,r4_std,'*')
    
    ylabel('FA')
    xlabel('Sites')
    grid on
    title('After-correction:b1000')
    %}
end