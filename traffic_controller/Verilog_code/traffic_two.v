module traffic_two(
    input clk,
    input rst,
    input emer_ew,
    input emer_ns,
    input [3:0] density_ew,
    input [3:0] density_ns,
    output reg red_ew,
    output reg green_ew,
    output reg yellow_ew,
    output reg red_ns,
    output reg green_ns,
    output reg yellow_ns,
    output reg ped_ew,
    output reg ped_ns
);

parameter RED_EW    = 3'b000;
parameter GREEN_EW  = 3'b001;
parameter YELLOW_EW = 3'b010;
parameter RED_NS    = 3'b011;
parameter GREEN_NS  = 3'b100;
parameter YELLOW_NS = 3'b101;

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge rst)
begin
    if (rst)
        state <= RED_EW;
    else
        state <= next_state;
end

always @(*)
begin
    next_state = state;

    case(state)

        RED_EW:
        begin
            if (emer_ew)
                next_state = GREEN_EW;
            else if (emer_ns)
                next_state = GREEN_NS;
            else if (density_ew > density_ns)
                next_state = GREEN_EW;
            else
                next_state = GREEN_EW;
        end

        GREEN_EW:
        begin
            if (emer_ns)
                next_state = GREEN_NS;
            else if (emer_ew)
                next_state = GREEN_EW;
            else if (density_ns > density_ew)
                next_state = YELLOW_EW;
            else
                next_state = YELLOW_EW;
        end

        YELLOW_EW:
        begin
            if (emer_ew)
                next_state = GREEN_EW;
            else if (emer_ns)
                next_state = GREEN_NS;
            else
                next_state = RED_NS;
        end

        RED_NS:
        begin
            if (emer_ns)
                next_state = GREEN_NS;
            else if (emer_ew)
                next_state = GREEN_EW;
            else if (density_ns > density_ew)
                next_state = GREEN_NS;
            else
                next_state = GREEN_EW;
        end

        GREEN_NS:
        begin
            if (emer_ew)
                next_state = GREEN_EW;
            else if (emer_ns)
                next_state = GREEN_NS;
            else if (density_ew > density_ns)
                next_state = YELLOW_NS;
            else
                next_state = YELLOW_NS;
        end

        YELLOW_NS:
        begin
            if (emer_ew)
                next_state = GREEN_EW;
            else if (emer_ns)
                next_state = GREEN_NS;
            else
                next_state = RED_EW;
        end

        default:
            next_state = RED_EW;

    endcase
end

always @(*)
begin
    red_ew    = 1'b0;
    green_ew  = 1'b0;
    yellow_ew = 1'b0;
    red_ns    = 1'b0;
    green_ns  = 1'b0;
    yellow_ns = 1'b0;
    ped_ew    = 1'b0;
    ped_ns    = 1'b0;

    case(state)

        RED_EW:
        begin
            red_ew   = 1'b1;
            green_ns = 1'b1;
            ped_ew   = 1'b1;
        end

        GREEN_EW:
        begin
            green_ew = 1'b1;
            red_ns   = 1'b1;
            ped_ns   = 1'b1;
        end

        YELLOW_EW:
        begin
            yellow_ew = 1'b1;
            red_ns    = 1'b1;
        end

        RED_NS:
        begin
            red_ns   = 1'b1;
            green_ew = 1'b1;
            ped_ns   = 1'b1;
        end

        GREEN_NS:
        begin
            green_ns = 1'b1;
            red_ew   = 1'b1;
            ped_ew   = 1'b1;
        end

        YELLOW_NS:
        begin
            yellow_ns = 1'b1;
            red_ew    = 1'b1;
        end

        default:
        begin
            red_ew = 1'b1;
        end

    endcase
end

endmodule