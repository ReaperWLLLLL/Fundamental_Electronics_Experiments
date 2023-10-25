 module task2 (
    //设置八个输入端口
    input [7:0] a,
    output [7:0] b
);
    //设置八个输出端口
    assign b[0] = ~a[0];
    assign b[1] = ~a[1];
    assign b[2] = ~a[2];
    assign b[3] = ~a[3];
    assign b[4] = ~a[4];
    assign b[5] = ~a[5];
    assign b[6] = ~a[6];
    assign b[7] = ~a[7];
    
endmodule