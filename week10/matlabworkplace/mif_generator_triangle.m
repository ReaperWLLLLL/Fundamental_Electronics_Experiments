width = 8;
depth = 256;
fid = fopen('triangle_wave.mif', 'w');
fprintf(fid, 'WIDTH=%d;\n', width);
fprintf(fid, 'DEPTH=%d;\n', depth);
fprintf(fid, 'ADDRESS_RADIX=DEC;\n');
fprintf(fid, 'DATA_RADIX=DEC;\n');
fprintf(fid, 'CONTENT BEGIN\n');

for i = 0:depth-1
    triangle_data = floor((abs(mod(i, (2 * (depth/2))) - (depth/2)) / (depth/2)) * (2^width - 1));
    fprintf(fid, '%d:%d;\n', i, triangle_data);
end

fprintf(fid, 'END ;\n');
fclose(fid);
