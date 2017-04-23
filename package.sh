#!/bin/sh
cd ./Source
godot -export "Linux X11" ../Packaged/LanceKnight_Linux64
godot -export "Windows Desktop" ../Packaged/LanceKnight_Windows64.exe
godot -export "HTML5" ../LanceKnight.html
cd ../
zip -r ./Packaged/HTML5.zip ./data.pck ./LanceKnight.asm.js ./LanceKnight.html ./LanceKnight.js ./LanceKnight.mem ./LanceKnightfs.js
zip -r ./Packaged/Source.zip ./Source/*
chmod +x ./Packaged/LanceKnight_Linux64
chmod +x ./Packaged/LanceKnight_Windows64
