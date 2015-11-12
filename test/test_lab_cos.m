% addpath('../')
% model_name_base = 'stage1_equal_cls/stage2_iter179000';
% % for j = 1 : 1
%     clear mex;
%     n_gpu = 2;
%     batch_per_gpu = 64;
%     DNN_bn.caffe('set_device_solver', 0:(n_gpu-1));
%     DNN_bn.caffe('init_solver', 'solver_20w25w.prototxt', ['snapshot/' model_name_base], 'log\');
%     addpath('E:\research\code\MSRAcodes\JointBayesianCode');
%     tic
    fprintf('Generating feature...');
        feature = get_feature( data_lab, meanmat, batch_per_gpu, n_gpu, 128, 'fc128', 1 );
    fprintf('Done!\n');
    toc
    tic
    fprintf('Geting cos distance...');
        featnorm = bsxfun(@rdivide, feature, arrayfun(@(x) norm(feature(x,:)), 1:size(feature,1))');
        cosdist = featnorm*featnorm'-2*eye(size(feature,1));
    fprintf('Done!\n');
    toc
    tic
    fprintf('Testing...');
        score.intra = arrayfun(@(x)cosdist(pairlist_lab.IntraPersonPair(x,1), pairlist_lab.IntraPersonPair(x,2)), 1:768);
        score.extra = arrayfun(@(x)cosdist(pairlist_lab.ExtraPersonPair(x,1), pairlist_lab.ExtraPersonPair(x,2)), 1:11760);
    fprintf('Done!\n');
    toc
    tscore = score.intra;
    fscore = score.extra;
    l = min(fscore);
    r = max(fscore);
    step = (r-l)/1000;
    itert = 1;
    for thre =  l+step : step:r-step
        tl=numel(find(tscore > thre));
        fl=numel(find(fscore > thre));
        tpr(itert) = tl/numel(tscore);
        fpr(itert) = fl/numel(fscore);
        itert = itert + 1;
    end
    figure(4)
    plot(fpr,tpr,'b','DisplayName',num2str(i))
    hold on
    ROC = abs(trapz(fpr, tpr));
%     ROC(j) = abs(trapz(fpr, tpr));
%     figure(2)
%     plot(ROC);
% end

