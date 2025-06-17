# ping_assembly

This is a classic Pong game implementation written in x86 assembly language for the DOS environment. The game features two paddles controlled by players, a bouncing ball, and a scoring system.

---   

## 🎮 Features
- Two horizontal paddles (top & bottom rows)
- Diagonal ball movement with bounce logic
- Timer-based motion & keyboard input (INT 08h, INT 09h)
- First to 5 points wins
- Player turn logic for fair control
- Direct video memory rendering
- Animated win screen and score display

## ⌨️ Controls
- **Player A (Top):** ← and → arrow keys
- **Player B (Bottom):** `S` (left), `D` (right)
- Paddle moves only during player's turn

## 🧠 Internals
- Uses BIOS interrupts for input/timing
- Frame updates via timer interrupt
- Clean exit with interrupt restoration
---
## 🏁 Scoring and Termination

- Player scores if opponent misses the ball.
- First to 5 points wins.
- Winner shown via animated message
---
## Gameplay Demo 

![Gameplay Demo](coalproject.video.gif)

---

## ⚙️ Installation Steps


### 1. Clone the repository
   ```bash
   git clone https://github.com/RanaAbdulHannan/ping_assembly.git
   cd ping_assembly
```
### 2. Assemble the Code Using NASM on Dosbox
```bash
nasm coal.asm -o coal.com
```
### 3.Run It 
```bash
coal.com
```






## 👥 Contributors

- [Muhammad Zaigham Asif](https://github.com/MuhammadZaighamAsif)
- [Abdul Hannan](https://github.com/RanaAbdulHannan)

> **Institution**: FAST NUCES Lahore  
> **Course**: Computer Organization & Assembly Language, Fall 2024

