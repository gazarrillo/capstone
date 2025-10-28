# Psyche-opoly: Acquiring Asteroids

A lightweight, browser-based, turn-based board game inspired by Monopoly that supports two to six players (human and built-in AI). This game is designed to communicate the NASA Psyche mission to broad audiences while emphasizing accessibility, privacy, and educational value.

## Team Members

- **Jason Baris** - Software Engineering Major
- **Christopher Buckley** - Software Engineering Major
- **John Fugate** - Software Engineering Major
- **Giovanni Zarrillo** - Software Engineering Major

### Advisors

- **Course Instructor:** Naseem Ibrahim
- **Faculty Advisor:** Naseem Ibrahim
- **Industry Sponsor:** Psyche Capstone, ASU, NASA
- **Project Mentor:** Cassie Bowman

### Academic Information

A capstone project submitted to the faculty of Computer Science and Software Engineering, Pennsylvania State University, World Campus

**Version:** 1.5  
**Date:** October 2025

## Abstract

The client is the NASA/ASU Psyche Capstone program, which sponsors interdisciplinary projects that communicate the Psyche mission to broad audiences. In the current state of the art, many Monopoly-like games exist across web and app platforms, but they often trade off openness, accessibility, and classroom suitability. Typical issues include reliance on user accounts, data collection, network connectivity, or heavyweight runtimes that limit reach on school or low-end devices.

Our objective is to deliver a lightweight, browser-based, turn-based board game inspired by Monopoly that supports two to six players (human and built-in AI), enforces fair play, and operates without collecting personal data. Concretely, the system will manage turns, dice randomness, movement and space resolution, property acquisition and upgrades, cash flow, trading, card effects, and automatic win/loss detection. Non-functional objectives emphasize accessibility (UI clarity, color-safe palettes, audio-independent cues), responsiveness on consumer hardware, and alignment with the client's development practices.

### Expected Impact

**For Individuals and Families:**  
The game provides a free, accessible experience that blends play with exposure to space-science themes.

**For Instructors and Outreach Organizations:**  
A zero-install, data-minimal web build lowers IT friction for classroom or public events.

**For Society:**  
The project supports STEM engagement by framing a real NASA mission within an approachable game loop that encourages curiosity about space exploration.

Ultimately, Psyche-opoly demonstrates how ethical, accessible software engineering principles can merge education and entertainment within a STEM-outreach context. By emphasizing fairness, privacy, and usability, the system exemplifies responsible digital design while fulfilling the Psyche program's goal of connecting the excitement of space discovery to diverse global audiences.

## Architecture

### Architectural Design

The project uses the **Model-View-Controller (MVC)** pattern, which is ideal for applications with significant user interface components. This pattern provides a clean separation of concerns, supporting maintainability and future development requirements.

#### Why MVC?

- **Model:** Manages core data and game logic, including game state (player money, property ownership) and all game rules. Isolated from the UI, it simply manages data and notifies the View of changes. In our design, this includes the Game Engine Core and Game Data & Assets.

- **View:** Defines how data from the Model is presented to the user. Responsible for rendering the game board, player tokens, and all UI panels. This is our User Interface component.

- **Controller:** Manages user interaction. Accepts input from users (via the Input Handler) or AI (AI Controller) and translates these into commands for the Model.

#### Deployment

As an HTML5 web game built with Godot, the deployment involves a web server hosting the game files, which are then accessed by a user's web browser. The game logic and assets are downloaded and executed client-side within the browser environment.

### Alternatives Considered

- **Client-Server Pattern:** Rejected because the game is designed to be a self-contained offline application, not reliant on any server.
- **Repository Pattern:** Rejected as unsuitable because our system components are interactive and require direct communication rather than passive repository architecture.

## Technologies

### Primary Tools

#### Godot Game Engine (v4)

Godot was chosen as the primary development platform for several compelling reasons:

- **Open Source & Free:** No licensing costs, making it accessible for educational projects
- **Feature-Rich 2D/2.5D Workflows:** Perfect for board game development
- **Scene and Node Editor:** Ideal for creating game boards and UI
- **HTML5 Export:** Enables lightweight web experience with near-native performance
- **Extensive Community:** Access to numerous useful assets and libraries

#### GDScript

GDScript is the primary programming language for this project:

- **Native Integration:** Tightly integrated with Godot's engine API
- **Python-like Syntax:** Clear and easy to learn, reducing barriers to entry
- **Team-Friendly:** Allows the team to focus on implementing game logic rather than language complexities
- **C# Support:** Available as a fallback if needed

### Alternatives Evaluated

**Unity:**
- Pros: Large community, extensive platform support
- Cons: Requires licensing, heavier for web projects (poor performance on low-end devices), steeper learning curve with C#

**Unreal Engine:**
- Pros: Industry-standard for AAA games
- Cons: Web export feature deprecated, overkill for this project

**Phaser.js:**
- Pros: Lightweight JavaScript framework built for web
- Cons: Lacks visual editor, built-in animation tools, and dedicated physics engine editor

## Development Practices

### Coding Conventions

The project follows official GDScript style guidelines (inspired by Python's PEP 8):

**Naming Conventions:**
- **Class Names & Nodes:** PascalCase (e.g., `GameBoard`, `PlayerToken`)
- **Functions & Variables:** snake_case (e.g., `roll_dice`, `current_player_money`)
- **Constants:** CONSTANT_CASE (e.g., `MAX_PLAYERS`, `STARTING_MONEY`)
- **Private Members:** Prefixed with underscore (e.g., `_calculate_rent()`)

**Comments:**
- Non-trivial functions and lines of code include explanatory comments
- Both block comments and inline comments are used as appropriate

### Version Control

**Git & GitHub:**
- Git for distributed version control
- GitHub for hosting code, tracking issues, and code reviews
- Industry-standard tools that make collaboration and change tracking easy

**Feature Branch Workflow:**
- `main` branch as the canonical version with restricted direct commits
- All development on separate feature branches
- Merge via Pull Requests (PR) with at least one team member review
- Ensures code quality and encourages team communication

**Commit Message Convention:**
- Format: `<commit type>: short explanation of change`
- Example: `feat: added dice roll animation`
- Provides clarity and easy traceability

**Why This Workflow?**
The Feature Branch Workflow strikes the perfect balance between structure and simplicity for our team's needs:
- More flexible than GitFlow (which involves multiple long-lived branches and unnecessary complexity)
- More suitable than Git Forking (which is aimed at larger open-source projects without direct push access)

## Game Features

### Core Gameplay
- **Player Support:** 2-6 players (human and AI)
- **Turn Management:** Fair, automated turn-based system
- **Dice Mechanics:** True random dice rolls
- **Movement & Spaces:** Complete board traversal with space resolution
- **Property System:** Acquisition, ownership, and upgrades
- **Economy:** Cash flow management and transactions
- **Trading:** Player-to-player property and resource trading
- **Card Effects:** Chance and community chest mechanics
- **Win/Loss Detection:** Automatic game conclusion

### Non-Functional Features
- **Accessibility:** UI clarity, color-safe palettes, audio-independent cues
- **Performance:** Responsive on consumer hardware
- **Privacy:** No personal data collection
- **Offline First:** Zero network connectivity required
- **Universal Access:** No user accounts needed
- **Lightweight:** Minimal resource requirements for school and low-end devices

## Getting Started

### Prerequisites
- Modern web browser with HTML5 support
- No installation required for playing
- For development: Godot Engine 4.x

### Development Setup
1. Clone the repository
2. Open the project in Godot Engine 4.x
3. Follow the coding conventions outlined above
4. Create feature branches for new development
5. Submit pull requests for code review

## License

This project is developed as part of the NASA/ASU Psyche Capstone program.

## Acknowledgments

Special thanks to:
- The NASA Psyche Mission team
- Arizona State University
- Pennsylvania State University, World Campus
- All project mentors and advisors
- The Godot Engine community

---

*Psyche-opoly demonstrates how ethical, accessible software engineering principles can merge education and entertainment within a STEM-outreach context.*
