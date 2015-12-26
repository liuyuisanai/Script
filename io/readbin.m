function data = readbin(filename, size, precision)
    fid = fopen(filename, 'rb');
    data = fread(fid, Inf, precision);
    fclose(fid);
    switch precision
        case 'single'
            data = single(reshape(data, size));
        case 'double'
            data = double(reshape(data, size));
        case 'uint8'
            data = uint8(reshape(data, size));
    end
end