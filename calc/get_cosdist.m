function cosdist = get_cosdist( feature, refid, testid )
        featnorm = bsxfun(@rdivide, feature, arrayfun(@(x) norm(feature(x,:)), 1:size(feature,1))');
        cosdist = featnorm*featnorm';
    if nargin < 2
        return;
    else
        cosdist(refid,:)=[];
        cosdist(:,testid) = [];
    end
end

