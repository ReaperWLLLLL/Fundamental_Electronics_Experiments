width = 8;
depth = 256;
%phase = 0;
phase = pi/2;
fid = fopen('sin_phase90.mif','w');
fprintf(fid,'WIDTH=8;\n',width);
fprintf(fid,'DEPTH=256;\n',depth);
fprintf(fid,'ADDRESS_RADIX=DEC;\n');
fprintf(fid,'DATA_RADIX=DEC;\n');
fprintf(fid,'CONTENT BEGIN\n');
for i=0:depth-1
  sin_data = floor((sin(2*pi*i/depth + phase) + 1) * 0.5 * (2^width - 1));
  fprintf(fid,'%d:%d;\n',i,sin_data);%10进制  
end
fprintf(fid,'END ;\n');
fclose(fid);