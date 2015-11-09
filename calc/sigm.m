function [ y ] = sigm( theta, x )
    y=1./(1+exp(-theta(1)-theta(2)*x));
end

