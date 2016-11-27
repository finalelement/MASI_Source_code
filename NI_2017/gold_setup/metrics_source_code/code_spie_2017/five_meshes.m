function five_meshes
    figure(2);
    hold on;
    
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1000/PAS16')) 
    
    temp = zeros(21,21);
    [out1,n11] = plot_heat_map_cross_angle_two_fiber_alldata;
    
    view(3);
    
    %h.ZData = ones(size(n11)) * -max(max(n1));
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1500/PAS16')) 
    
    [out2,n22] = plot_heat_map_cross_angle_two_fiber_alldata;
    
    %h.ZData = ones(size(n22)) * -max(max(n2));
    set(out2,'ZData',-2 + temp)
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b1500/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2000/PAS16')) 
    
    [out3,n33] = plot_heat_map_cross_angle_two_fiber_alldata;
    
    set(out3,'ZData',-4 + temp)
    
    rmpath(genpath('/fs4/masi/nathv/HARDI_Metrics/b2000/PAS16'))
    
    colormap(jet); % spring heat map
    title('Two Fiber Case:Angle of Separation 11 samples & Intensity Map');
    grid on
    %view(3);
    
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    ylabel('Angle of Separation','fontweight','demi','fontsize',12);
    % zlabel('Number of Voxels','fontweight','demi','fontsize',12);
    set(gca,'ZTickLabel',[])

    
    


end