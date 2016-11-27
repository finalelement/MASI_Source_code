% Peak strength of first fiber in two fiber case. The peak strengths have
% been normalized

function [test_output] = peak_strength_f1_two_fibers_2dhist(fa,peaks_file)
    
    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID); 
    
    % Obtain size from the fa which will be used for dt and pas files
    frac_an = load_untouch_nii(fa);    
    dims = size(frac_an.img);
    
    AA = reshape(A,[30 dims(1) dims(2) dims(3)]);
    AAA = permute(AA,[2 3 4 1]); % test Pas peaks
    
    test_output = [];
    
    for x = 1:dims(1)
        for y = 1:dims(2)
            for z = 1:dims(3)
                % Validate voxels with exit code 
                if (AAA(x,y,z,1) == 0)
                    % Validating only two fiber voxels from the set
                    if (AAA(x,y,z,3) == 2)
                        frac_val = frac_an.img(x,y,z);
                        
                        %Defining vectors for the PAS set
                        f1 = AAA(x,y,z,10);
                        f2 = AAA(x,y,z,18);
                        f3 = AAA(x,y,z,26);
                        norm_strength = f1/(f1+f2+f3);
                        
                        row = [frac_val norm_strength];
                        test_output = [test_output;row];
                        
                    end
                end
            end
        end
    end
    
    %{
    figure(1);
    hold on;
    hist3(test_output,[20 20]);
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    
    % Extract histogram data
    n = hist3(test_output,[20 20]);
    n1 = n';
    n1(size(n,1) + 1, size(n,2) + 1) = 0;
    
    % Generate grid for 2-D projected view of intensities.
    xb = linspace(min(test_output(:,1)),max(test_output(:,1)),size(n,1)+1);
    yb = linspace(min(test_output(:,2)),max(test_output(:,2)),size(n,1)+1);
    
    % Make a pseudocolor plot.
    h = pcolor(xb,yb,n1);
    
    h.ZData = ones(size(n1)) * -max(max(n));
    colormap(jet); % spring heat map
    title('Two Fiber Case:Peak Strength f1, Gold sample & Intensity Map');
    grid on
    view(3);
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    ylabel('Peak Strength f1','fontweight','demi','fontsize',12);
    zlabel('Number of Voxels','fontweight','demi','fontsize',12);
    %}
end