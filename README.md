[S.S.M Documentation  (1).pdf](https://github.com/user-attachments/files/26103286/S.S.M.Documentation.1.pdf)




# S.S.M Game Engine Documentation
## Created: (Spazing Spades Minorities) - S.S.M
This document explains how our 2‑player platformer engine works and what each part of the code does. 
## 1. What This Engine Is
This is our small 2-player platformer engine.
It’s inspired by Ultimate Chicken Horse, but way simpler.
You can build the level first, then switch to play mode and try to beat it.
The idea is that the engine should be reusable later when we make an actual game.
The engine isn’t “finished,” it’s just the base we’re building on.
## 2. How the Game Works (basic loop)
Start Screen
The game starts on a plain grey screen that says “Start.”
You click anywhere, and it takes you to Build Mode.
Build Mode
You can place blocks or spikes.
There’s a side panel on the right with buttons.
Click a button, and you’re holding that item.
Click the world it places the item.
Play Mode
Both players spawn at the start platform.
Red uses WASD, blue uses arrow keys.
You run, jump, avoid spikes, and try to reach the finish flag.
If you touch the finish, it sends you back to Build Mode.
## 3. How the Code Is Organized
We split everything into tabs so it’s not all in one giant file.
Main.pde
This is the “brain” of the whole game.
It decides which screen to show (start, build, play).
It creates the players.
It handles input like key presses and mouse clicks.
It also stores the lists of blocks and spikes.
BuildMode.pde
This draws everything you see while building:
the world area
the side panel
the buttons
all the blocks/spikes you placed
the preview of the item you’re holding
It also shows the instructions like “Press P to Play.”
PlayMode.pde
This runs the actual gameplay:
draws the platforms
draws all blocks and spikes
updates both players
checks if someone reached the finish
LevelSaveLoad.pde
This handles saving and loading the level.
Press S saves all block and spike positions to a text file.
Press L loads them back in.
Player.pde
This is the player class.
It handles:
movement
gravity
jumping
collisions
spike detection
drawing the player
Red uses WASD.
Blue uses the arrow keys.
Platform.pde
Just a simple rectangle platform.
Used for the start and finish platforms.
Block.pde
This is the normal block you place in Build Mode.
It’s always 50x50.
It has a color and a position.
SpikeBlock.pde
This is the spike trap.
Also 50x50.
Drawn as a red triangle.
If a player touches it, they reset to the start.
StartFinish.pde
This sets up the start and finish platforms and the flags.
It also checks if a player reached the finish.
## 4. How the Engine Actually Runs all together
The start screen shows
Click anywhere on the screen to activate Build Mode
Place blocks/spikes
Press P to activate Play Mode
Players move and try to reach the finish
If someone reaches the finish line, they get sent back to Build Mode
Repeat
The engine keeps everything in lists, so the blocks stay where you put them.
The players use simple physics (gravity, velocity).
Collisions only check vertically to keep things simple.
## 5. Why We Built It This Way
We wanted something:
easy to understand
easy to add new features to
not too complicated
good enough to build a real game later
Splitting everything into tabs makes it easier to find stuff.
Using simple shapes (rectangles, triangles) makes testing faster.
Saving and loading help us reuse levels.
## 6. What We Can Add Later
This engine is still a work in progress, but it’s just the base.
Future ideas:
more item types
deleting items
rotating items
better movement (dash, wall jump, double jump)
scoring system
rounds
better death effects
more traps



