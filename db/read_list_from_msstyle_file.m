function image_path = read_list_from_msstyle_file(image_folder, image_list,full)
    if nargin < 3
        full = true;
    end
    fid = fopen(image_list, 'r');
    num = fscanf(fid, '%d', 1);
    image_path = cell(num, 1);
    for i = 1:num
        fscanf(fid, '%d ', 1);
        offset = fgetl(fid);
        if full
            image_path{i} = [image_folder, '\', offset];
        else
            image_path{i} = offset;
        end
    end
    fclose(fid);
end