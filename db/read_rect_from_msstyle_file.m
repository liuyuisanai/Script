function rect = read_rect_from_msstyle_file(file)
%rect = [left, right, top, bottom]
    fid = fopen(file, 'r');
    person_num = fscanf(fid, '%d', 1);
    for i = 1 : person_num
        person_id = fscanf(fid, '%d', 1);
        rect_num = fscanf(fid, '%d', 1);
        rect_t = fscanf(fid, '%f', 4*rect_num);
        rect_t = reshape(rect_t, 4, rect_num)';
        rect{i} = rect_t;
    end
    fclose(fid);
end