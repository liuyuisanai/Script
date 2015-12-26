function writebin(data, name)
    fid = fopen(name, 'wb');
    fwrite(fid, data);
    fclose(fid);
end