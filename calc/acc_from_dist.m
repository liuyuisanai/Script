function acc = acc_from_dist( dist1, dist2, label, weight, refid, testid, taskid )
% taskid: 1-->verification 2-->identification (default)
    if nargin < 7
        taskid = 2;
    end
    if taskid == 2
        cosdist = dist1*weight(1)+dist2*weight(2);
        cosdist(refid,:)=[];
        cosdist(:,testid) = [];
        label_ref = label(refid);
        label_test = label(testid);
        [~, iter] = sort(cosdist','descend');
        iter = iter';
        predicted = arrayfun(@(x)mode(label_ref(iter(x,1))), 1:size(cosdist,1))';
        hit = sum(predicted == label_test);
        acc = hit / (size(cosdist,1));
    elseif taskid == 1
        cosdist = dist1*weight(1)+dist2*weight(2);
        issameperson = repmat(label, [1 size(label,1)])==repmat(label', [size(label,1) 1]);
        acct = zeros(1000,1);
        l = min(min(cosdist));
        r = max(max(cosdist));
        step = (r-l)/1006;
        thresh = l+2*step : step : r-2*step;
        thresh = thresh(1:1000);
        parfor i = 1 : 1000
            predicted = cosdist>=thresh(i);
            acct(i) = sum(sum(predicted==issameperson))+size(predicted,1);
        end
        acc = max(acct)/numel(issameperson);
    else
        acc = -1;
    end
end

