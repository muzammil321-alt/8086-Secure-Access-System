# 8086 Secure Access System (COAL Project)

## 1. Project Overview
This project simulates a low-level security gatekeeper. Unlike high-level applications, it interacts directly with the **8086 Microprocessor** registers to verify user identity through a 4-digit PIN.

## 2. Technical Specifications
* **Architecture:** Intel 8086 (16-bit)
* **Operating Mode:** Real Mode (ORG 100h)
* **Registers Used:** 
  * `AX`: Input handling via Interrupts.
  * `SI` & `DI`: Memory indexing for PIN comparison.
  * `CX`: Loop control for multi-digit validation.
* **Interrupts:** `INT 21h` (Functions 07h, 09h, 02h).

## 3. Advanced Security Features
* **Zero Echo Input:** Uses `AH 07h` to ensure the PIN is never stored in the video buffer (screen) during entry.
* **Masked Feedback:** Implements a manual loop to print '*' for each keystroke, simulating modern ATM interfaces.
* **Hardware Lockdown:** If comparison fails, the system triggers a simulated lockdown sequence.

## 4. Performance Metrics
* **Instruction Throughput:** Optimized by using `LOOP` instead of manual jumps.
* **Memory Footprint:** Extremely lightweight (COM format), utilizing less than 1KB of RAM.
