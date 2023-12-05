% 设置参数
width = 16; % 每个数据元素的位宽为16位
depth = 256; % 存储器的深度，即数据元素的数量为256个
%phase = 0;        % 相位初始为0，这里被注释掉
phase = pi / 2; % 相位设置为π/2，即90度

% 打开文件并写入文件头信息
fid = fopen('sin_phase90_16bit.mif', 'w');
fprintf(fid, 'WIDTH=%d;\n', width);
fprintf(fid, 'DEPTH=%d;\n', depth);
fprintf(fid, 'ADDRESS_RADIX=DEC;\n');
fprintf(fid, 'DATA_RADIX=HEX;\n');
fprintf(fid, 'CONTENT BEGIN\n');

% 循环生成16位正弦波数据并写入文件
for i = 0:depth - 1
    sin_data = floor((sin(2 * pi * i / depth + phase) + 1) * 0.5 * (2 ^ width - 1));
    fprintf(fid, '%d:%x;\n', i, sin_data); % 以十进制格式写入文件
end

% 写入文件尾部信息并关闭文件
fprintf(fid, 'END ;\n');
fclose(fid);
