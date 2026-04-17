
# S.S.M Game Engine Documentation
## Created: (Spazing Spades Minorities) - S.S.M

Overview: 
This game is a two-player platformer built in Processing. Players can build levels, place traps and power-ups, and race to reach the finish flag. Each time a player reaches the finish, their score boxes fill with color. When all four boxes are filled, the game shows a win screen and loops back to the start for replay.

# Markdown

[Platform](#platform)
[Block](#block)
[SpikeBlock](#spikeblock)
[Player](#player)
[StartFinish](#startfinish)
[PowerUp](#powerup)
[BuildMode](#buildmode)
[PlayMode](#playmode)
[LevelSaveLoad](#level-saveload)
[Main](#main)

### Class Name
## Platform
**Description**
A simple class that represents a rectangular platform. This platform is used for the start and finish area. It positions the size, and it provides a method to draw the platform on the screen. It is also used in StartFinish.pde to adjust the finish platform based on the window size selected (1400 or 1100). 

**Examples**
Platform ground = new Platform(50, 350, 150, 20);
ground.drawPlatform();

**Constructors**
Platform(float px, float py, float pw, float ph)  
Creates a platform at position (px, py) with width pw and height ph.

**Fields**
float x — X position of the platform
float y — Y position of the platform
float w — Width of the platform
float h — Height of the platform

**Parameters**
px — X coordinate of the platform
py — Y coordinate of the platform
pw — Width of the platform
ph — Height of the platform

**Methods**
drawPlatform() — Draws the platform as a black rectangle.

### Class Name
## Block
**Description**
Represents a Solid block that players can stand on or collide with. Each block has a position, size, and color. Used in both Build Mode and Play Mode.

**Examples**
Block b = new Block(200, 300, 100, 200, 100);
b.display();

**Constructors**
Block(float x, float y, int r, int g, int b)  
Creates a block at (x, y) with color (r, g, b)

**Fields**
float x, y — Position of the block
float w, h — Width and height of the block
int r, g, b — Color components of the block

**Parameters**
x — X coordinate
y — Y coordinate
r — Red color value
g — Green color value
b — Blue color value

**Methods**
display() — Draws the block as a colored rectangle.

### Class Name
## SpikeBlock
**Description**
A danger block that resets the player's position when touched.  Drawn as a red triangle to represent danger.

**Examples**
SpikeBlock s = new SpikeBlock(400, 300);
s.display();

**Constructors**
SpikeBlock(float x, float y)  
Creates a spike block at (x, y)

**Fields**
float x, y — Position of the spike
float w, h — Size of the spike

**Parameters**
x — X coordinate
y — Y coordinate

**Methods**
display() — Draws a red triangle representing the spike

### Class Name
## Player
**Description**
Handles the player's movement, jumping, gravity, collisions, and interactions with spikes and power-ups. Each player has their own controls and color. It also includes two players (red and blue) with independent controls and scoring.
The players can now fall straight down to the bottom of the level; however, they will get reset back to the start platform. This prevents players from resting back to the start off-screen.

**Examples**
Player redPlayer = new Player(80, 308, color(255, 0, 0));
redPlayer.update();
redPlayer.drawPlayer();

**Constructors**
Player(float sx, float sy, int c, int lH) — Creates a player at (sx, sy) with color c and sets the level height limit lH.

**Fields**
float x, y — Player position
float w, h — Player size
float vx, vy — Player velocity
float moveSpeed, jumpPower, gravity — Movement settings
boolean onGround — True if player is standing on something
int col — Player color
boolean arrowMode — True if using arrow keys
int levelHeight — Detects when the player falls below the playable area

**Parameters**
sx — Starting X position
sy — Starting Y position
c — Player color

**Methods**
update() — Runs input, physics, collisions, and power-up checks
handleInput() — Reads key presses for movement and jumping
applyPhysics() — Applies gravity and moves the player
verticalCollide() — Prevents falling through platforms
checkSpikeHit() — Resets player when touching spikes
checkPowerUps() — Detects and applies power-up effects
drawPlayer() — Draws the player as a rectangle
checkWorldVoid() — Checks if the player’s Y position goes below the level height and resets them to the start
death() — Resets the player’s position and velocity after falling off or touching spikes

### Class Name
## StartFinish
**Description**
Manages the start and finish areas of the level, including platforms and flags for both players. It also handles resetting the player to the start and detecting when they reach the finish line. It also includes where the finish platform will be located based on the window size, as well as the scoring system that triggers the win screen when a player fills all four boxes. 
The finish platform adjusts automatically based on the window size that is selected. This makes sure that the level layout fits both screen options. When red or blue wins, all placed items are cleared out to start a new, fresh round.

**Examples**
setupStartFinish();
drawStartFinish();
resetPlayersToStart();
checkFinishReached();

**Constructors**
(None — uses global setup functions instead of a class constructor.)
Fields
float startX, startY — Starting position for both players
float finishX, finishY — Position of the finish flag
Platform startPlatform, finishPlatform — Platforms under the start and finish flags
Parameters
(Used in setup functions rather than constructors.)

**Methods**
setupStartFinish() — Creates start and finish platforms and sets flag positions
drawStartFinish() — Draws both platforms and flags
resetPlayersToStart() — Sends both players back to the start area
checkFinishReached() — Checks if either player touches the finish flag and resets the game state
clearAllBuilds() — Clears all placed blocks, spikes, and power‑ups after a win

**Window size Logic**
The finish platform now moves depending on the selected window size:
970 for 1400‑pixel window
670 for 1100‑pixel window

### Class Name
## PowerUp
**Description**
Base class for collectible items that give an effect to players. Each power-up has a position and size, and can apply an effect when picked up. The child classes are SpeedPowerUp (which increases movement speed; it stacks and never removes itself) and BombPowerUp (which clears all blocks and spikes based on a certain radius, only if it's on the edges of a block or spike, then it will destroy it if the player touches it)

**Child Classes**
SpeedPowerUp — Temporarily increases player speed.
BombPowerUp — Destroys nearby blocks and spikes, turning the screen red briefly

**Examples**
PowerUp p = new PowerUp(200, 200);
p.display();
p.apply(player);

**Constructors**
PowerUp(float x, float y)  
Creates a power-up at position (x, y).
Fields
float x, y — Position of the power-up
float size — Size of the power-up’s visual representation

**Parameters**
x — X coordinate
y — Y coordinate

**Methods**
display() — Draws the power-up on screen
apply(Player p) — Applies the power-up’s effect to the player
(Derived classes like SpeedPowerUp and BombPowerUp override apply() to define specific effects.)

### Class Name
## BuildMode
**Description**
This handles the level-building, where players can place blocks, spikes, and power-ups before testing the level. Includes inventory buttons and placement of transparent previews. It also includes a score box system for both red and blue that will fill with color when players reach the finish. 
In build mode, there are score boxes for both the red player and the blue player. The right side is the red scoreboard, and the left side is the blue scoreboard. Each time a player reaches the finish, they get one boc filled with their color. When all four boxes are filled. The game triggers the win screen. 

**Examples**
drawBuildMode();
drawInventory();
drawBlocks();
drawPlacementPreview();
drawScoreBoxes();


**Constructors**
(None — functions operate globally.)

**Fields**
ArrayList<Block> onScreenBlocks — List of placed blocks
ArrayList<SpikeBlock> spikeBlocks — List of placed spikes
ArrayList<PowerUp> powerUps — List of placed power-ups
boolean holdingBlock, holdingSpike, holdingPowerUp — Track selected item type
int sidePanelWidth — Width of the build menu panel

**Methods**
drawBuildMode() — Draws the build screen and UI
drawInventory() — Displays item buttons for placement
drawBlocks() — Draws all placed objects
drawPlacementPreview() — Shows a transparent preview of the selected item under the mouse
drawScoreBoxes() — Creates four empty boxes per player and fills them with color when points are earned

### Class Name
## PlayMode
**Description**
This class controls the gameplay, where players can move, jump, and interact with placed objects such as blocks, spikes, and powerups. It also updates the player's status and checks for level completion. It also has a two-player scoring system and a win screen transition. 

**Examples**
drawPlayMode();
redPlayer.update();
bluePlayer.update();

**Constructors**
(None — functions operate globally.)

**Fields**
Player redPlayer, bluePlayer — The two player objects
ArrayList<Block> onScreenBlocks — Placed blocks
ArrayList<SpikeBlock> spikeBlocks — Placed spikes
ArrayList<PowerUp> powerUps — Active power-ups

**Methods**
drawPlayMode() — Draws the level and updates both players
checkFinishReached() — Detects when a player reaches the finish flag
resetPlayersToStart() — Resets both players to the start position

### Class Name
## LevelSaveLoad
**Description**
This class handles saving and loading the level data from a text file. Each object type (block, spike, power-up) is stored as a line in the file. It also updates to include power-up saving and loading for the Speed and Bomb types. 

**Examples**
saveLevel();
loadLevel();

**Constructors**
(None — uses global functions.)

**Fields**
String fullPath — Path to the save file
ArrayList<Block> onScreenBlocks — Blocks to save or load
ArrayList<SpikeBlock> spikeBlocks — Spikes to save or load
ArrayList<PowerUp> powerUps — Power-ups to save or load

**Methods**
saveLevel() — Writes all placed objects to a file
loadLevel() — Reads objects from a file and recreates them in the level

### Class Name
## Main
**Description**
This class is the overall game flow, including setup, drawing, input handling, and switching between game states (Start, Build, Play). It also sets the players to their starting position, manages the world, and coordinates all other systems like blocks, spikes, and power-ups. It also includes selectable window sizes, a win screen, and a scoring system that loops back to the start screen if the blue or red wins. 
The main tab also includes a start menu with an option of selectable window sizes, which are (1400 original or 1100 smaller). It also tracks players' scores and plays the win screen when one player reaches a total of 4 points. After the win, all placed items are cleared out so that it can restart the gameplay cleanly. 

**Examples**
void setup() {
  setupStartFinish();
  redPlayer = new Player(startX, startY, color(255, 0, 0));
  bluePlayer = new Player(startX + 40, startY, color(0, 120, 255));
}

void draw() {
  if (gameState == 0) {
    // Start screen
  } else if (gameState == 1) {
    drawBuildMode();
  } else if (gameState == 2) {
    drawPlayMode();
  }
}

**Constructors**
(None — uses Processing’s built-in setup() and draw() functions.)

**Fields**
boolean[] keyDown — Tracks which keys are held down for smoother movement
Player redPlayer, bluePlayer — The two player objects
int worldWidth, worldHeight — Size of the full level area
ArrayList<Block> onScreenBlocks — List of placed blocks
ArrayList<SpikeBlock> spikeBlocks — List of placed spikes
ArrayList<PowerUp> powerUps — List of placed power-ups
boolean holdingBlock, holdingSpike, holdingPowerUp — Track selected item type for placement
boolean holdingSpeedPowerUp, holdingBombPowerUp — Track specific power-up types
int gameState — Current game mode (0 = Start, 1 = Build, 2 = Play)
int sidePanelWidth — Width of the build menu panel
int selectedSize — Stores the chosen window size (1400 or 1100)
int redScore, blueScore — Track each player’s score
int winner — Determines which player won (1 = red, 2 = blue)

**Parameters**
(Used in setup and event functions rather than constructors.)

**Methods**
settings() — Sets the window size for the game
setup() — Initializes start/finish platforms and both players
draw() — Main game loop; switches between Start, Build, and Play modes
mousePressed() — Handles clicks for switching states and placing items
keyPressed() — Handles keyboard input for switching modes and saving/loading levels
keyReleased() — Updates key states when keys are released
drawStartMenu() — Displays the start screen with selectable window sizes
drawWinScreen() — Shows the winner and lets players restart
mousePressed() — Handles clicks for starting the game, selecting window size, and placing items
clearAllBuilds() — Removes all placed objects after a win for a fresh start

