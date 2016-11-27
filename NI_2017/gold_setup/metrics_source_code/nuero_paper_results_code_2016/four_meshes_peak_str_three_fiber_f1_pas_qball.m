function four_meshes_peak_str_three_fiber_f1_pas_qball

    mask = 'WM_nuero_mask.nii';
    figure(1);
    hold on;
    
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    subplot(1,4,1)
    grid on
    [out1,n11] = plot_2dhist_three_fiber_f1_peak_strength_alldata_nuero(mask);
    %view([-40 90]);
    ylabel('f1');
    xlabel('Fractional Anisotropy');
    title('PAS-b1000');
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/Qball_sh8')) 
    
    subplot(1,4,2)
    grid on
    [out2,n22] = plot_2dhist_three_fiber_f1_peak_strength_alldata_nuero(mask);
    %view([-40 90]);
    ylabel('f1');
    xlabel('Fractional Anisotropy');
    title('Qball-b1000')
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b1000/Qball_sh8'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16')) 
    
    subplot(1,4,3)
    grid on
    [out3,n33] = plot_2dhist_three_fiber_f1_peak_strength_alldata_nuero(mask);
    %view([-40 90]);
    ylabel('f1');
    xlabel('Fractional Anisotropy');
    title('PAS-b3000')
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/PAS16'))
    
    addpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/Qball_sh8')) 
    
    subplot(1,4,4)
    grid on
    [out4,n44] = plot_2dhist_three_fiber_f1_peak_strength_alldata_nuero(mask);
    %view([-40 90]);
    ylabel('f1');
    xlabel('Fractional Anisotropy');
    title('Qball-b3000')
    
    rmpath(genpath('/fs4/masi/nathv/NueroImage_2016_Code/organized_normalized_data_for_runnable_code/b3000/Qball_sh8'))
    
    colormap(jet); 
    %xlabel('Fractional Anisotropy','fontweight','demi','fontsize',12);
    %ylabel('Qball-b3000 - Strength','fontweight','demi','fontsize',12);

    subplot(1,4,1)
    v1 = get(gca,'Clim');

    subplot(1,4,2)
    v2 = get(gca,'Clim');
 
    subplot(1,4,3)
    v3 = get(gca,'Clim');
 
    subplot(1,4,4)
    v4 = get(gca,'Clim');
    
    v_total = [v1 v2 v3 v4];
    max_v = max(v_total);
        
    subplot(1,4,1)
    set(gca,'Clim',[0 max_v])
    
    subplot(1,4,2)
    set(gca,'Clim',[0 max_v])
    
    subplot(1,4,3)
    set(gca,'Clim',[0 max_v])
    
    subplot(1,4,4)
    set(gca,'Clim',[0 max_v])
 
    h=colorbar('eastoutside');
    %set(h, 'Position', [.1 .020 .8150 .05]);
    
    colormap(parula); 
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    file_name = sprintf('three_fiber_peak_strength_f1');
    print(file_name,'-depsc2','-r0')
    
end
    