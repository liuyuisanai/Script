function [tpr, fpr, thresh, AUC] = get_ROC(dist, label)
    label = single(label);
    if size(label, 1) ~= size(label, 2)
        label = reshape(label, [numel(label) 1]);
        label = repmat(label, [1 length(label)])==repmat(label',[length(label) 1]);
    end
    if size(dist,1)==size(dist,2)
        dist = dist-100*eye(length(dist));
        t = find(dist < -1);
        dist(t)=[];
        label(t)=[];
    end
    assert(numel(dist)==numel(label), 'Score size should equal to label.');
    dist = reshape(dist, [numel(dist) 1]);
    label = reshape(label, [numel(label) 1]);
%     dist = abs(dist);
    tl = dist(find(label==1));
    fl = dist(find(label==0));
    if true
        tl = tl(randperm(numel(tl), min(2000, numel(tl))));
        fl = fl(randperm(numel(fl), min(20000, numel(fl))));
    end
    minl = min(dist);
    maxl = max(dist);
    step = 1000;
    parfor i = 1 : step
        thresh(i) = minl+(maxl-minl)/step*i;
        tpr(i) = sum(tl>=thresh(i))/numel(tl);
        fpr(i) = sum(fl>=thresh(i))/numel(fl);
    end
    AUC = -trapz(fpr, tpr);
end