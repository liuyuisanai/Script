function [tpr, fpr, thresh, AOC] = get_ROC(dist, label)
    if size(dist,1)==size(dist,2)&&sum(diag(dist))<size(dist,1)*0.9
        dist = max(dist,2*eye(size(dist,1))-1);
    end
    assert(numel(dist)==numel(label), 'Score size should equal to label.');
    dist = reshape(dist, [numel(dist) 1]);
    label = reshape(label, [numel(label) 1]);
%     dist = abs(dist);
    tl = dist(find(label==1));
    fl = dist(find(label==0));
    minl = min(dist);
    maxl = max(dist);
    step = 1000;
    parfor i = 1 : step
        thresh(i) = minl+(maxl-minl)/step*i;
        tpr(i) = sum(tl>=thresh(i))/numel(tl);
        fpr(i) = sum(fl>=thresh(i))/numel(fl);
    end
    AOC = -trapz(fpr, tpr);
end