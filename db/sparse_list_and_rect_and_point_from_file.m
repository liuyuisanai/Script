function [newlist, newrect, newpoint] = sparse_list_and_rect_and_point_from_file(listf, rectf, pointf)
    list = read_list_from_msstyle_file('', listf, false);
    rect = read_rect_from_msstyle_file(rectf);
    point = read_pts_from_msstyle_file(pointf, 5);
    assert(length(rect)==length(list), 'Length of list and rect mismatch!');
    assert(length(point)==length(list), 'Length of list and point mismatch!');
    nowid = 1;
    for i = 1 : length(rect)
        len_t = size(rect{i}, 1);
        assert(len_t == size(point{i}, 1), ...
            sprintf('%dth number of pts and rect not match(%d vs %d)', i, ...
            size(point{i}, 1), len_t));
        for j = 1 : len_t
            newlist{nowid} = list{i};
            newrect{nowid} = rect{i}(j,:);
            newpoint{nowid} = point{i}(j,:);
            nowid = nowid+1;
        end
    end
end