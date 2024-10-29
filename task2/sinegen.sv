module sinegen #(
    parameter A_WIDTH = 8,
              D_WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [D_WIDTH-1:0] incr,     // increment for counter addr
    input logic [D_WIDTH-1:0] phase,
    output logic [D_WIDTH-1:0] dout1,
    output logic [D_WIDTH-1:0] dout2
);

    logic [A_WIDTH-1:0] address1;
    logic [A_WIDTH-1:0] address2;

counter addrCounter(
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .count (address1)
);

always_comb begin
    address2 = address1 + phase;    // offset address 2 by phase
end

rom2ports sineRom(
    .clk (clk),
    .addr1 (address1),
    .dout1 (dout1),
    .addr2 (address2),
    .dout2 (dout2)
);

endmodule

