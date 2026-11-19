`timescale 1ns / 1ps

module railway_controller #(
    parameter GATE_TIMER_MAX = 4
)(
    input wire clk,
    input wire rst,                 // Synchronous, active-high reset
    input wire train_arrival,       // Train approaching the crossing
    input wire train_departure,     // Train has cleared the crossing
    
    output reg [1:0] gate_status,   // 00: open, 01: closing, 10: closed, 11: opening
    output reg road_signal,         // 0: green, 1: red
    output reg warning_alarm        // 0: off, 1: on
);

    localparam IDLE          = 2'b00;
    localparam GATE_CLOSING  = 2'b01;
    localparam TRAIN_PASSING = 2'b10;
    localparam GATE_OPENING  = 2'b11;

    reg [1:0] current_state, next_state;
    reg [3:0] timer;

    // Update the state and timer on each clock edge
    always @(posedge clk) begin
        if (rst) begin
            current_state <= IDLE;
            timer <= 0;
        end else begin
            current_state <= next_state;
            
            if (current_state == GATE_CLOSING || current_state == GATE_OPENING) begin
                if (current_state != next_state) begin
                    timer <= 0; 
                end else begin
                    timer <= timer + 1;
                end
            end else begin
                timer <= 0;
            end
        end
    end

    // Choose the next state from the current state and sensor inputs
    always @(*) begin
        next_state = current_state; // Stay in this state unless a transition applies
        
        case (current_state)
            IDLE: begin
                if (train_arrival)
                    next_state = GATE_CLOSING;
            end
            
            GATE_CLOSING: begin
                // Finish closing before allowing the train to pass.
                if (timer >= GATE_TIMER_MAX)
                    next_state = TRAIN_PASSING;
            end
            
            TRAIN_PASSING: begin
                if (train_departure)
                    next_state = GATE_OPENING;
            end
            
            GATE_OPENING: begin
                // A new train is approaching, so close the gate again.
                if (train_arrival) 
                    next_state = GATE_CLOSING;
                else if (timer >= GATE_TIMER_MAX)
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

    // Set the signals for the current state
    always @(*) begin
        gate_status   = 2'b00; 
        road_signal   = 1'b1;  // Keep the road signal red by default
        warning_alarm = 1'b0;  
        
        case (current_state)
            IDLE: begin
                gate_status   = 2'b00;
                road_signal   = 1'b0;
                warning_alarm = 1'b0;
            end
            
            GATE_CLOSING: begin
                gate_status   = 2'b01;
                road_signal   = 1'b1;
                warning_alarm = 1'b1;
            end
            
            TRAIN_PASSING: begin
                gate_status   = 2'b10;
                road_signal   = 1'b1;
                warning_alarm = 1'b1;
            end
            
            GATE_OPENING: begin
                gate_status   = 2'b11;
                road_signal   = 1'b1;
                warning_alarm = 1'b0;
            end
        endcase
    end
endmodule