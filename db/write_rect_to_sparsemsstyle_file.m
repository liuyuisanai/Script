function write_rect_to_sparsemsstyle_file(faces, file)

fid = fopen(file, 'w');

fprintf(fid, '%d\r\n', length(faces));
for i = 1:length(faces)
    fprintf(fid, '%d ', i-1);
    fprintf(fid, '%.3f ', faces{i}');
    fprintf(fid, '\r\n');
end

fclose(fid);