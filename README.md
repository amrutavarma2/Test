# C++ Environment — Minimal Starter (Windows)

This workspace contains a minimal C++ project and VS Code configs for Windows.

Prerequisites (pick one):
- MSYS2 (recommended): https://www.msys2.org/
- Visual Studio Build Tools (cl.exe)
- WSL (Ubuntu) with `build-essential`

Quick MSYS2 setup (64-bit):
```powershell
# inside an elevated PowerShell
# 1. Install MSYS2 from https://www.msys2.org/
# 2. Open "MSYS2 MinGW 64-bit" and run:
pacman -Syu
pacman -S --needed mingw-w64-x86_64-toolchain cmake make git

# Add to PATH (example):
# setx PATH "%PATH%;C:\msys64\mingw64\bin"
```

Build with g++ (simple):
```powershell
mkdir bin
g++ -g src/main.cpp -std=c++17 -O0 -o bin/main.exe
.\bin\main.exe
```

Build with CMake (recommended):
```powershell
mkdir build
cd build
cmake -G "MinGW Makefiles" ..
cmake --build . --config Debug
cd ..\bin
./main.exe
```

If you use Visual Studio Build Tools, open a Developer Command Prompt and build with `cl` or use the CMake generator for Visual Studio.

VS Code
- There are VS Code tasks in `.vscode/tasks.json` to build and run using `g++` or CMake.
- The debug configuration in `.vscode/launch.json` targets the output `bin/main.exe` and expects a gdb-compatible debugger (MinGW gdb or WSL gdb).

If you'd like, I can try to build the project now or adjust configs for MSVC/WSL — tell me which toolchain you prefer.
