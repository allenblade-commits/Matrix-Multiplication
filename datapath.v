module datapath #(parameter N = 10) (
    input wire clk,                        // Clock input for synchronization
    input wire rst,                        // Reset input to initialize the module
    input wire start,                      // Start signal to initiate matrix multiplication
    input wire [N-1:0] A11, A12, A21, A22,  // Matrix A elements (2x2)
    input wire [N-1:0] B11, B12, B21, B22,  // Matrix B elements (2x2)
    output reg [2*N-1:0] C11, C12, C21, C22, // Result matrix C elements (2x2)
    output reg done                        // Output signal indicating completion of multiplication
);

    // Sequential block for handling matrix multiplication and output assignment
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset outputs to 0 on reset signal
            C11 <= 0; C12 <= 0; 
            C21 <= 0; C22 <= 0;
            done <= 0;                      // Clear done signal on reset
        end else if (start) begin
            // Sequentially load matrix A and B elements and then compute multiplication
                    // Load A11, A12
                    C11 <= A11; 
                    C12 <= A12; 
                    // Load A21, A22
                    C21 <= A21; 
                    C22 <= A22; 
                    // Load B11, B12
                    C11 <= B11; 
                    C12 <= B12; 
                    // Load B21, B22
                    C21 <= B21; 
                    C22 <= B22;
                    // Perform matrix multiplication after loading A and B
                   
		    C11 <= (A11 * B11) + (A12 * B21); // C11 calculation
                    C12 <= (A11 * B12) + (A12 * B22); // C12 calculation
                    C21 <= (A21 * B11) + (A22 * B21); // C21 calculation
                    C22 <= (A21 * B12) + (A22 * B22); // C22 calculation
                    done <= 1;                      // Indicate that the multiplication is complete
        end else begin
            done <= 0;                          // Clear done signal if not starting
        end
    end
endmodule
