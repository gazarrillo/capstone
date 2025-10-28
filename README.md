# Psyche-opoly: Acquiring Asteroids

A lightweight, browser-based board game inspired by Monopoly for 2-6 players (human and AI). Built to communicate the NASA Psyche mission through accessible, privacy-respecting gameplay.

**Team:** Jason Baris, Christopher Buckley, John Fugate, Giovanni Zarrillo  
**Advisors:** Naseem Ibrahim (Course Instructor & Faculty Advisor), Cassie Bowman (Project Mentor)  
**Sponsor:** NASA/ASU Psyche Capstone Program  
**Institution:** Pennsylvania State University, World Campus | Version 1.5 | October 2025

## Overview

A turn-based web game that supports STEM education by combining Monopoly-style gameplay with space-science themes. Features include turn management, dice mechanics, property system, trading, card effects, and win/loss detection—all without user accounts, data collection, or network requirements.

## Architecture

**Pattern:** Model-View-Controller (MVC)
- **Model:** Game state and logic (Game Engine Core, Game Data & Assets)
- **View:** UI rendering (game board, player tokens, panels)
- **Controller:** Input handling (user input and AI controllers)

**Deployment:** HTML5 web game with client-side execution in web browsers

## Technologies

**Engine:** Godot 4.x (open-source, HTML5 export, lightweight web performance)  
**Language:** GDScript (Python-like syntax, native Godot integration, C# fallback available)  
**Alternatives Considered:** Unity (licensing/weight issues), Unreal (deprecated web export), Phaser.js (lacks visual tooling)

## Development Practices

**Code Style:** GDScript guidelines (PEP 8-inspired)
- Classes/Nodes: `PascalCase` | Functions/Variables: `snake_case` | Constants: `CONSTANT_CASE` | Private: `_prefixed`

**Version Control:** Feature Branch Workflow with Git/GitHub
- Protected `main` branch | Feature branches for development | PR reviews required | Conventional commits (`<type>: description`)

## Features

**Gameplay:** Turn management, dice rolls, property acquisition/upgrades, trading, card effects, win/loss detection  
**Accessibility:** Color-safe UI, audio-independent cues, responsive on low-end devices  
**Privacy:** No accounts, no data collection, offline-capable

## Getting Started

**Play:** Any modern web browser with HTML5 support (no installation required)  
**Develop:** Clone repository → Open in Godot 4.x → Create feature branch → Submit PR

## License

NASA/ASU Psyche Capstone program project

---

*Merging ethical software engineering, STEM education, and space exploration accessibility.*
