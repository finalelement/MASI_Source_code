function five_meshes_trial_2
    figure(1);
    hold on;
    % title('Minimum Crossing Angle Gold Models Intensity Map');
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16')) 
    subplot(5,1,1)
    grid on
    [out1,n11] = plot_heat_map_cross_angle_all_fiber_alldata;
    view([-40 90]);
    ylabel('b1000')
    title('PAS-RE16 Min Crossing Angle Gold Sets Intensity Map');
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1500/PAS16')) 
    subplot(5,1,2)
    grid on
    [out2,n22] = plot_heat_map_cross_angle_all_fiber_alldata;
    view([-40 90]);
    ylabel('b1500')
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1500/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b2000/PAS16')) 
    subplot(5,1,3)
    grid on
    [out3,n33] = plot_heat_map_cross_angle_all_fiber_alldata;
    view([-40 90]);
    ylabel('b2000')
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b2000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b2500/PAS16')) 
    subplot(5,1,4)
    grid on
    [out4,n44] = plot_heat_map_cross_angle_all_fiber_alldata;
    view([-40 90]);
    ylabel('b2500')
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b2500/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16')) 
    subplot(5,1,5)
    grid on
    [out5,n55] = plot_heat_map_cross_angle_all_fiber_alldata;
    view([-40 90]);
    ylabel('b3000')
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16'))
    
    colormap(jet); 
    xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    ylabel('b3000 - Crossing Angle','fontweight','demi','fontsize',12);
    % set(gca,'ZTickLabel',[])
    
    subplot(5,1,1)
    v1 = get(gca,'Clim');
    %x1 = get(gca,'Xlim');
    %y1 = get(gca,'Ylim');
    
    subplot(5,1,2)
    v2 = get(gca,'Clim');
    %x2 = get(gca,'Xlim');
    %y2 = get(gca,'Ylim');
    
    subplot(5,1,3)
    v3 = get(gca,'Clim');
    %x3 = get(gca,'Xlim');
    %y3 = get(gca,'Ylim');
    
    subplot(5,1,4)
    v4 = get(gca,'Clim');
    %x4 = get(gca,'Xlim');
    %y4 = get(gca,'Ylim');
    
    subplot(5,1,5)
    v5 = get(gca,'Clim');
    %x5 = get(gca,'Xlim');
    %y5 = get(gca,'Ylim');
    
    v_total = [v1 v2 v3 v4 v5];
    %x_total = [x1 x2 x3 x4 x5];
    %y_total = [y1 y2 y3 y4 y5];
    max_v = max(v_total);
    
    subplot(5,1,1)
    set(gca,'Clim',[0 max_v])
    %set(gca,'Xlim',[min(x_total) max(x_total)])
    %set(gca,'Ylim',[min(y_total) max(y_total)])
    
    subplot(5,1,2)
    set(gca,'Clim',[0 max_v])
    %set(gca,'Xlim',[min(x_total) max(x_total)])
    %set(gca,'Ylim',[min(y_total) max(y_total)])
    
    subplot(5,1,3)
    set(gca,'Clim',[0 max_v])
    %set(gca,'Xlim',[min(x_total) max(x_total)])
    %set(gca,'Ylim',[min(y_total) max(y_total)])
    
    subplot(5,1,4)
    set(gca,'Clim',[0 max_v])
    %set(gca,'Xlim',[min(x_total) max(x_total)])
    %set(gca,'Ylim',[min(y_total) max(y_total)])    
    
    subplot(5,1,5)
    set(gca,'Clim',[0 max_v])
    %set(gca,'Xlim',[min(x_total) max(x_total)])
    %set(gca,'Ylim',[min(y_total) max(y_total)])
    
    h=colorbar('SouthOutside');
    set(h, 'Position', [.1 .020 .8150 .05]);    
end