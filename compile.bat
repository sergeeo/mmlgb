@echo off
PATH=%PATH%;%~dp0\gbdk\bin

java.exe -jar parser\MMLGB.jar music\%1 driver\song.asm
if %errorlevel% neq 0 (
	pause
	exit /b %errorlevel%
)

lcc.exe -c driver\player.c -o driver\player.o
lcc.exe -c driver\music.c -o driver\music.o
lcc.exe -c driver\song.asm -o driver\song.o
lcc.exe -c driver\freq.c -o driver\freq.o
lcc.exe -c driver\noisefreq.c -o driver\noisefreq.o
lcc.exe -c driver\vib.c -o driver\vib.o
lcc.exe driver\player.o driver\music.o driver\song.o driver\freq.o driver\noisefreq.o driver\vib.o -o rom.gb

if %errorlevel% neq 0 (
	echo Error compiling rom!
	pause
	exit /b %errorlevel%
)

echo %~nx0 compiled to rom.gb successfully!

C:\gbdk\bin\bgb\BGB.exe rom.gb
