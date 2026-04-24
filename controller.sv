module controller(
    input  logic        clk,
    input  logic        reset,
    input  logic [6:0]  op,
    input  logic [2:0]  funct3,
    input  logic        funct7b5,
    input  logic        zero,
    output logic [1:0]  immsrc,
    output logic [1:0]  alusrca, alusrcb,
    output logic [1:0]  resultsrc,
    output logic        adrsrc,
    output logic [2:0]  alucontrol,
    output logic        irwrite, pcwrite,
    output logic        regwrite, memwrite
);

    logic [1:0] aluop;
    logic       branch, pcupdate;

    // Main FSM 
    mainfsm fsm(
        .clk        (clk),
        .reset      (reset),
        .op         (op),
        .zero       (zero),
        .alusrca    (alusrca),
        .alusrcb    (alusrcb),
        .resultsrc  (resultsrc),
        .adrsrc     (adrsrc),
        .aluop      (aluop),
        .irwrite    (irwrite),
        .pcwrite    (pcwrite),
        .regwrite   (regwrite),
        .memwrite   (memwrite),
        .branch     (branch),
        .pcupdate   (pcupdate)
    );

    // ALU Decoder 
    aludec ad(
        .opb5       (op[5]),
        .funct3     (funct3),
        .funct7b5   (funct7b5),
        .ALUOp      (aluop),
        .ALUControl (alucontrol)
    );

    // Instruction Decoder 
    instrdec id(
        .op     (op),
        .ImmSrc (immsrc)
    );

endmodule