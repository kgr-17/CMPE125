`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 03:45:08 PM
// Design Name: 
// Module Name: CLALogic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CLALogic (
    input  [3:0] G,
    input  [3:0] P,
    input        Ci,
    output [2:0] C,
    output       Co,
    output       PG,
    output       GG
);

    // C1 = G0 + P0*Ci
    wire c1_t1;

    and (c1_t1, P[0], Ci);
    or  (C[0], G[0], c1_t1);


    // C2 = G1 + P1*G0 + P1*P0*Ci
    wire c2_t1;
    wire c2_t2;

    and (c2_t1, P[1], G[0]);
    and (c2_t2, P[1], P[0], Ci);
    or  (C[1], G[1], c2_t1, c2_t2);


    // C3 = G2 + P2*G1 + P2*P1*G0 + P2*P1*P0*Ci
    wire c3_t1;
    wire c3_t2;
    wire c3_t3;

    and (c3_t1, P[2], G[1]);
    and (c3_t2, P[2], P[1], G[0]);
    and (c3_t3, P[2], P[1], P[0], Ci);
    or  (C[2], G[2], c3_t1, c3_t2, c3_t3);


    // PG = P3*P2*P1*P0
    and (PG, P[3], P[2], P[1], P[0]);


    // GG = G3 + P3*G2 + P3*P2*G1 + P3*P2*P1*G0
    wire gg_t1;
    wire gg_t2;
    wire gg_t3;

    and (gg_t1, P[3], G[2]);
    and (gg_t2, P[3], P[2], G[1]);
    and (gg_t3, P[3], P[2], P[1], G[0]);
    or  (GG, G[3], gg_t1, gg_t2, gg_t3);


    // Co = GG + PG*Ci
    wire co_t1;

    and (co_t1, PG, Ci);
    or  (Co, GG, co_t1);

endmodule