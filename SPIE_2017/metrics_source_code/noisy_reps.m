% Take a single nifti file and create noisy repetitions through matlab

%Nifti file is the name of the nii file, this only reads nii files not
%zipped files

%reps is the number of repetitions that will be generated with the noise

%Note - This uses masimatlab libraries, hence please add it to the path
%before trying to run this script.

function noisy_reps(nifti_file,reps,noise_dev)
    for i = 1:reps
        count = 1;
        nii = load_untouch_nii(nifti_file);
        [X,Y,Z,G] = size(nii.img);
        noise = normrnd(0,noise_dev, [X Y Z G]);
        
        %So thats noise generated right there, lets generate some crappy
        %data with this.
        
        crap = double(nii.img) + noise;
        
        %Changing the header as we have created double datatype signals
        nii.hdr.dime.datatype = 64;
        nii.hdr.dime.bitpix = 64;
        
        %Assigning the crappy data to the nii file
        nii.img = crap;
        name = sprintf('test_%d.nii',i);
        save_untouch_nii(nii,name);
        clear nii X Y Z G noise crap name;
    end
end