# Snake Game in C++

A classic Snake game implementation in C++ using linked lists for the snake's body structure.

## Features

- **Linked List Implementation**: The snake's body is represented using a custom linked list structure
- **Dynamic Growth**: Snake grows when eating food
- **Collision Detection**: Wall and self-collision detection
- **Score System**: Points awarded for eating food
- **Smooth Controls**: WASD movement controls

## 🎮 Game Controls

| Key | Action |
|-----|--------|
| **W** | Move Up |
| **A** | Move Left |
| **S** | Move Down |
| **D** | Move Right |
| **X** | Quit Game |

## 📸 Demo

```
##################################
#                                #
#                                #
#        O                       #
#        o                       #
#        o            *          #
#                                #
#                                #
##################################
Score: 30
Use WASD to move, X to quit
```

## 🌟 Features

- **🔗 Linked List Implementation**: Dynamic snake body management
- **🎯 Smart Collision Detection**: Walls and self-collision
- **🍎 Dynamic Food Generation**: Random food placement
- **📊 Score Tracking**: Points system
- **⚡ Smooth Gameplay**: Adjustable game speed
- **🎨 Clean Console UI**: Simple and intuitive interface

## 🏗️ Build Status

[![Build Snake Game](https://github.com/lk-gambhir/snake-game-cpp/actions/workflows/build.yml/badge.svg)](https://github.com/YOUR_USERNAME/snake-game-cpp/actions/workflows/build.yml)

## Technical Details

### Data Structures Used

- **Linked List**: Custom implementation for snake body segments
- **Node Structure**: Each segment contains x,y coordinates and pointer to next segment
- **Dynamic Memory Management**: Proper allocation and deallocation of nodes

### Key Classes

- `SegmentNode`: Represents individual snake body segments
- `Snake`: Manages the linked list of segments and snake operations
- `SnakeGame`: Handles game logic, rendering, and user input

## 🚀 Quick Start

### Download Pre-built Binaries

**[⬇️ Download Latest Release](https://github.com/lk-gambhir/snake-game-cpp/releases)**

Or check the [Actions](https://github.com/lk-gambhir/snake-game-cpp/actions) tab for automatically built binaries.

### Build from Source

#### Prerequisites
- C++ compiler (g++, Visual Studio, etc.)
- Windows/Linux/macOS

#### Windows
```bash
g++ -std=c++11 -Wall -Wextra -O2 -o snake_game.exe main.cpp
./snake_game.exe
```

#### Linux/macOS
```bash
make
./snake_game
```

#### Using VS Code
1. Open folder in VS Code
2. Install C/C++ extension
3. Press `Ctrl+Shift+P` → "Tasks: Run Task" → "Run Snake Game"

## Code Structure

```
snake-game/
├── main.cpp          # Main game implementation
├── README.md         # This file
├── Makefile         # Build configuration
└── .gitignore       # Git ignore file
```

## Screenshots

```
##################################
#                                #
#                                #
#        O                       #
#        o                       #
#        o            *          #
#                                #
#                                #
##################################
Score: 30
Use WASD to move, X to quit
```

## Features Implemented

- ✅ Linked list data structure for snake body
- ✅ Dynamic memory management
- ✅ Collision detection (walls and self)
- ✅ Food generation and consumption
- ✅ Score tracking
- ✅ Game over conditions
- ✅ Smooth gameplay controls

## Learning Objectives

This project demonstrates:
- **Data Structures**: Implementation and usage of linked lists
- **Object-Oriented Programming**: Class design and encapsulation
- **Memory Management**: Dynamic allocation and deallocation
- **Game Development**: Basic game loop and state management
- **Console Programming**: Terminal-based user interface

## Future Enhancements

- [ ] Cross-platform compatibility (Linux/Mac support)
- [ ] High score persistence
- [ ] Multiple difficulty levels
- [ ] Sound effects
- [ ] Color-coded snake segments
- [ ] Power-ups and special food items

## Contributing

Feel free to fork this project and submit pull requests for improvements!

## License

This project is open source and available under the MIT License.
