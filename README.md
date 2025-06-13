# ping_assembly
This is a classic Pong game implementation written in x86 assembly language for DOS environment. The game features two paddles controlled by players, a bouncing ball, and a scoring system.
# Game Description
# Gameplay
Player A controls the left paddle using the left and right arrow keys.

Player B controls the right paddle using the 'S' and 'D' keys.

The ball bounces between the paddles and the top/bottom walls.

If a player misses the ball, the opponent scores a point.

The first player to reach 5 points wins the game.

# Technical Details
Uses BIOS interrupts for keyboard input and timer functionality

Directly writes to video memory (0xB800) for display

Implements custom keyboard and timer interrupt service routines

Features a clean screen refresh system

Includes score tracking and display

# Memory Usage
The game uses various memory locations to track:

Paddle positions (paddleA, paddleB)

Ball position (starpos, row, col)

Game state flags (pflag, dirflag)

Scores (scoreA, scoreB)

Original interrupt vectors (oldkb, oldisr)

# Visual Elements
Paddles are displayed as white bars (20 characters wide)

The ball is represented by an asterisk (*) that changes color

Scores are displayed at the bottom of the screen

The winner announcement is displayed with a nice animation

# How to Run
Assemble with NASM: nasm pong.asm -o pong.com

Run in DOS or DOSBox: pong.com
## 🕹️ Controls

- Player A: Arrow keys (←, →)
- Player B: S (left), D (right)

## 🏁 Scoring and Termination

- Player scores if opponent misses the ball.
- First to 5 points wins.

## 👥 Contributors

- [Muhammad Zaigham Asif](https://github.com/MuhammadZaighamAsif)
- [Abdul Hannan](https://github.com/RanaAbdulHannan)

> **Institution**: FAST NUCES Lahore  
> **Course**: Computer Organization & Assembly Language, Fall 2024

