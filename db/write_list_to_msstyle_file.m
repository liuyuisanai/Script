function write_list_to_msstyle_file(list, file)

fid = fopen(file, 'w');

fprintf(fid, '%d\r\n', length(list));
for i = 1:length(list)
    fprintf(fid, '%d ', i-1);
    fprintf(fid, '%s', list{i});
    fprintf(fid, '\r\n');
end

fclose(fid);