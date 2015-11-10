function matloc = vecloc2matloc( vecloc, dimsize )
    matdim = numel(dimsize);
    carrysum(1) = dimsize(1);
    for i = 2 : matdim
        carrysum(i) = carrysum(i-1) * dimsize(i);
    end
    for i = matdim : -1 : 2
        matloc(i) = floor((vecloc-1) / carrysum(i-1)) + 1;
        vecloc = mod(vecloc, carrysum(i-1));
    end
    matloc(1) = vecloc;
end

