//
//      CONFIDENTIAL  AND  PROPRIETARY SOFTWARE OF ARM Physical IP, INC.
//      
//      Copyright (c) 1993-2022  ARM Physical IP, Inc.  All  Rights Reserved.
//      
//      Use of this Software is subject to the terms and conditions  of the
//      applicable license agreement with ARM Physical IP, Inc.  In addition,
//      this Software is protected by patents, copyright law and international
//      treaties.
//      
//      The copyright notice(s) in this Software does not indicate actual or
//      intended publication of this Software.
//      
//      name:			Advantage Dual-Port SRAM Generator
//           			TSMC CLN90G Process
//      version:		2005Q4V1
//      comment:		
//      configuration:	 -instname "SRAM_4096_32" -words 4096 -bits 32 -frequency 150 -ring_width 2.0 -mux 16 -write_mask on -wp_size 8 -top_layer "met5-9" -power_type rings -horiz met3 -vert met4 -redundancy off -rcols 2 -rrows 2 -bmux off -ser none -ema on -cust_comment "" -bus_notation on -left_bus_delim "[" -right_bus_delim "]" -pwr_gnd_rename "VDD:VDD,VSS:VSS" -prefix "" -pin_space 0.0 -name_case upper -check_instname on -diodes on -inside_ring_type VSS -drive 6 -dpccm on -asvm off -corners ff_1.1_-40.0,ff_1.1_125.0,tt_1.0_25.0,ss_0.9_125.0
//
//      Repair Verilog RTL for Synchronous Dual-Port Ram
//
//      Top Module Name:            SRAM_4096_32_rtl_top
//      Words:                      4096
//      User Bits:                  32
//      Mux:                        16
//      Drive:                      6
//      Write Mask:                 On
//      Extra Margin Adjustment:    On
//      Accelerated Retention Test: Off
//      Redundant Rows:             0
//      Redundant Columns:          0
//      Test Muxes                  Off
//
//      Creation Date:  2022-08-30 09:27:21Z
//      Version: 	2005Q4V1
//
`timescale 1ns/1ps

 
module SRAM_4096_32_rtl_top (
   QA,
   QB,
   CLKA,
   CENA,
   WENA,
   AA,
   DA,
   CLKB,
   CENB,
   WENB,
   AB,
   DB,
   EMAA,
   EMAB
);

   output [31:0]            QA;
   output [31:0]            QB;
   input                    CLKA;
   input                    CENA;
   input [3:0]              WENA;
   input [11:0]             AA;
   input [31:0]             DA;
   input                    CLKB;
   input                    CENB;
   input [3:0]              WENB;
   input [11:0]             AB;
   input [31:0]             DB;
   input [2:0]              EMAA;
   input [2:0]              EMAB;
   wire		[31:0]	DIA;
   wire		[31:0]	QOA;
   wire		[31:0]	DIB;
   wire		[31:0]	QOB;


   assign QA=QOA;
   assign DIA=DA;
   assign QB=QOB;
   assign DIB=DB;

SRAM_4096_32_fr_top u0 (
   .QOA(QOA),
   .QOB(QOB),
   .CLKA(CLKA),
   .CENA(CENA),
   .WENA(WENA),
   .AA(AA),
   .DIA(DIA),
   .CLKB(CLKB),
   .CENB(CENB),
   .WENB(WENB),
   .AB(AB),
   .DIB(DIB),
   .EMAA(EMAA),
   .EMAB(EMAB)
);

endmodule
module SRAM_4096_32_fr_top (
   QOA,
   QOB,
   CLKA,
   CENA,
   WENA,
   AA,
   DIA,
   CLKB,
   CENB,
   WENB,
   AB,
   DIB,
   EMAA,
   EMAB
);

   output [31:0]            QOA;
   output [31:0]            QOB;
   input                    CLKA;
   input                    CENA;
   input [3:0]              WENA;
   input [11:0]             AA;
   input [31:0]             DIA;
   input                    CLKB;
   input                    CENB;
   input [3:0]              WENB;
   input [11:0]             AB;
   input [31:0]             DIB;
   input [2:0]              EMAA;
   input [2:0]              EMAB;
   wire	[31:0]	DA;
   wire	[31:0]	QA;

   assign DA=DIA;
   assign QOA=QA;

   wire	[31:0]	DB;
   wire	[31:0]	QB;

   assign DB=DIB;
   assign QOB=QB;

SRAM_4096_32 u0 (
   .QA(QA),
   .QB(QB),
   .CLKA(CLKA),
   .CENA(CENA),
   .WENA(WENA),
   .AA(AA),
   .DA(DA),
   .CLKB(CLKB),
   .CENB(CENB),
   .WENB(WENB),
   .AB(AB),
   .DB(DB),
   .EMAA(EMAA),
   .EMAB(EMAB)
);

endmodule
