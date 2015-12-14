function normed = norm_data( mat, mode )
%mode: 1=max1norm, 2=L2normAll, 3=L2normRow, 4=L2normCol
    if nargin < 2
        mode = 2;
    end
    if mode == 1
        normed = bsxfun(@rdivide, mat, max(mat(:)));
    elseif mode == 2
        normed = bsxfun(@rdivide, mat, norm(mat));
    elseif mode == 3
        normed = bsxfun(@rdivide, mat, arrayfun(@(x)norm(mat(x,:)), 1:size(mat, 1))');
    elseif mode == 4
        normed = bsxfun(@rdivide, mat, arrayfun(@(x)norm(mat(:,x)), 1:size(mat, 2)));
    end
end

