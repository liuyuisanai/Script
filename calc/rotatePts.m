function pts = rotatePts( ptsMat, angle, center )
    assert(size(ptsMat, 2)==2, 'Points should be n*2');
    if nargin < 3
        center = [0, 0];
    end
    deltapts_0 = bsxfun(@minus, ptsMat, center);
    transformMat = [cos(angle), -sin(angle);...
                    sin(angle), cos(angle)];
    deltapts_t = deltapts_0 * transformMat;
    pts = bsxfun(@plus, deltapts_t, center);
end

