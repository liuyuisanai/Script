function label = get_label_from_list( list )
label = zeros(size(list, 1), 1);
    id = 0;
    str = '';
    lnum = numel(strfind(list{1}, '/'));
    rnum = numel(strfind(list{1}, '\'));
    if lnum > rnum
        smb = '/';
    else
        smb = '\';
    end
    for i = 1 : numel(list)
        rid = strfind(list{i}, smb);
        rid = rid(end)-1;
        lid = strfind(list{i}(1:rid), smb);
        lid = lid(end)+1;
        if strcmp(str, list{i}(lid:rid)) == 0
            id = id+1;
            str = list{i}(lid:rid);        
        end
        label(i) = id;
    end
end

