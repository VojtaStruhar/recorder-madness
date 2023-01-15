# Recorder game

This project contains 2 minigames that are controlled by you playing a recorder. One is a *Tyrian*-ish clone and the other is a *Guitar Hero*-inspired song-playing game.

The game takes a microphone input, analyzes the input frequency, and chops it into small pieces corresponding to musical notes. Whatever part of the frequency spectrum has the biggest magnitude is considered to match the played note.

## Game engine

This game was developed with the [Godot game engine](https://godotengine.org).

The precise version is `v3.5.stable.official [991bb6ac7]`, but generally 3.5 and up should be just fine. As of the time of this writing, Godot 4 is in beta - that's why I didn't go for the newest version. I think that the project should be easily upgradeable.

## Known issues

### Mac OS

There is an [issue](https://github.com/godotengine/godot/issues/64583) with microphone input on macOS. Set the input format frequency to `44 100 Hz` for Godot to be able to recognize it. This menu is found in the **Audio MIDI Setup** app. 

Tested on M2 Macbook Air.

![image](https://user-images.githubusercontent.com/5861833/185453761-e3b348ab-be8e-4fec-9db1-b642b38b57c6.png)



---

> This game was done as a project for Human-Computer Interaction Laboratory at FI MUNI.

Vojtěch Struhár, 2022; Created with Godot <img src="icon.png" style="height: 24px"/> 