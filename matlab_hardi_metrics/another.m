% Do it the Just in way

scan_dir = directory(fullfile('/home-nfs/local/VANDERBILT/nathv/Desktop/matlab_hard_metrics/project'));

if scan_dir.exist()
    scan_dir.rm();
end
scan_dir.mkdir();

% Creating test directory per raw mri data
reps = 12;
for i = 1:reps
    name = sprintf('dir%d',reps);
    f1_dir = directory(scan_dir,name);
    f1_dir.mkdir();
end


