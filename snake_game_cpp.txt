#include <iostream>
#include <conio.h>
#include <windows.h>
#include <cstdlib>
#include <ctime>

using namespace std;

// Node structure for the snake's body segments
struct SegmentNode {
    int x, y;
    SegmentNode* next;
    
    SegmentNode(int x_pos, int y_pos) : x(x_pos), y(y_pos), next(nullptr) {}
};

// Snake class using linked list
class Snake {
private:
    SegmentNode* head;
    SegmentNode* tail;
    int size;
    
public:
    Snake(int startX, int startY) {
        head = new SegmentNode(startX, startY);
        tail = head;
        size = 1;
    }
    
    ~Snake() {
        while (head != nullptr) {
            SegmentNode* temp = head;
            head = head->next;
            delete temp;
        }
    }
    
    void addSegment(int x, int y) {
        SegmentNode* newSegment = new SegmentNode(x, y);
        tail->next = newSegment;
        tail = newSegment;
        size++;
    }
    
    void moveSnake(int newHeadX, int newHeadY) {
        // Add new head
        SegmentNode* newHead = new SegmentNode(newHeadX, newHeadY);
        newHead->next = head;
        head = newHead;
        
        // Remove tail (since we're not growing)
        if (size > 1) {
            SegmentNode* current = head;
            while (current->next != tail) {
                current = current->next;
            }
            delete tail;
            tail = current;
            tail->next = nullptr;
        }
    }
    
    void grow(int newHeadX, int newHeadY) {
        // Add new head without removing tail
        SegmentNode* newHead = new SegmentNode(newHeadX, newHeadY);
        newHead->next = head;
        head = newHead;
        size++;
    }
    
    bool checkSelfCollision() {
        SegmentNode* current = head->next;
        while (current != nullptr) {
            if (head->x == current->x && head->y == current->y) {
                return true;
            }
            current = current->next;
        }
        return false;
    }
    
    int getHeadX() { return head->x; }
    int getHeadY() { return head->y; }
    int getSize() { return size; }
    
    void printSnake() {
        SegmentNode* current = head;
        while (current != nullptr) {
            cout << "(" << current->x << "," << current->y << ") ";
            current = current->next;
        }
        cout << endl;
    }
    
    bool isSnakePosition(int x, int y) {
        SegmentNode* current = head;
        while (current != nullptr) {
            if (current->x == x && current->y == y) {
                return true;
            }
            current = current->next;
        }
        return false;
    }
};

// Game class
class SnakeGame {
private:
    static const int WIDTH = 40;
    static const int HEIGHT = 20;
    Snake* snake;
    int foodX, foodY;
    int score;
    bool gameOver;
    char direction;
    
public:
    SnakeGame() {
        snake = new Snake(WIDTH/2, HEIGHT/2);
        generateFood();
        score = 0;
        gameOver = false;
        direction = 'd'; // Start moving right
        srand(time(0));
    }
    
    ~SnakeGame() {
        delete snake;
    }
    
    void generateFood() {
        do {
            foodX = rand() % WIDTH;
            foodY = rand() % HEIGHT;
        } while (snake->isSnakePosition(foodX, foodY));
    }
    
    void gotoxy(int x, int y) {
        COORD coord;
        coord.X = x;
        coord.Y = y;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
    }
    
    void draw() {
        system("cls");
        
        // Draw top border
        for (int i = 0; i < WIDTH + 2; i++) {
            cout << "#";
        }
        cout << endl;
        
        // Draw game area
        for (int y = 0; y < HEIGHT; y++) {
            cout << "#"; // Left border
            for (int x = 0; x < WIDTH; x++) {
                if (x == snake->getHeadX() && y == snake->getHeadY()) {
                    cout << "O"; // Snake head
                } else if (snake->isSnakePosition(x, y)) {
                    cout << "o"; // Snake body
                } else if (x == foodX && y == foodY) {
                    cout << "*"; // Food
                } else {
                    cout << " ";
                }
            }
            cout << "#" << endl; // Right border
        }
        
        // Draw bottom border
        for (int i = 0; i < WIDTH + 2; i++) {
            cout << "#";
        }
        cout << endl;
        
        // Display score
        cout << "Score: " << score << endl;
        cout << "Use WASD to move, X to quit" << endl;
    }
    
    void input() {
        if (_kbhit()) {
            char key = _getch();
            switch (key) {
                case 'w':
                case 'W':
                    if (direction != 's') direction = 'w';
                    break;
                case 's':
                case 'S':
                    if (direction != 'w') direction = 's';
                    break;
                case 'a':
                case 'A':
                    if (direction != 'd') direction = 'a';
                    break;
                case 'd':
                case 'D':
                    if (direction != 'a') direction = 'd';
                    break;
                case 'x':
                case 'X':
                    gameOver = true;
                    break;
            }
        }
    }
    
    void logic() {
        int newHeadX = snake->getHeadX();
        int newHeadY = snake->getHeadY();
        
        // Move based on direction
        switch (direction) {
            case 'w': newHeadY--; break;
            case 's': newHeadY++; break;
            case 'a': newHeadX--; break;
            case 'd': newHeadX++; break;
        }
        
        // Check wall collision
        if (newHeadX < 0 || newHeadX >= WIDTH || newHeadY < 0 || newHeadY >= HEIGHT) {
            gameOver = true;
            return;
        }
        
        // Check if food is eaten
        bool ateFood = (newHeadX == foodX && newHeadY == foodY);
        
        if (ateFood) {
            snake->grow(newHeadX, newHeadY);
            score += 10;
            generateFood();
        } else {
            snake->moveSnake(newHeadX, newHeadY);
        }
        
        // Check self collision
        if (snake->checkSelfCollision()) {
            gameOver = true;
        }
    }
    
    void run() {
        while (!gameOver) {
            draw();
            input();
            logic();
            Sleep(100); // Control game speed
        }
        
        system("cls");
        cout << "Game Over!" << endl;
        cout << "Final Score: " << score << endl;
        cout << "Press any key to exit...";
        _getch();
    }
};

int main() {
    cout << "=== SNAKE GAME ===" << endl;
    cout << "Controls:" << endl;
    cout << "W - Move Up" << endl;
    cout << "S - Move Down" << endl;
    cout << "A - Move Left" << endl;
    cout << "D - Move Right" << endl;
    cout << "X - Quit Game" << endl;
    cout << "\nPress any key to start...";
    _getch();
    
    SnakeGame game;
    game.run();
    
    return 0;
}