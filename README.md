# Apple Foundaytion Program - **EduGames** iOS B.S. Thesis Application

EduGames is an interactive educational iOS application designed to make learning more engaging for children through quizzes, subject-specific exercises, and mini-games.

The project was developed in a challenge-based team environment during the **Apple Foundation Program at the University of Salerno** and later formed the basis of my **B.S. thesis in Computer Engineering**. My contribution covered the software-development lifecycle from requirements analysis and design through implementation and testing, with a focus on the application's core architecture, quiz experience, scoring logic, and interactive game components.

## Project Highlights

- Built a native iOS application using **Swift 5** and **SwiftUI**.
- Implemented a daily quiz workflow with randomized questions and persistent daily/overall scoring using `UserDefaults`.
- Developed educational activities covering **mathematics, geometry, and English**.
- Integrated multiple interactive mini-games, including **Tic-Tac-Toe**, **Hangman**, and a custom side-scrolling **Rexy** game with collision detection and score tracking.
- Bridged SwiftUI with **UIKit** to implement a custom drawing canvas with color selection, undo, and sharing capabilities.
- Used **WebKit** interoperability to render animated GIF content inside SwiftUI views.
- Structured application state using `ObservableObject`, `@StateObject`, `@EnvironmentObject`, and reusable SwiftUI views.

## Main Features

### Daily Quiz

The application provides a quiz area with randomly selected questions and a scoring system. Daily and cumulative scores are stored locally and shared across the application through observable state managers.

### Mathematics

Interactive exercises include:

- Addition
- Subtraction
- Multiplication
- Division
- Geometry recognition

Each activity provides immediate feedback and maintains a score across the learning experience.

### English Learning

The English-learning area contains activities such as:

- Image-to-word matching
- Word identification
- Hangman

These exercises combine visual interaction with basic vocabulary practice.

### Interactive Mini-Games

EduGames includes several game-based activities intended to complement the educational exercises:

- **Tic-Tac-Toe** with single-player and two-player modes
- **Rexy**, a side-scrolling game with animated character states, obstacles, collision detection, and score accumulation
- **Drawing Canvas** with multiple colors, erasing/undo support, and image sharing

## Technical Architecture

The application follows the SwiftUI application lifecycle and is organized around reusable views and observable state.

Key implementation choices include:

- **SwiftUI** for the primary UI and navigation layer
- **ObservableObject / EnvironmentObject** for shared score state
- **UserDefaults** for lightweight local persistence
- **UIViewRepresentable + UIKit** for the custom drawing component
- **UIViewRepresentable + WebKit** for GIF rendering
- Custom game-state models and timers for interactive gameplay

The repository also contains standard Xcode unit-test and UI-test targets.

## Technology Stack

| Area | Technologies |
| --- | --- |
| Language | Swift 5 |
| UI | SwiftUI, UIKit |
| Media Integration | WebKit |
| Game-related Components | GameplayKit, custom SwiftUI game logic |
| Persistence | UserDefaults |
| Development Environment | Xcode |
| Target | iOS / iPadOS, deployment target 16.2 |

## Project Structure

```text
EduGames.xcodeproj
AppTesi1/
├── AppTesi1App.swift          # Application entry point and score managers
├── ContentView.swift          # Main tab-based navigation
├── Quiz.swift                 # Quiz data model
├── QuizView.swift             # Daily quiz entry screen
├── QuizHomePageView.swift     # Quiz interaction and scoring
├── Catalogo/
│   ├── Principale.swift       # Educational activity catalogue
│   ├── MathExercisesView.swift
│   ├── EnglishExercisesView.swift
│   ├── GeometryView.swift
│   ├── HangmanView.swift
│   ├── TrisGameView.swift
│   └── DrawView.swift
├── RexyGame/
│   ├── GameView.swift
│   ├── RexyView.swift
│   ├── OpponentsView.swift
│   ├── GroundView.swift
│   └── ...
└── Assets / Images / GIF resources
```

> The internal Xcode target retains the original academic project name `AppTesi1`; the public repository is named `EduGamesiOS-BSThesis` for clarity.

## Getting Started

### Requirements

- macOS
- Xcode with support for Swift 5 and iOS 16.2 or later
- iOS Simulator or compatible physical device

### Run the Application

1. Clone the repository:

   ```bash
   git clone https://github.com/engbrunosalvatore/EduGamesiOS-BSThesis.git
   ```

2. Open the Xcode project:

   ```bash
   open EduGames.xcodeproj
   ```

3. Select an iOS simulator or physical device.
4. Build and run the `EduGames` target from Xcode.

No external package installation is required by the current Xcode project.

## Academic Context

**B.S. in Computer Engineering — University of Salerno**  
Final grade: **110/110, cum laude**

**Bachelor's Thesis:** *EduGames: Interactive Children's Learning Application*  
The thesis was written and defended in Italian after participation in the Apple Foundation Program.

The project involved the complete software-development process, from requirements analysis and interface design to implementation and testing of the final iOS application.

## Development Context

EduGames was originally developed collaboratively during the Apple Foundation Program. Original source-file authorship headers have been preserved in the repository. This repository is maintained as part of my academic and software-engineering portfolio.

## Repository Notes

Before publishing the project, generated and machine-specific files should not be committed. In particular, exclude:

```text
.DS_Store
__MACOSX/
xcuserdata/
```

A suitable Swift/Xcode `.gitignore` is recommended.

---

**Salvatore Bruno**  
Computer Engineer · Ph.D. Candidate in Computer Engineering  
[GitHub](https://github.com/engbrunosalvatore) · [LinkedIn](https://www.linkedin.com/in/salvatore-bruno-eng)
