function writebin(data, name)
    fid = fopen(name, 'wb');
    fwrite(fid, data, class(data));
    fclose(fid);
end