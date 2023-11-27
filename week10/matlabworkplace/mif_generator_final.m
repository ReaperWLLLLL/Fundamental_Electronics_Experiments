% a generator produce 3 waves
width = 8;
depth = 768;

fid = fopen('final_waveforms.mif', 'w');
fprintf(fid, 'WIDTH=%d;\n', width);
fprintf(fid, 'DEPTH=%d;\n', depth);
fprintf(fid, 'ADDRESS_RADIX=DEC;\n');
fprintf(fid, 'DATA_RADIX=DEC;\n');
fprintf(fid, 'CONTENT BEGIN\n');

for i = 0:depth-1
    if i < depth/3
        sin_data = floor((sin(2*pi*i/(depth/3)) + 1) * 0.5 * (2^width - 1));
        fprintf(fid, '%d:%d;\n', i, sin_data);
    elseif i < 2*depth/3
        triangle_data = abs(floor((2 * abs(mod(i, (2 * (depth / 3))) - (depth / 3)) / (depth / 3) - 1) * (2 ^ width - 1)));
        fprintf(fid, '%d:%d;\n', i, triangle_data);
    else
        square_data = floor(((mod(i, depth/3) < depth/6) * (2^width - 1)));
        fprintf(fid, '%d:%d;\n', i, square_data);
    end
end

fprintf(fid, 'END ;\n');
fclose(fid);
