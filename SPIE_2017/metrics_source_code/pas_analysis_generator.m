function pas_analysis_generator
    save_path_dir = sprintf('/home-nfs/local/VANDERBILT/nathv/Desktop/matlab_hardi_metrics/Fresh_Trial/Qball_figures/');
    
    % One Fiber Analysis
    
    % Success Fraction ## DONE
    one_fiber_sf_fig = report_dev_single_fiber_sf_three_trials;
    sf_file_name = 'one_fiber_sf.pdf';
    m = strcat(save_path_dir,sf_file_name);
    save2pdf(m,one_fiber_sf_fig);
    clf;
    
    % Single Fiber Disagreement with DT ## DONE
    one_fiber_dtdisag_first_order = dt_disagreement_single_fiber_box_report_deviation;
    dtdisag_file_name = 'one_fiber_dtdisag.pdf';
    m = strcat(save_path_dir,dtdisag_file_name);
    save2pdf(m,one_fiber_dtdisag_first_order);
    clf;
    
    % Bias ## DONE
    one_fiber_dtdisag_first_order_bias = dt_disagreement_one_fiber_report_bias;
    dtdisag_bias_file_name = 'one_fiber_dtdisag_bias.pdf';
    m = strcat(save_path_dir,dtdisag_bias_file_name);
    save2pdf(m,one_fiber_dtdisag_first_order_bias);
    clf;
    
    % MSE ## DONE
    one_fiber_dtdisag_first_order_mse = dt_disagreement_one_fiber_report_mse;
    dtdisag_mse_file_name = 'one_fiber_dtdisag_mse.pdf';
    m = strcat(save_path_dir,dtdisag_mse_file_name);
    save2pdf(m,one_fiber_dtdisag_first_order_mse);
    clf;
    
    % Peak Strength ## DONE
    one_fiber_peak_strength = plot_2dhist_single_fiber_f1_peak_strength_alldata;
    peak_strength_file_name = 'one_fiber_peak_strength.pdf';
    m = strcat(save_path_dir,peak_strength_file_name);
    save2pdf(m,one_fiber_peak_strength);
    clf;
    
    % Error Metric ## DONE
    one_fiber_peak_error = peak_to_peak_single_fiber_error_box_report_deviation;
    peak_error_file_name = 'one_fiber_peak_error.pdf';
    m = strcat(save_path_dir,peak_error_file_name);
    save2pdf(m,one_fiber_peak_error);
    clf;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Two Fiber Analysis
    
    % Success Fraction ## DONE
    two_fiber_sf_fig = report_dev_two_fiber_sf_three_trials;
    sf_file_name = 'two_fiber_sf.pdf';
    m = strcat(save_path_dir,sf_file_name);
    save2pdf(m,two_fiber_sf_fig);
    clf;
    
    % Two Fiber Disagreement with DT ## DONE
    two_fiber_dtdisag_first_order = dt_disagreement_two_fiber_box_report_deviation;
    dtdisag_file_name = 'two_fiber_dtdisag.pdf';
    m = strcat(save_path_dir,dtdisag_file_name);
    save2pdf(m,two_fiber_dtdisag_first_order);
    clf;
    
    % Bias Disagreement with DT ## DONE
    two_fiber_dtdisag_first_order_bias = dt_disagreement_two_fiber_report_bias;
    dtdisag_bias_file_name = 'two_fiber_dtdisag_bias.pdf';
    m = strcat(save_path_dir,dtdisag_bias_file_name);
    save2pdf(m,two_fiber_dtdisag_first_order_bias);
    clf;
    
    % MSE Disagreement with DT ## DONE
    two_fiber_dtdisag_first_order_mse = dt_disagreement_two_fiber_report_mse;
    dtdisag_mse_file_name = 'two_fiber_dtdisag_mse.pdf';
    m = strcat(save_path_dir,dtdisag_mse_file_name);
    save2pdf(m,two_fiber_dtdisag_first_order_mse);
    clf;
    
    % Two Fiber Disagreement with DT second order ## DONE
    two_fiber_dtdisag_second_order = dt_disagreement_second_order_two_fiber_box_report_deviation;
    dtdisag_file_name = 'two_fiber_second_order_dtdisag.pdf';
    m = strcat(save_path_dir,dtdisag_file_name);
    save2pdf(m,two_fiber_dtdisag_second_order);
    clf;
    
    % Angle of Separation and Intensity Map ## DONE
    two_fiber_angle_sep = plot_2dhist_cross_angle_two_fiber_alldata;
    angle_sep_file_name = 'two_fiber_angle_sep.pdf';
    m = strcat(save_path_dir,angle_sep_file_name);
    save2pdf(m,two_fiber_angle_sep);
    clf;
    
    % Bias Angle of Separation ## DONE
    two_fiber_angle_sep_bias = cross_angle_two_fiber_report_bias;
    angle_sep_bias_file_name = 'two_fiber_angle_sep_bias.pdf';
    m = strcat(save_path_dir,angle_sep_bias_file_name);
    save2pdf(m,two_fiber_angle_sep_bias);
    clf;
    
    % MSE Angle of Separation ## DONE
    two_fiber_angle_sep_mse = cross_angle_two_fiber_report_mse;
    angle_sep_mse_file_name = 'two_fiber_angle_sep_mse.pdf';
    m = strcat(save_path_dir,angle_sep_mse_file_name);
    save2pdf(m,two_fiber_angle_sep_mse);
    clf;
    
    % Peak Strength f1 Normalized ## DONE
    two_fiber_peak_strength = plot_2dhist_two_fiber_f1_peak_strength_alldata;
    peak_strength_file_name = 'two_fiber_peak_strength.pdf';
    m = strcat(save_path_dir,peak_strength_file_name);
    save2pdf(m,two_fiber_peak_strength);
    clf;
    
    % Error Metric ## DONE
    two_fiber_peak_error = peak_to_peak_two_fiber_error_box_report_deviation;
    peak_error_file_name = 'two_fiber_peak_error.pdf';
    m = strcat(save_path_dir,peak_error_file_name);
    save2pdf(m,two_fiber_peak_error);
    clf;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Three Fiber Analysis
    
    % Success Fraction ## DONE
    three_fiber_sf_fig = report_dev_three_fiber_sf_three_trials;
    sf_file_name = 'three_fiber_sf.pdf';
    m = strcat(save_path_dir,sf_file_name);
    save2pdf(m,three_fiber_sf_fig);
    clf;
    
    % Three Fiber Disagreement with DT ## DONE
    three_fiber_dtdisag_first_order = dt_disagreement_three_fiber_box_report_deviation;
    dtdisag_file_name = 'three_fiber_dtdisag.pdf';
    m = strcat(save_path_dir,dtdisag_file_name);
    save2pdf(m,three_fiber_dtdisag_first_order);
    clf;
    
    % Bias Disagreement with DT ## DONE
    three_fiber_dtdisag_first_order_bias = dt_disagreement_three_fiber_report_bias;
    dtdisag_bias_file_name = 'three_fiber_dtdisag_bias.pdf';
    m = strcat(save_path_dir,dtdisag_bias_file_name);
    save2pdf(m,three_fiber_dtdisag_first_order_bias);
    clf;
    
    % MSE Disagreement with DT ## DONE
    three_fiber_dtdisag_first_order_mse = dt_disagreement_three_fiber_report_mse;
    dtdisag_mse_file_name = 'three_fiber_dtdisag_mse.pdf';
    m = strcat(save_path_dir,dtdisag_mse_file_name);
    save2pdf(m,three_fiber_dtdisag_first_order_mse);
    clf;
    
    % Three Fiber Disagreement with DT second order ## DONE
    three_fiber_dtdisag_second_order = dt_disagreement_second_order_three_fiber_box_report_deviation;
    dtdisag_file_name = 'three_fiber_second_order_dtdisag.pdf';
    m = strcat(save_path_dir,dtdisag_file_name);
    save2pdf(m,three_fiber_dtdisag_second_order);
    clf;
    
    % Angle of Separation and Intensity Map ## DONE
    three_fiber_angle_sep = plot_2dhist_cross_angle_three_fiber_alldata;
    angle_sep_file_name = 'three_fiber_angle_sep.pdf';
    m = strcat(save_path_dir,angle_sep_file_name);
    save2pdf(m,three_fiber_angle_sep);
    clf;
    
    % Bias Angle of Separation ## DONE
    three_fiber_angle_sep_bias = cross_angle_three_fiber_report_bias;
    angle_sep_bias_file_name = 'three_fiber_angle_sep_bias.pdf';
    m = strcat(save_path_dir,angle_sep_bias_file_name);
    save2pdf(m,three_fiber_angle_sep_bias);
    clf;
    
    % MSE Angle of Separation ## DONE
    three_fiber_angle_sep_mse = cross_angle_three_fiber_report_mse;
    angle_sep_mse_file_name = 'three_fiber_angle_sep_mse.pdf';
    m = strcat(save_path_dir,angle_sep_mse_file_name);
    save2pdf(m,three_fiber_angle_sep_mse);
    clf;
    
    % Peak Strength f1 Normalized ## DONE
    three_fiber_peak_strength = plot_2dhist_three_fiber_f1_peak_strength_alldata;
    peak_strength_file_name = 'three_fiber_peak_strength_f1.pdf';
    m = strcat(save_path_dir,peak_strength_file_name);
    save2pdf(m,three_fiber_peak_strength);
    clf;
    
    % Peak Strength f2 Normalized ## DONE
    three_fiber_peak_strength = plot_2dhist_three_fiber_f2_peak_strength_alldata;
    peak_strength_file_name = 'three_fiber_peak_strength_f2.pdf';
    m = strcat(save_path_dir,peak_strength_file_name);
    save2pdf(m,three_fiber_peak_strength);
    clf;
    
    % Error Metric ## DONE
    three_fiber_peak_error = peak_to_peak_three_fiber_error_box_report_deviation;
    peak_error_file_name = 'three_fiber_peak_error.pdf';
    m = strcat(save_path_dir,peak_error_file_name);
    save2pdf(m,three_fiber_peak_error);
    clf;
    
    
    
    
    
%gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=<outputfile name> <page1> <page2> <page3>
end