module tb_matrix_multiplication;

    // Parameterized width
    parameter N = 10;

    // Inputs
    reg clk;                              // Clock signal for the testbench
    reg rst;                              // Reset signal for the testbench
    reg start;                            // Start signal to initiate matrix multiplication
    reg [N-1:0] A11, A12, A21, A22;        // Matrix A elements (2x2)
    reg [N-1:0] B11, B12, B21, B22;        // Matrix B elements (2x2)

    // Outputs
    wire [2*N-1:0] C11, C12, C21, C22;     // Result matrix C elements (2x2)
    wire done;                           // Signal indicating completion of multiplication

    // Instantiate the top module
    top_module #(N) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A11(A11), .A12(A12), .A21(A21), .A22(A22),
        .B11(B11), .B12(B12), .B21(B21), .B22(B22),
        .C11(C11), .C12(C12), .C21(C21), .C22(C22),
        .done(done)                     // Connection to the done output from top module
    );

    // Clock generation process
    always begin
        #5 clk = ~clk;                  // Toggle clock every 5 time units
    end

    initial begin
        // Initialize inputs
        clk = 0;                        // Initialize clock
        rst = 1;                        // Assert reset
        start = 0;                      // Initialize start signal
        A11 = 0; A12 = 0; A21 = 0; A22 = 0; // Initialize Matrix A elements
        B11 = 0; B12 = 0; B21 = 0; B22 = 0; // Initialize Matrix B elements

        // Reset the system
        #10 rst = 0;                    // Deassert reset after 10 time units
        
        // Sequentially load input matrices A and B

        // Load first element of matrix A
        A11 = 10'd512;
        start = 1;
        #10 start = 0;
        #10;

        // Load second element of matrix A
        A12 = 10'd1023;
        start = 1;
        #10 start = 0;
        #10;

        // Load third element of matrix A
        A21 = 10'd345;
        start = 1;
        #10 start = 0;
        #10;

        // Load fourth element of matrix A
        A22 = 10'd789;
        start = 1;
        #10 start = 0;
        #10;

        // Load first element of matrix B
        B11 = 10'd102;
        start = 1;
        #10 start = 0;
        #10;

        // Load second element of matrix B
        B12 = 10'd65;
        start = 1;
        #10 start = 0;
        #10;

        // Load third element of matrix B
        B21 = 10'd923;
        start = 1;
        #10 start = 0;
        #10;

        // Load fourth element of matrix B
        B22 = 10'd507;
        start = 1;
        #10 start = 0;
        #10;

        // Start the matrix multiplication process
        start = 1;
        #10 start = 0;
        
        // Wait for the done signal indicating multiplication completion
        wait (done == 1);

        // Display results after multiplication
        $display("Matrix A:");
        $display("%d %d", A11, A12);    // Display first row of matrix A
        $display("%d %d", A21, A22);    // Display second row of matrix A

        $display("Matrix B:");
        $display("%d %d", B11, B12);    // Display first row of matrix B
        $display("%d %d", B21, B22);    // Display second row of matrix B

        $display("Matrix C (Result):");
        $display("%d %d", C11, C12);    // Display first row of result matrix C
        $display("%d %d", C21, C22);    // Display second row of result matrix C

        // Finish simulation
        #200;                             // Wait for 20 time units
        $stop;                           // Stop the simulation
    end
endmodule
