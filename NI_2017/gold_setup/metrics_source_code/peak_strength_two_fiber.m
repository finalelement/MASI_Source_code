function [output] = peak_strength_two_fiber(fa,peaks_file)

    fileID = fopen(peaks_file,'rb','ieee-be');
    A = fread(fileID,'double');
    fclose(fileID);
    
    % Obtain size from the fa which will be used for pas files
    frac_an = load_untouch_nii(fa);
    
    % Reshaping and permuting both gold and test PAS in order
    AA = reshape(A,[30 96 96 50]);
    AAA = permute(AA,[2 3 4 1]); % gold Pas peaks
    
    output = [];
    count_check = 0;
    for x = 1:96
        for y = 1:96
            for z = 1:50
                % Validate voxels with exit code
                if (AAA(x,y,z,1) == 0)
                    % Validating single fiber voxels from set.
                    if (AAA(x,y,z,3) == 2)
                        frac_val = frac_an.img(x,y,z);
                        % Peak strength of fiber one
                        strength1 = AAA(x,y,z,10);
                        if strength1 < 1
                            row = [frac_val strength1];
                            output = [output;row];
                        end
                        
                        if strength1 > 1
                            count_check = count_check + 1;
                            row1 = [frac_val 1];
                            output = [output;row1];
                        end
                    end
                end
            end
        end
    end
    
    
    figure(1);
    hold on;
    hist3(output,[20 20]);
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    
    % Extract histogram data
    n = hist3(output,[20 20]);
    n1 = n';
    n1(size(n,1) + 1, size(n,2) + 1) = 0;
    
    % Generate grid for 2-D projected view of intensities.
    xb = linspace(min(output(:,1)),max(output(:,1)),size(n,1)+1);
    yb = linspace(min(output(:,2)),max(output(:,2)),size(n,1)+1);
    
    % Make a pseudocolor plot.
    h = pcolor(xb,yb,n1);
    
    h.ZData = ones(size(n1)) * -max(max(n));
    colormap(jet); % spring heat map
    title('Two Fiber Case:Gold Sample Peak strength of fiber one');
    grid on
    view(3);
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    ylabel('Peak Strength','fontweight','demi','fontsize',12);
    zlabel('Number of Voxels','fontweight','demi','fontsize',12);
    
    % text(0.05,0.85,{'Parameter 1: blah blah';'Parameter 2: bloop bloop';'Parameter 3: ....'},'Interpreter','Latex')
                   
end