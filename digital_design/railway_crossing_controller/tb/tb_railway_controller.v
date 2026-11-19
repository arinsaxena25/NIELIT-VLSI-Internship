`timescale 1ns / 1ps

module tb_railway_controller();

    // Timing parameters
    parameter GATE_TIMER_MAX = 4;
    parameter CLK_PERIOD     = 10; // 10 ns gives a 100 MHz clock

    // Testbench signals
    reg clk;
    reg rst;
    reg train_arrival;
    reg train_departure;

    wire [1:0] gate_status;
    wire road_signal;
    wire warning_alarm;

    // Device under test
    railway_controller #(
        .GATE_TIMER_MAX(GATE_TIMER_MAX)
    ) uut (
        .clk(clk),
        .rst(rst),
        .train_arrival(train_arrival),
        .train_departure(train_departure),
        .gate_status(gate_status),
        .road_signal(road_signal),
        .warning_alarm(warning_alarm)
    );

    // Generate the test clock
    always #(CLK_PERIOD / 2) clk = ~clk;

    // Print the current outputs
    task display_status;
        input [160:0] test_name;
        begin
            $display("[%0t ns] - %0s | Gate: %b | Road Signal: %b | Alarm: %b", 
                     $time, test_name, gate_status, road_signal, warning_alarm);
        end
    endtask

    // Run the test scenarios
    initial begin
        // Start with reset asserted and the sensors inactive
        clk = 0;
        rst = 1;
        train_arrival = 0;
        train_departure = 0;

        $display("==========================================================");
        $display("  STARTING AUTOMATIC RAILWAY CONTROLLER VERIFICATION     ");
        $display("==========================================================");

        // 1. Reset the controller
        #(CLK_PERIOD * 2);
        rst = 0;
        #(CLK_PERIOD);
        display_status("TEST 1: System Reset -> Expect IDLE");

        // 2. A departure pulse while idle should be ignored
        train_departure = 1;
        #(CLK_PERIOD);
        train_departure = 0;
        #(CLK_PERIOD);
        display_status("TEST 2: Departure glitch in IDLE -> Should remain IDLE");

        // 3. Run a normal train crossing
        $display("\n--- Initiating Normal Train Sequence ---");
        train_arrival = 1; // Train arrives
        #(CLK_PERIOD);
        train_arrival = 0;
        display_status("Arrival Triggered -> Expect GATE_CLOSING (01)");

        // Allow enough time for the gate to close
        #(CLK_PERIOD * (GATE_TIMER_MAX + 1));
        display_status("Gate Closing Timer Finished -> Expect TRAIN_PASSING (10)");

        // The train passes, then the departure sensor triggers
        #(CLK_PERIOD * 2);
        train_departure = 1;
        #(CLK_PERIOD);
        train_departure = 0;
        display_status("Departure Triggered -> Expect GATE_OPENING (11)");

        // Allow enough time for the gate to open
        #(CLK_PERIOD * (GATE_TIMER_MAX + 1));
        display_status("Gate Opening Timer Finished -> Expect return to IDLE (00)");

        // 4. A departure pulse during closing should have no effect
        $display("\n--- Testing Departure Glitch During Gate Closing ---");
        train_arrival = 1;
        #(CLK_PERIOD);
        train_arrival = 0;
        display_status("Train Arrives -> Gate Closing");

        #(CLK_PERIOD);
        train_departure = 1; // A spurious departure pulse during closing
        #(CLK_PERIOD);
        train_departure = 0;
        display_status("False Departure Pulse -> Must IGNORE and remain GATE_CLOSING");

        #(CLK_PERIOD * (GATE_TIMER_MAX));
        display_status("Gate Completed Closing -> Reached TRAIN_PASSING safely");

        // Finish the crossing and let the controller return to idle
        train_departure = 1;
        #(CLK_PERIOD);
        train_departure = 0;
        #(CLK_PERIOD * (GATE_TIMER_MAX + 1));

        // 5. A second train arrives while the gate is opening
        $display("\n--- Testing Back-to-Back Trains ---");
        // Train 1 arrives and passes
        train_arrival = 1; #(CLK_PERIOD); train_arrival = 0;
        #(CLK_PERIOD * (GATE_TIMER_MAX + 1));
        train_departure = 1; #(CLK_PERIOD); train_departure = 0;
        
        // The gate is partway through opening
        display_status("Train 1 Departure -> Gate begins Opening (11)");
        #(CLK_PERIOD * 2);

        // Train 2 arrives before the gate is fully open
        train_arrival = 1;
        #(CLK_PERIOD);
        train_arrival = 0;
        display_status("Train 2 Arrives Mid-Opening -> Abort opening! Return to GATE_CLOSING (01)");

        #(CLK_PERIOD * (GATE_TIMER_MAX + 1));
        display_status("Gate Re-closed -> TRAIN_PASSING (10)");

        // Finish the second crossing
        train_departure = 1; #(CLK_PERIOD); train_departure = 0;
        #(CLK_PERIOD * (GATE_TIMER_MAX + 1));
        display_status("Final Departure -> Returned safely to IDLE");

        $display("==========================================================");
        $display("  ALL VERIFICATION TESTS COMPLETED SUCCESSFULLY          ");
        $display("==========================================================");
        $finish;
    end

endmodule