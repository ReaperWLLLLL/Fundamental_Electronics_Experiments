% 设置参数
width = 24; % 每个数据元素的位宽为24位
depth = 256; % 存储器的深度，即数据元素的数量为256个
%phase = 0;        % 相位初始为0，这里被注释掉
phase = 0; % 相位设置为0，即90度

% 打开文件并写入文件头信息
fid = fopen('sin_phase0_24bit_harmony.mif', 'w');
fprintf(fid, 'WIDTH=%d;\n', width);
fprintf(fid, 'DEPTH=%d;\n', depth);
fprintf(fid, 'ADDRESS_RADIX=DEC;\n');
fprintf(fid, 'DATA_RADIX=HEX;\n');
fprintf(fid, 'CONTENT BEGIN\n');

% 循环生成24位正弦波数据并写入文件
for i = 0:depth - 1
    sin_data_base = floor((sin(2 * pi * i / depth + phase)) * 0.5 * (2 ^ (width -1) -1)); 
    sin_data_third = floor((sin(2 * pi * 3 * i / depth + phase)) * 0.3 * (2 ^ (width -1) -1)); 
    sin_data = sin_data_base + sin_data_third; 
    if (sin_data < 0)
        sin_data = 2 ^ width + sin_data; 
    end
    fprintf(fid, '%d:%x;\n', i, sin_data);
end

% 写入文件尾部信息并关闭文件
fprintf(fid, 'END ;\n');
fclose(fid);
