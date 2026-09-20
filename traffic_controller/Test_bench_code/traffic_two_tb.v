module traffic_two_tb;

reg clk, rst, emer_ew, emer_ns;
reg [3:0] density_ew, density_ns;

wire red_ew, green_ew, yellow_ew;
wire red_ns, green_ns, yellow_ns;
wire ped_ew, ped_ns;

traffic_two dut(
    .clk(clk),
    .rst(rst),
    .emer_ew(emer_ew),
    .emer_ns(emer_ns),
    .density_ew(density_ew),
    .density_ns(density_ns),
    .red_ew(red_ew),
    .green_ew(green_ew),
    .yellow_ew(yellow_ew),
    .red_ns(red_ns),
    .green_ns(green_ns),
    .yellow_ns(yellow_ns),
    .ped_ew(ped_ew),
    .ped_ns(ped_ns)
);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    emer_ew = 0;
    emer_ns = 0;
    density_ew = 4'd0;
    density_ns = 4'd0;

    #20
    rst = 0;

    #20
    density_ew = 4'd12;
    density_ns = 4'd3;

    #50
    density_ew = 4'd4;
    density_ns = 4'd12;

    #50
    density_ew = 4'd10;
    density_ns = 4'd5;

    #25
    emer_ew = 1;

    #75
    emer_ew = 0;

    #50
    density_ew = 4'd2;
    density_ns = 4'd14;

    #50
    emer_ns = 1;

    #75
    emer_ns = 0;

    #50
    density_ew = 4'd15;
    density_ns = 4'd2;

    #50
    emer_ew = 1;

    #50
    emer_ew = 0;

    #100
    $finish;

end

endmodule