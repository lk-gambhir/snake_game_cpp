#!/bin/bash

# Script to create a new release
# Usage: ./create_release.sh v1.0.0

VERSION=$1

if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 v1.0.0"
    exit 1
fi

echo "Creating release $VERSION..."

# Build for different platforms
echo "Building Windows version..."
g++ -std=c++11 -Wall -Wextra -O2 -o snake_game_windows.exe main.cpp

echo "Building Linux version..."
# Create Linux-compatible version
sed 's/#include <conio.h>/#include <termios.h>\n#include <unistd.h>/' main.cpp > main_linux.cpp
sed -i 's/#include <windows.h>//' main_linux.cpp
sed -i 's/_kbhit()/kbhit()/' main_linux.cpp
sed -i 's/_getch()/getch()/' main_linux.cpp
sed -i 's/system("cls")/system("clear")/' main_linux.cpp
sed -i 's/Sleep(100)/usleep(100000)/' main_linux.cpp

# Add Linux functions
cat > linux_compat.cpp << 'EOF'
#include <termios.h>
#include <unistd.h>
#include <sys/select.h>

int kbhit() {
    struct timeval tv = {0, 0};
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(STDIN_FILENO, &fds);
    return select(STDIN_FILENO + 1, &fds, NULL, NULL, &tv);
}

int getch() {
    struct termios oldt, newt;
    int ch;
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);
    ch = getchar();
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    return ch;
}

EOF

cat linux_compat.cpp main_linux.cpp > snake_linux.cpp
g++ -std=c++11 -Wall -Wextra -O2 -o snake_game_linux snake_linux.cpp

echo "Creating ZIP archives..."
zip -r snake_game_windows_$VERSION.zip snake_game_windows.exe README.md
zip -r snake_game_linux_$VERSION.zip snake_game_linux README.md

echo "Release files created:"
echo "- snake_game_windows_$VERSION.zip"
echo "- snake_game_linux_$VERSION.zip"

echo "Now:"
echo "1. git tag $VERSION"
echo "2. git push origin $VERSION"
echo "3. Create release on GitHub and upload the ZIP files"

# Clean up
rm -f main_linux.cpp linux_compat.cpp snake_linux.cpp