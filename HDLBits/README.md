### Structure of Directories
---

```plain
.
├── Circuits
│   ├── Combiantional_Logic
│   │   ├── Arithmetic_Circuits
│   │   │   ├── adder100.v
│   │   │   ├── adder3.v
│   │   │   ├── bcdadd4.v
│   │   │   ├── ece241_2014_q1c.v
│   │   │   ├── fadd.v
│   │   │   ├── hadd.v
│   │   │   └── m2014_q4j.v
│   │   ├── Basic_Gates
│   │   │   ├── 7420.v
│   │   │   ├── gates.v
│   │   │   ├── gatesv100.v
│   │   │   ├── gatesv.v
│   │   │   ├── m2014_q4e.v
│   │   │   ├── m2014_q4f.v
│   │   │   ├── m2014_q4g.v
│   │   │   ├── m2014_q4h.v
│   │   │   ├── m2014_q4i.v
│   │   │   ├── mt2015_eq2.v
│   │   │   ├── mt2015_q4a.v
│   │   │   ├── mt2015_q4b.v
│   │   │   ├── mt2015_q4.v
│   │   │   ├── popcount3.v
│   │   │   ├── ringer.v
│   │   │   ├── thermostat.v
│   │   │   └── truthtable1.v
│   │   ├── Karnaugh_Map
│   │   │   ├── 2012_q1g.v
│   │   │   ├── ece241_2013_q2.v
│   │   │   ├── ece_241_2014_q3.v
│   │   │   ├── kmap1.v
│   │   │   ├── kmap2.v
│   │   │   ├── kmap3.v
│   │   │   ├── kmap4.v
│   │   │   └── m2014_q3.v
│   │   └── Multiplexers
│   │       ├── mux256to1.v
│   │       ├── mux256to1v.v
│   │       ├── mux2to1.v
│   │       ├── mux2to1v.v
│   │       └── mux9to1v.v
│   ├── Large_Circuits
│   │   ├── fancytimer.v
│   │   ├── fsmeq.v
│   │   ├── fsmonehot.v
│   │   ├── fsmshift.v
│   │   ├── fsm.v
│   │   ├── review2015_count1k.v
│   │   └── shiftcount.v
│   └── Sequential_Logic
│       ├── Counters
│       │   ├── clock.v
│       │   ├── count10.v
│       │   ├── count15.v
│       │   ├── count1to10.v
│       │   ├── countbcd.v
│       │   ├── countslow.v
│       │   ├── ece241_2014_q7a.v
│       │   └── ece241_2014_q7b.v
│       ├── Finete_State_Machines
│       │   ├── 2012_q2b.v
│       │   ├── 2012_q2fsm.v
│       │   ├── 2013_q2afsm.v
│       │   ├── 2013_q2bfsm.v
│       │   ├── 2014_q3bfsm.v
│       │   ├── 2014_q3c.v
│       │   ├── 2014_q3fsm.v
│       │   ├── ece241_2013_q4.v
│       │   ├── ece241_2013_q8.v
│       │   ├── ece241_2014_q5a.v
│       │   ├── ece241_2014_q5b.v
│       │   ├── fsm1s.v
│       │   ├── fsm1.v
│       │   ├── fsm2s.v
│       │   ├── fsm2.v
│       │   ├── fsm3comb.v
│       │   ├── fsm3onehot.v
│       │   ├── fsm3s.v
│       │   ├── fsm3.v
│       │   ├── fsm_hdlc.v
│       │   ├── fsm_ps2data.v
│       │   ├── fsm_ps2.v
│       │   ├── fsm_serialdata.v
│       │   ├── fsm_serialdp.v
│       │   ├── fsm_serial.v
│       │   ├── lemmings1.v
│       │   ├── lemmings2.v
│       │   ├── lemmings3.v
│       │   ├── lemmings4.v
│       │   ├── m2014_q6b.v
│       │   ├── m2014_q6c.v
│       │   └── m2014_q6.v
│       ├── Latches_Flip_Flops
│       │   ├── 2014_q4a.v
│       │   ├── dff16e.v
│       │   ├── dff8ar.v
│       │   ├── dff8p.v
│       │   ├── dff8r.v
│       │   ├── dff8.v
│       │   ├── dff.v
│       │   ├── dualedge.v
│       │   ├── ece241_2013_q7.v
│       │   ├── ece241_2014_q4.v
│       │   ├── edgecapture.v
│       │   ├── edgedetect2.v
│       │   ├── edgedetect.v
│       │   ├── m2014_q4a.v
│       │   ├── m2014_q4b.v
│       │   ├── m2014_q4c.v
│       │   ├── m2014_q4d.v
│       │   └── mt2015_muxdff.v
│       ├── More_Circuits
│       │   ├── conwaylife.v
│       │   ├── rule110.v
│       │   └── rule90.v
│       └── Shift_Registers
│           ├── 2014_q4b.v
│           ├── ece241_2013_q12.v
│           ├── lfsr32.v
│           ├── lfsr5.v
│           ├── m2014_q4k.v
│           ├── mt2015_lfsr.v
│           ├── rotate100.v
│           ├── shift18.v
│           └── shift4.v
├── Exam
│   ├── ece241_2014_q8.v
│   └── srlatch.v
├── README.md
├── Verification
│   ├── sim
│   │   ├── Bug
│   │   │   ├── bugs_addsubz.v
│   │   │   ├── bugs_case.v
│   │   │   ├── bugs_mux2.v
│   │   │   ├── bugs_mux4.v
│   │   │   └── bugs_nand3.v
│   │   └── sim
│   │       ├── circuit10.v
│   │       ├── circuit1.v
│   │       ├── circuit2.v
│   │       ├── circuit3.v
│   │       ├── circuit4.v
│   │       ├── circuit5.v
│   │       ├── circuit6.v
│   │       ├── circuit7.v
│   │       ├── circuit8.v
│   │       └── circuit9.v
│   └── tb
│       ├── and.v
│       ├── tb1.v
│       ├── tb2.v
│       ├── tb_clock.v
│       └── tff.v
└── Verilog_Language
    ├── Basics
    │   ├── Basics
    │   │   ├── 7458.v
    │   │   ├── andgate.v
    │   │   ├── norgate.v
    │   │   ├── notgate.v
    │   │   ├── wire4.v
    │   │   ├── wire_decl.v
    │   │   ├── wire.v
    │   │   └── xnorgate.v
    │   └── norgate.v
    ├── Modules
    │   ├── module_addsub.v
    │   ├── module_add.v
    │   ├── module_cseladd.v
    │   ├── module_fadd.v
    │   ├── module_name.v
    │   ├── module_pos.v
    │   ├── module_shift8.v
    │   ├── module_shift.v
    │   └── module.v
    ├── More_Features
    │   ├── adder100i.v
    │   ├── bcdadd.v
    │   ├── conditional.v
    │   ├── gates100.v
    │   ├── popcount255.v
    │   ├── reduction.v
    │   └── vector100r.v
    ├── Procedures
    │   ├── alwaysblock1.v
    │   ├── alwaysblock2.v
    │   ├── always_case2.v
    │   ├── always_case.v
    │   ├── always_casez.v
    │   ├── always_if2.v
    │   ├── always_if.v
    │   └── always_nolatches.v
    └── Vectors
        ├── gates4.v
        ├── vector0.v
        ├── vector1.v
        ├── vector2.v
        ├── vector3.v
        ├── vector4.v
        ├── vector5.v
        ├── vectorgates.v
        └── vectorr.v
```
