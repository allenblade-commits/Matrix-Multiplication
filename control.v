module control #(parameter N = 10) (
    input wire clk,                        // Clock input for synchronization
    input wire rst,                        // Reset input to initialize the module
    input wire start,                      // Start signal to initiate matrix multiplication
    input wire done_datapath,              // Signal from datapath indicating computation is complete
    output reg load_A_B,                   // Control signal to load matrices A and B
    output reg start_mul,                  // Control signal to start matrix multiplication
    output reg done_mul,                   // Control signal to indicate multiplication is finished
    output reg [2:0] current_state        // Control state machine output
);

    // State encoding for sequential input loading and multiplication
    parameter IDLE   = 3'b000;
    parameter LOAD_A = 3'b001;
    parameter LOAD_B = 3'b010;
    parameter CALC   = 3'b100;

    reg [2:0] next_state;                 // Next state signal for state transition

    // Sequential block for state transitions
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;        // Reset state to IDLE on reset
        end else begin
            current_state <= next_state;  // Transition to the next state
        end
    end

    // Combinational block for next state logic and control signal assignments
    always @(*) begin
        // Default control signal values
        load_A_B = 0;                      // Initially, load_A_B is 0
        start_mul = 0;                     // Initially, multiplication is not started
        done_mul = 0;                      // Initially, done_mul is 0

        case (current_state)
            IDLE: begin
                if (start) begin
                    next_state = LOAD_A;   // If start signal is asserted, begin loading A
                end else begin
                    next_state = IDLE;     // Stay in IDLE if no start signal
                end
            end
            LOAD_A: begin
                load_A_B = 1;             // Assert load_A_B to load matrix A
                next_state = LOAD_B;      // After loading A, transition to loading B
            end
            LOAD_B: begin
                load_A_B = 1;             // Assert load_A_B to load matrix B
                next_state = CALC;        // After loading B, transition to calculation state
            end
            CALC: begin
                start_mul = 1;            // Assert start_mul to begin matrix multiplication
                if (done_datapath) begin
                    next_state = IDLE;    // After computation, return to IDLE state
                    done_mul = 1;         // Indicate that multiplication is complete
                end else begin
                    next_state = CALC;    // Stay in CALC until multiplication is done
                end
            end
            default: begin
                next_state = IDLE;        // Default state is IDLE
            end
        endcase
    end
endmodule
