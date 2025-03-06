module top_module #(parameter N = 10) (
    input wire clk,                        // Clock input for synchronization
    input wire rst,                        // Reset input to initialize the module
    input wire start,                      // Start signal to initiate matrix multiplication
    input wire [N-1:0] A11, A12, A21, A22,  // Matrix A elements (2x2)
    input wire [N-1:0] B11, B12, B21, B22,  // Matrix B elements (2x2)
    output wire [2*N-1:0] C11, C12, C21, C22, // Result matrix C elements (2x2)
    output wire done                       // Final done signal indicating completion
);
    wire load_A_B, start_mul, done_datapath; // Internal control signals for communication
    wire [2:0] current_state;                // Current state for debugging or monitoring

    // Instantiate the datapath module
    datapath #(N) dp (
        .clk(clk),                         // Connect clock signal to datapath
        .rst(rst),                         // Connect reset signal to datapath
        .start(start_mul),                 // Connect start signal for multiplication
        .A11(A11), .A12(A12),              // Connect A matrix elements to datapath
        .A21(A21), .A22(A22),
        .B11(B11), .B12(B12),              // Connect B matrix elements to datapath
        .B21(B21), .B22(B22),
        .C11(C11), .C12(C12),              // Connect output C matrix elements from datapath
        .C21(C21), .C22(C22),
        .done(done_datapath)              // Connect done signal from datapath to control
    );

    // Instantiate the control module
    control #(N) ctrl (
        .clk(clk),                         // Connect clock signal to control unit
        .rst(rst),                         // Connect reset signal to control unit
        .start(start),                     // Connect start signal to control unit
        .done_datapath(done_datapath),    // Connect done signal from datapath to control unit
        .load_A_B(load_A_B),               // Output signal to load A and B matrices
        .start_mul(start_mul),             // Output signal to start matrix multiplication
        .done_mul(done),                   // Connect done signal from control unit to top module's output
        .current_state(current_state)      // For debugging purposes
    );

endmodule
