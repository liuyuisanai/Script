function write_pts_to_sparsemsstyle_file(points, file)
    fid = fopen(file, 'w');
    fprintf(fid, '%d\r\n', length(points));
    for i = 1:length(points)
        fprintf(fid, '%d 1 ', i-1);
        fprintf(fid, '%.3f ', points{i}');
        fprintf(fid, '\r\n');
    end

    fclose(fid);
end