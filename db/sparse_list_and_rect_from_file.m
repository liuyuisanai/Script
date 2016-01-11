function [newlist, newrect] = sparse_list_and_rect_from_file(listf, rectf)
    list = read_list_from_msstyle_file('', listf, false);
    rect = read_rect_from_msstyle_file(rectf);
    assert(length(rect)==length(list), 'Length of list and rect mismatch!');
    nowid = 1;
    for i = 1 : length(rect)
        for j = 1 : size(rect{i}, 1)
            newlist{nowid} = list{i};
            newrect{nowid} = rect{i}(j,:);
            nowid = nowid+1;
        end
    end
end