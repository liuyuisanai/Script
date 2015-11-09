function showSigm( theta, x, y, showpts )
    if nargin < 2
        l = -1;
        r = 1;
        figure;
    else
        figure;
            plot(x, y, 'rx','MarkerSize',10);
            hold on;
        end
        l = min(x);
        r = max(x);
    end
    x_co = l:(r-l)/100:r;
    for i = 1 : size(theta,2)
        y_co = sigm(theta(:,i), x_co);
        plot(x_co, y_co);
        hold on
    end
    hold off;
end

