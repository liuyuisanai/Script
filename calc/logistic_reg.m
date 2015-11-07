function theta = logistic_reg( x1, x0 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    num1 = numel(x1);
    num0 = numel(x0);
    t = min(num1, num0);
    rand('state', sum(clock));
    x1 = x1(randperm(num1, t));
    x0 = x0(randperm(num0, t));
    theta = glmfit(double([x1;x0]), [[ones(numel(x1),1);zeros(numel(x0),1)] ones(2*t,1)], 'binomial', 'link', 'logit')

end

