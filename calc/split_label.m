function [id_tr, id_te] = getids( label )
    rand('state',sum(clock()));
    [~,~,ulabel] = unique(label);
    id_tr = [];
    id_te = [];
    for i = 1 : max(ulabel)
        t = find(ulabel==i);
        t_tr = t(randperm(numel(t), ceil(numel(t)/2)));
        t_te = setdiff(t, t_tr);
    %     t_tr = randperm(top-bottom,ceil((top-bottom+1)/2))-1+bottom;
    %     t_te = setdiff(bottom:top, t_tr);
    %     mid = bottom+8;
        id_tr = [id_tr,t_tr'];
        id_te = [id_te,t_te'];
    end
end

