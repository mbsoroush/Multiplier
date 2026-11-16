# 🔢 Multiplier — Booth Multiplier in VHDL

A **16×16-bit signed multiplier** written in VHDL, using radix-2 **Booth's algorithm** and a classic **datapath + controller** architecture. Two 16-bit two's-complement operands go in and a 32-bit signed product comes out in 16 clock cycles. The design is built bottom-up from reusable components: full adders, registers, and shift registers.

![VHDL](https://img.shields.io/badge/Language-VHDL-543978?style=flat-square)
![Digital Logic](https://img.shields.io/badge/Domain-Digital%20Design-0A7D91?style=flat-square)
![Computer Architecture](https://img.shields.io/badge/Domain-Computer%20Architecture-2E7D32?style=flat-square)

## ✨ Features

- **Signed multiplication** of two 16-bit numbers into a 32-bit result
- **Booth's algorithm**: adds or subtracts the shifted multiplicand depending on pairs of multiplier bits
- **Fixed latency**: 16 multiply cycles, one multiplier bit per clock
- **Start/ready handshake** driven by a 4-state FSM
- **Modular, structural design** with reusable generic components (`size` generic on adders and registers)

## 🏗️ Architecture

```
            ┌──────────────────────── Multiplier (top) ────────────────────────┐
  start ───►│  ┌────────────┐  rst, regs_we, regs_sh, mult_we  ┌────────────┐  │
  reset ───►│  │ Controller │ ───────────────────────────────► │  Datapath  │  │──► mult[31:0]
            │  │   (FSM)    │ ◄───┐                            └────────────┘  │
  clk ─────►│  └────────────┘     │ count_done                                 │──► ready
            │        │ count_rst  │                                            │
            │        ▼            │                                            │
            │  ┌────────────┐ ────┘                                            │
            │  │  Counter   │  (4-bit, done when count = 15)                   │
            │  └────────────┘                                                  │
            └──────────────────────────────────────────────────────────────────┘
```

### How the multiplication works

1. **Load:** `a` is sign-extended to 32 bits into a left-shifting register (PIPO). `b` is loaded into a right-shifting register (PISO) with an extra `0` appended on the right (`b & '0'`).
2. **Booth step (repeated 16 times):** the two lowest bits `(x, y)` of the PISO register select the operation:

   | `x y` | Action on the accumulator |
   |:-----:|---------------------------|
   | `0 0` | no change |
   | `0 1` | add the shifted multiplicand |
   | `1 0` | subtract the shifted multiplicand |
   | `1 1` | no change |

   Subtraction is done by inverting the operand and setting the adder's carry-in (`~A + 1`).
3. **Shift:** the multiplicand shifts left and the multiplier shifts right (arithmetic shift) after each step.
4. **Done:** after 16 steps the accumulator holds the 32-bit signed product and `ready` goes high.

### Controller FSM

| State | Outputs active | Moves to |
|-------|----------------|----------|
| `rst_start` | `rst` (clears the datapath) | `init` when `start = 1` |
| `init` | `regs_we`, `count_rst` (load operands, reset counter) | `multipling` when `start = 0` |
| `multipling` | `regs_we`, `regs_sh`, `mult_we` (shift and accumulate) | `finished` when `count_done = 1` |
| `finished` | `ready` | `rst_start` when `start = 1` |

## 🔌 Interface

| Port | Dir | Width | Description |
|------|-----|-------|-------------|
| `clk` | in | 1 | Clock (rising edge) |
| `reset` | in | 1 | Synchronous reset, returns the FSM to `rst_start` |
| `start` | in | 1 | Pulse high, then low, to begin a multiplication |
| `a` | in | 16 | Multiplicand (signed) |
| `b` | in | 16 | Multiplier (signed) |
| `mult` | out | 32 | Product (valid when `ready = 1`) |
| `ready` | out | 1 | High when the result is valid |

## 📁 Files

| File | Entity | Role |
|------|--------|------|
| `Multiplier.vhd` | `multiplier` | Top level, connects the controller, datapath, and counter |
| `Controller.vhd` | `controller` | 4-state control FSM |
| `datapath.vhd` | `data_path` | Adder/subtractor, PIPO and PISO shift registers, accumulator |
| `Counter.vhd` | `counter` | 4-bit counter built from an adder and a register |
| `nBitAdder.vhd` | `n_bit_adder` | Generic N-bit ripple-carry adder |
| `FourBitAdder.vhd` | `four_bit_adder` | 4-bit ripple-carry adder (used by the counter) |
| `Full_adder.vhd` | `full_adder` | 1-bit full adder |
| `n_BitRegSynch.vhd` | `n_BitRegSynch` | Generic synchronous register with write-enable |
| `FourBitRegSynch.vhd` | `FourBitRegSynch` | 4-bit synchronous register |
| `n_BitPIPO.vhd` | `n_BitPipo` | Parallel-in register with left shift |
| `n_BitPISO.vhd` | `n_BitPiso` | Parallel-in register with arithmetic right shift and serial outputs |
| `test.vhd` | `test_multiplier` | Testbench |

## 🧪 Testbench

`test.vhd` runs one multiplication:

| Input | Value |
|-------|-------|
| `a` | `0xDEFC` (−8452) |
| `b` | `0x7FE9` (32745) |
| Expected `mult` | `0xEF80F75C` (−276,760,740) |

The clock period is 10 ns, `reset` is held for 10 ns, and `start` is pulsed from 10 ns to 20 ns. Run for about **300 ns** and look for `ready = 1` with `mult = 0xEF80F75C`. The testbench has no automatic check, so inspect the waveform.

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/mbsoroush/Multiplier.git
   cd Multiplier
   ```
2. Open the files in a VHDL simulator (ModelSim/Questa, GHDL, Vivado, or Quartus).
3. Compile in dependency order. The files use explicit `FOR ALL ... USE ENTITY` bindings, so order matters:
   ```
   Full_adder.vhd → FourBitAdder.vhd → nBitAdder.vhd → n_BitRegSynch.vhd →
   FourBitRegSynch.vhd → n_BitPIPO.vhd → n_BitPISO.vhd → Counter.vhd →
   datapath.vhd → Controller.vhd → Multiplier.vhd → test.vhd
   ```
4. Simulate `test_multiplier` and add `clk`, `start`, `ready`, `a`, `b`, and `mult` to the waveform.

**With GHDL:**
```bash
ghdl -a Full_adder.vhd FourBitAdder.vhd nBitAdder.vhd n_BitRegSynch.vhd \
       FourBitRegSynch.vhd n_BitPIPO.vhd n_BitPISO.vhd Counter.vhd \
       datapath.vhd Controller.vhd Multiplier.vhd test.vhd
ghdl -e test_multiplier
ghdl -r test_multiplier --stop-time=300ns --vcd=wave.vcd
```

## 🎯 Learning Objectives

- Separate **datapath** from **control** in a digital design
- Implement **Booth's algorithm** for signed multiplication in hardware
- Build larger systems from reusable, generic components
- Design a finite-state machine with a start/ready handshake
- Verify a design with a VHDL testbench
