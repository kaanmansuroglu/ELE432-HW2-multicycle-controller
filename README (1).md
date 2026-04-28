# ELE 432 - HW2: Multicycle Processor Controller

Hierarchical SystemVerilog design of a multicycle RISC-V controller, following
the structure in Figure 1 of the assignment:

```
controller
 ├── mainfsm
 ├── aludec
 └── instrdec
```

## Adjustments made

To pass the testbench cleanly, two minor edits were applied:

- **`aludec.sv`**: the inner `case(funct3)` had `default: ALUControl = 3'bxxx`,
  which propagates X values through simulation. Replaced with `3'b000` so the
  output is deterministic, as suggested in the assignment ("set don't cares to
  0 to simplify testing"). All other entries match Table 1 exactly.

- **`instrdec.sv`**: the R-type and `default` cases originally returned
  `2'bxx`. Same reasoning — replaced with `2'b00`. The testbench skips the
  comparison when `expected[15:14] === 2'bx`, so this change does not affect
  test results.

The `controller.tv` encoding matches Table 1 directly; no changes were needed
there.

## Result

All test vectors pass with 0 errors.
