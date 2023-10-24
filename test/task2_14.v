module task2_14(input panic ,enable, exiting, window, door, garage, 
                output alarm
                );
    wire secure, notsecure, notexiting, otheralarm;
    or U1(alarm, oanic, otheralarm);
    and U2(otheralarm, enable, notexiting, notsecure);
    not U3(notexiting, exiting);
    not U4(notsecure, secure);
    and U5(secure, window, door, garage);
endmodule
