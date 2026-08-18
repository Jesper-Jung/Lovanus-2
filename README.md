# Lovanus-2

Lovanus-2 is a "audio-specific" 2-stage RISC-V processor,

for everywhere, everytime, all at once.

# ⚙️ Objection

당신에게 깃들은 별빛 한 가닥씩

가지런히 가져와 저 밤하늘을 보며

한 올, 한 올,

수많은 별자리를 수놓을 수 있다면

Lovanus-2 targets to open-source MCU core on the FPGA to support audio sample calculation
including various audio FX.

# ⚙️ Architecture & Features

- **Instruction Set Architecture (ISA):** `RV32I` (Base Integer Instruction Set)
- **Pipeline Stage:** 2-Stage
- **Target Application:** Real-time control of audio effects and sample calculation
- **Optional Extensions:** RV32IM_Zicsr + Custom opcode for FFT acceleration
- **Target FPGA:** Tang Nano 9K

## Support ISA Optional Extensions

Maximum expension is up to `RV32IM_Zicsr` + FFT acceleration

* `M`: integer multiply/divide/modulo
* `Zicsr`: CSR access
* `custom opcode (TBD)`: FFT acceleration
* Machine modes only
* Privileged instructions `ecall`, `mret` and `wfi`

## Support Bus Interface

* APB
* AHB
* AXI


## Support Peripheral Hardware

- UART
- I2S: Interface that receive external audio sources from ADC and transmit to DAC
- I2C
- SPI
- QSPI
- GPIO ... TBD

# Links to Specifications

These are links to the ratified versions of the extensions.

| Extension  | Specification |
|----------- |---------------|
| `RV32I` v2.1 | [Unprivileged ISA 20191213](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf) |
| `M` v2.0 | [Unprivileged ISA 20191213](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf) |
| `Zicsr` v2.0 | [Unprivileged ISA 20191213](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf) |
| Machine ISA v1.12 | [Privileged Architecture 20211203](https://github.com/riscv/riscv-isa-manual/releases/download/Priv-v1.12/riscv-privileged-20211203.pdf) |
| Debug v0.13.2 | [RISC-V External Debug Support 20190322](https://riscv.org/wp-content/uploads/2019/03/riscv-debug-release.pdf) |
