
Started : "Synthesize - XST".
Running xst...
Command Line: xst -intstyle ise -ifn "/home/pedro-surf/projeto_2/cron_dec.xst" -ofn "/home/pedro-surf/projeto_2/cron_dec.syr"
Reading design: cron_dec.prj

=========================================================================
*                          HDL Compilation                              *
=========================================================================
Compiling vhdl file "/home/pedro-surf/projeto_2/display_driver.vhd" in Library work.
Architecture dspl_drv of Entity dspl_drv is up to date.
Compiling vhdl file "/home/pedro-surf/projeto_2/pre_projeto.vhd" in Library work.
Architecture behavioral of Entity cron_dec is up to date.

=========================================================================
*                     Design Hierarchy Analysis                         *
=========================================================================
Analyzing hierarchy for entity <cron_dec> in library <work> (architecture <behavioral>) with generics.
	CLOCK_FREQ = 25000000

Analyzing hierarchy for entity <dspl_drv> in library <work> (architecture <dspl_drv>).


=========================================================================
*                            HDL Analysis                               *
=========================================================================
Analyzing generic Entity <cron_dec> in library <work> (Architecture <behavioral>).
	CLOCK_FREQ = 25000000
WARNING:Xst:819 - "/home/pedro-surf/projeto_2/pre_projeto.vhd" line 85: One or more signals are missing in the process sensitivity list. To enable synthesis of FPGA/CPLD hardware, XST will assume that all necessary signals are present in the sensitivity list. Please note that the result of the synthesis may differ from the initial design specification. The missing signals are:
   <carga>, <current_state>, <contador_seg>, <contador_min>
WARNING:Xst:790 - "/home/pedro-surf/projeto_2/pre_projeto.vhd" line 135: Index value(s) does not match array range, simulation mismatch.
WARNING:Xst:790 - "/home/pedro-surf/projeto_2/pre_projeto.vhd" line 136: Index value(s) does not match array range, simulation mismatch.
WARNING:Xst:753 - "/home/pedro-surf/projeto_2/pre_projeto.vhd" line 144: Unconnected output port 'an' of component 'dspl_drv'.
WARNING:Xst:753 - "/home/pedro-surf/projeto_2/pre_projeto.vhd" line 144: Unconnected output port 'dec_ddp' of component 'dspl_drv'.
Entity <cron_dec> analyzed. Unit <cron_dec> generated.

Analyzing Entity <dspl_drv> in library <work> (Architecture <dspl_drv>).
Entity <dspl_drv> analyzed. Unit <dspl_drv> generated.


=========================================================================
*                           HDL Synthesis                               *
=========================================================================

Performing bidirectional port resolution...

Synthesizing Unit <dspl_drv>.
    Related source file is "/home/pedro-surf/projeto_2/display_driver.vhd".
    Found 16x7-bit ROM for signal <selected_dig_4_1$rom0000>.
    Found 4-bit register for signal <an>.
    Found 4-bit 4-to-1 multiplexer for signal <an$mux0003>.
    Found 1-bit register for signal <ck_1KHz>.
    Found 15-bit adder for signal <ck_1KHz$addsub0000> created at line 75.
    Found 15-bit up counter for signal <count_25K>.
    Found 2-bit register for signal <dig_selection>.
    Found 5-bit register for signal <selected_dig>.
    Found 5-bit 4-to-1 multiplexer for signal <selected_dig$mux0003>.
    Summary:
	inferred   1 ROM(s).
	inferred   1 Counter(s).
	inferred  12 D-type flip-flop(s).
	inferred   1 Adder/Subtractor(s).
	inferred   9 Multiplexer(s).
Unit <dspl_drv> synthesized.


Synthesizing Unit <cron_dec>.
    Related source file is "/home/pedro-surf/projeto_2/pre_projeto.vhd".
WARNING:Xst:647 - Input <an> is never used. This port will be preserved and left unconnected if it belongs to a top-level block or it belongs to a sub-block and the hierarchy of this sub-block is preserved.
WARNING:Xst:647 - Input <conta> is never used. This port will be preserved and left unconnected if it belongs to a top-level block or it belongs to a sub-block and the hierarchy of this sub-block is preserved.
WARNING:Xst:647 - Input <dec_ddp> is never used. This port will be preserved and left unconnected if it belongs to a top-level block or it belongs to a sub-block and the hierarchy of this sub-block is preserved.
WARNING:Xst:646 - Signal <Segundos_BCD<7>> is assigned but never used. This unconnected signal will be trimmed during the optimization process.
    Found 100x8-bit ROM for signal <Segundos_BCD$rom0000> created at line 135.
    Found 100x8-bit ROM for signal <Minutos_BCD$rom0000> created at line 136.
    Using one-hot encoding for signal <current_state>.
WARNING:Xst:737 - Found 3-bit latch for signal <next_state>. Latches may be generated from incomplete case or if statements. We do not recommend the use of latches in FPGA/CPLD designs, as they may lead to timing problems.
INFO:Xst:2371 - HDL ADVISOR - Logic functions respectively driving the data and gate enable inputs of this latch share common terms. This situation will potentially lead to setup/hold violations and, as a result, to simulation problems. This situation may come from an incomplete case statement (all selector values are not covered). You should carefully review if it was in your intentions to describe such a latch.
    Found 1-bit register for signal <clock_1seg>.
    Found 7-bit down counter for signal <contador_min>.
    Found 8-bit register for signal <contador_seg>.
    Found 8-bit subtractor for signal <contador_seg$addsub0000> created at line 111.
    Found 9-bit comparator greater for signal <contador_seg$cmp_gt0000> created at line 110.
    Found 8-bit comparator greater for signal <contador_seg$cmp_gt0001> created at line 111.
    Found 25-bit up counter for signal <count_25K>.
    Found 3-bit register for signal <current_state>.
    Summary:
	inferred   2 ROM(s).
	inferred   2 Counter(s).
	inferred   9 D-type flip-flop(s).
	inferred   1 Adder/Subtractor(s).
	inferred   2 Comparator(s).
Unit <cron_dec> synthesized.


=========================================================================
HDL Synthesis Report

Macro Statistics
# ROMs                                                 : 3
 100x8-bit ROM                                         : 2
 16x7-bit ROM                                          : 1
# Adders/Subtractors                                   : 2
 15-bit adder                                          : 1
 8-bit subtractor                                      : 1
# Counters                                             : 3
 15-bit up counter                                     : 1
 25-bit up counter                                     : 1
 7-bit down counter                                    : 1
# Registers                                            : 7
 1-bit register                                        : 2
 2-bit register                                        : 1
 3-bit register                                        : 1
 4-bit register                                        : 1
 5-bit register                                        : 1
 8-bit register                                        : 1
# Latches                                              : 1
 3-bit latch                                           : 1
# Comparators                                          : 2
 8-bit comparator greater                              : 1
 9-bit comparator greater                              : 1
# Multiplexers                                         : 2
 4-bit 4-to-1 multiplexer                              : 1
 5-bit 4-to-1 multiplexer                              : 1

=========================================================================

=========================================================================
*                       Advanced HDL Synthesis                          *
=========================================================================

WARNING:Xst:1290 - Hierarchical block <display_driver> is unconnected in block <cron_dec>.
   It will be removed from the design.

Synthesizing (advanced) Unit <dspl_drv>.
INFO:Xst:3034 - In order to maximize performance and save block RAM resources, the small ROM <Mrom_selected_dig_4_1_rom0000> will be implemented on LUT. If you want to force its implementation on block, use option/constraint rom_style.
Unit <dspl_drv> synthesized (advanced).

=========================================================================
Advanced HDL Synthesis Report

Macro Statistics
# ROMs                                                 : 3
 100x8-bit ROM                                         : 2
 16x7-bit ROM                                          : 1
# Adders/Subtractors                                   : 2
 15-bit adder                                          : 1
 8-bit subtractor                                      : 1
# Counters                                             : 3
 15-bit up counter                                     : 1
 25-bit up counter                                     : 1
 7-bit down counter                                    : 1
# Registers                                            : 24
 Flip-Flops                                            : 24
# Latches                                              : 1
 3-bit latch                                           : 1
# Comparators                                          : 2
 8-bit comparator greater                              : 1
 9-bit comparator greater                              : 1
# Multiplexers                                         : 2
 4-bit 4-to-1 multiplexer                              : 1
 5-bit 4-to-1 multiplexer                              : 1

=========================================================================

=========================================================================
*                         Low Level Synthesis                           *
=========================================================================
WARNING:Xst:1710 - FF/Latch <selected_dig_0> (without init value) has a constant value of 1 in block <dspl_drv>. This FF/Latch will be trimmed during the optimization process.

Optimizing unit <cron_dec> ...

Optimizing unit <dspl_drv> ...
WARNING:Xst:2677 - Node <clock_1seg> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_seg_0> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_seg_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_seg_2> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_seg_3> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_seg_4> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_seg_5> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_seg_6> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_seg_7> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <next_state_0> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <next_state_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <next_state_2> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <current_state_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <current_state_0> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <current_state_2> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_min_0> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_min_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_min_2> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_min_3> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_min_4> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_min_5> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <contador_min_6> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_0> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_2> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_3> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_4> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_5> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_6> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_7> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_8> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_9> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_10> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_11> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_12> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_13> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_14> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_15> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_16> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_17> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_18> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_19> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_20> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_21> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_22> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_23> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <count_25K_24> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_14> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_13> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_12> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_11> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_10> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_9> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_8> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_7> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_6> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_5> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_4> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_3> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_2> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/count_25K_0> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/selected_dig_4> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/selected_dig_3> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/selected_dig_2> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/selected_dig_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/an_3> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/an_2> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/an_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/an_0> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/dig_selection_1> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/dig_selection_0> of sequential type is unconnected in block <cron_dec>.
WARNING:Xst:2677 - Node <display_driver/ck_1KHz> of sequential type is unconnected in block <cron_dec>.

Mapping all equations...
Building and optimizing final netlist ...
Found area constraint ratio of 100 (+ 5) on block cron_dec, actual ratio is 0.

Final Macro Processing ...

=========================================================================
Final Register Report

Found no macro
=========================================================================

=========================================================================
*                           Partition Report                            *
=========================================================================

Partition Implementation Status
-------------------------------

  No Partitions were found in this design.

-------------------------------

=========================================================================
*                            Final Report                               *
=========================================================================

Clock Information:
------------------
No clock signals found in this design

Asynchronous Control Signals Information:
----------------------------------------
No asynchronous control signals found in this design

Timing Summary:
---------------
Speed Grade: -4

   Minimum period: No path found
   Minimum input arrival time before clock: No path found
   Maximum output required time after clock: No path found
   Maximum combinational path delay: No path found

=========================================================================

Process "Synthesize - XST" completed successfully
Preparing to edit projeto_2.ucf...
