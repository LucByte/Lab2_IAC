module sigdelay #(
    parameter A_WIDTH = 8,
              D_WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic en,
    input logic rd,
    input logic wr,
    input logic [D_WIDTH-1:0] offset,     // increment for counter addr
    input logic [D_WIDTH-1:0] mic_signal,
    output logic [D_WIDTH-1:0] delayed_signal
);

    logic [A_WIDTH-1:0] address;

counter addrCounter(
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (offset),
    .count (address)
);

ram2ports audioram(
    .clk (clk),
    .rd_addr (address+offset),
    .din (mic_signal),
    .wr_addr (address),
    .dout (delayed_signal),
    .rd (rd),
    .wr (wr)
);

endmodule

