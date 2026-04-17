
# S.S.M Game Engine Documentation

## Created: (Spazzing Spades Minorities) - S.S.M

Overview: 
This game is a two-player platformer built in Processing. Players can build levels, place traps and power-ups, and race to reach the finish flag. Each time a player reaches the finish, their score boxes fill with color. When all four boxes are filled, the game shows a win screen and loops back to the start for replay.

# Markdown

- [Platform](#platform)<br>
- [Block](#block)<br>
- [SpikeBlock](#spikeblock)<br> 
- [Player](#player)<br>
- [StartFinish](#startfinish)<br>
- [PowerUp](#powerup)<br>
- [BuildMode](#buildmode)<br>
- [PlayMode](#playmode)<br>
- [LevelSaveLoad](#level-saveload)<br>
- [Main](#main)<br>

## Platform Class

**Description**<br>
A simple class that represents a rectangular platform. This platform is used for the start and finish area. It positions the size, and it provides a method to draw the platform on the screen. It is also used in StartFinish.pde to adjust the finish platform based on the window size selected (1400 or 1100). 

**Examples**<br>
Platform ground = new Platform(50, 350, 150, 20);
ground.drawPlatform();

**Constructors**<br>
Platform(float px, float py, float pw, float ph)  
Creates a platform at position (px, py) with width pw and height ph.

**Fields**<br>
float x — X position of the platform<br>
float y — Y position of the platform<br>
float w — Width of the platform<br>
float h — Height of the platform<br>

**Parameters**<br>
px — X coordinate of the platform<br>
py — Y coordinate of the platform<br>
pw — Width of the platform<br>
ph — Height of the platform<br>

**Methods**<br>
drawPlatform() — Draws the platform as a black rectangle.

## Block Class

**Description**<br>
Represents a Solid block that players can stand on or collide with. Each block has a position, size, and color. Used in both Build Mode and Play Mode.

**Examples**<br>
Block b = new Block(200, 300, 100, 200, 100);
b.display();

**Constructors**<br>
Block(float x, float y, int r, int g, int b)  
Creates a block at (x, y) with color (r, g, b)

**Fields**<br>
float x, y — Position of the block<br>
float w, h — Width and height of the block<br>
int r, g, b — Color components of the block<br>

**Parameters**<br>
x — X coordinate<br>
y — Y coordinate<br>
r — Red color value<br>
g — Green color value<br>
b — Blue color value<br>

**Methods**<br>
display() — Draws the block as a colored rectangle.

## SpikeBlock Class

**Description**<br>
A danger block that resets the player's position when touched.  Drawn as a red triangle to represent danger.

**Examples**<br>
SpikeBlock s = new SpikeBlock(400, 300);
s.display();

**Constructors**<br>
SpikeBlock(float x, float y)  
Creates a spike block at (x, y)

**Fields**<br>
float x, y — Position of the spike<br>
float w, h — Size of the spike<br>

**Parameters**<br>
x — X coordinate<br>
y — Y coordinate<br>

**Methods**<br>
display() — Draws a red triangle representing the spike

## Player Class

**Description**<br>
Handles the player's movement, jumping, gravity, collisions, and interactions with spikes and power-ups. Each player has their own controls and color. It also includes two players (red and blue) with independent controls and scoring.
The players can now fall straight down to the bottom of the level; however, they will get reset back to the start platform. This prevents players from resting back to the start off-screen.

**Examples**<br>
Player redPlayer = new Player(80, 308, color(255, 0, 0));
redPlayer.update();
redPlayer.drawPlayer();

**Constructors**<br>
Player(float sx, float sy, int c, int lH) — Creates a player at (sx, sy) with color c and sets the level height limit lH.

**Fields**<br>
float x, y — Player position<br>
float w, h — Player size<br>
float vx, vy — Player velocity<br>
float moveSpeed, jumpPower, gravity — Movement settings<br>
boolean onGround — True if player is standing on something<br>
int col — Player color<br>
boolean arrowMode — True if using arrow keys<br>
int levelHeight — Detects when the player falls below the playable area<br>

**Parameters**<br>
sx — Starting X position<br>
sy — Starting Y position<br>
c — Player color<br>

**Methods**<br>
update() — Runs input, physics, collisions, and power-up checks<br>
handleInput() — Reads key presses for movement and jumping<br>
applyPhysics() — Applies gravity and moves the player<br>
verticalCollide() — Prevents falling through platforms<br>
checkSpikeHit() — Resets player when touching spikes<br>
checkPowerUps() — Detects and applies power-up effects<br>
drawPlayer() — Draws the player as a rectangle<br>
checkWorldVoid() — Checks if the player’s Y position goes below the level height and resets them to the start<br>
death() — Resets the player’s position and velocity after falling off or touching spikes<br>

## StartFinish Class

**Description**<br>
Manages the start and finish areas of the level, including platforms and flags for both players. It also handles resetting the player to the start and detecting when they reach the finish line. It also includes where the finish platform will be located based on the window size, as well as the scoring system that triggers the win screen when a player fills all four boxes. 
The finish platform adjusts automatically based on the window size that is selected. This makes sure that the level layout fits both screen options. When red or blue wins, all placed items are cleared out to start a new, fresh round.

**Examples**<br>
setupStartFinish();
drawStartFinish();
resetPlayersToStart();
checkFinishReached();

**Constructors**<br>
(None — uses global setup functions instead of a class constructor.)
Fields
float startX, startY — Starting position for both players
float finishX, finishY — Position of the finish flag
Platform startPlatform, finishPlatform — Platforms under the start and finish flags
Parameters
(Used in setup functions rather than constructors.)

**Methods**<br>
setupStartFinish() — Creates start and finish platforms and sets flag positions<br>
drawStartFinish() — Draws both platforms and flags<br>
resetPlayersToStart() — Sends both players back to the start area<br>
checkFinishReached() — Checks if either player touches the finish flag and resets the game state<br>
clearAllBuilds() — Clears all placed blocks, spikes, and power‑ups after a win<br>

**Window size Logic**<br>
The finish platform now moves depending on the selected window size:
970 for 1400‑pixel window
670 for 1100‑pixel window

## PowerUp Class

**Description**<br>
Base class for collectible items that give an effect to players. Each power-up has a position and size, and can apply an effect when picked up. The child classes are SpeedPowerUp (which increases movement speed; it stacks and never removes itself) and BombPowerUp (which clears all blocks and spikes based on a certain radius, only if it's on the edges of a block or spike, then it will destroy it if the player touches it)

**Child Classes**<br>
SpeedPowerUp — Temporarily increases player speed.
BombPowerUp — Destroys nearby blocks and spikes, turning the screen red briefly

**Examples**<br>
PowerUp p = new PowerUp(200, 200);
p.display();
p.apply(player);

**Constructors**<br>
PowerUp(float x, float y)  
Creates a power-up at position (x, y).
Fields
float x, y — Position of the power-up
float size — Size of the power-up’s visual representation

**Parameters**<br>
x — X coordinate<br>
y — Y coordinate<br>

**Methods**<br>
display() — Draws the power-up on screen<br>
apply(Player p) — Applies the power-up’s effect to the player<br>
(Derived classes like SpeedPowerUp and BombPowerUp override apply() to define specific effects.)<br>

## BuildMode Class

**Description**<br>
This handles the level-building, where players can place blocks, spikes, and power-ups before testing the level. Includes inventory buttons and placement of transparent previews. It also includes a score box system for both red and blue that will fill with color when players reach the finish. 
In build mode, there are score boxes for both the red player and the blue player. The right side is the red scoreboard, and the left side is the blue scoreboard. Each time a player reaches the finish, they get one boc filled with their color. When all four boxes are filled. The game triggers the win screen. 

**Examples**<br>
drawBuildMode();
drawInventory();
drawBlocks();
drawPlacementPreview();
drawScoreBoxes();


**Constructors**<br>
(None — functions operate globally.)

**Fields**<br>
ArrayList<Block> onScreenBlocks — List of placed blocks<br>
ArrayList<SpikeBlock> spikeBlocks — List of placed spikes<br>
ArrayList<PowerUp> powerUps — List of placed power-ups<br>
boolean holdingBlock, holdingSpike, holdingPowerUp — Track selected item type<br>
int sidePanelWidth — Width of the build menu panel<br>

**Methods**<br>
drawBuildMode() — Draws the build screen and UI<br>
drawInventory() — Displays item buttons for placement<br>
drawBlocks() — Draws all placed objects<br>
drawPlacementPreview() — Shows a transparent preview of the selected item under the mouse<br>
drawScoreBoxes() — Creates four empty boxes per player and fills them with color when points are earned<br>

## PlayMode Class

**Description**<br>
This class controls the gameplay, where players can move, jump, and interact with placed objects such as blocks, spikes, and powerups. It also updates the player's status and checks for level completion. It also has a two-player scoring system and a win screen transition. 

**Examples**<br>
drawPlayMode();
redPlayer.update();
bluePlayer.update();

**Constructors**<br>
(None — functions operate globally.)

**Fields**<br>
Player redPlayer, bluePlayer — The two player objects<br>
ArrayList<Block> onScreenBlocks — Placed blocks<br>
ArrayList<SpikeBlock> spikeBlocks — Placed spikes<br>
ArrayList<PowerUp> powerUps — Active power-ups<br>

**Methods**<br>
drawPlayMode() — Draws the level and updates both players<br>
checkFinishReached() — Detects when a player reaches the finish flag<br>
resetPlayersToStart() — Resets both players to the start position<br>

## LevelSaveLoad Class

**Description**<br>
This class handles saving and loading the level data from a text file. Each object type (block, spike, power-up) is stored as a line in the file. It also updates to include power-up saving and loading for the Speed and Bomb types. 

**Examples**<br>
saveLevel();
loadLevel();

**Constructors**<br>
(None — uses global functions.)

**Fields**<br>
String fullPath — Path to the save file<br>
ArrayList<Block> onScreenBlocks — Blocks to save or load<br>
ArrayList<SpikeBlock> spikeBlocks — Spikes to save or load<br>
ArrayList<PowerUp> powerUps — Power-ups to save or load<br>

**Methods**<br>
saveLevel() — Writes all placed objects to a file<br>
loadLevel() — Reads objects from a file and recreates them in the level<br>

## Main Class

**Description**<br>
This class is the overall game flow, including setup, drawing, input handling, and switching between game states (Start, Build, Play). It also sets the players to their starting position, manages the world, and coordinates all other systems like blocks, spikes, and power-ups. It also includes selectable window sizes, a win screen, and a scoring system that loops back to the start screen if the blue or red wins. 
The main tab also includes a start menu with an option of selectable window sizes, which are (1400 original or 1100 smaller). It also tracks players' scores and plays the win screen when one player reaches a total of 4 points. After the win, all placed items are cleared out so that it can restart the gameplay cleanly. 

**Examples**<br>
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

**Constructors**<br>
(None — uses Processing’s built-in setup() and draw() functions.)

**Fields**<br>
boolean[] keyDown — Tracks which keys are held down for smoother movement<br>
Player redPlayer, bluePlayer — The two player objects<br>
int worldWidth, worldHeight — Size of the full level area<br>
ArrayList<Block> onScreenBlocks — List of placed blocks<br>
ArrayList<SpikeBlock> spikeBlocks — List of placed spikes<br>
ArrayList<PowerUp> powerUps — List of placed power-ups<br>
boolean holdingBlock, holdingSpike, holdingPowerUp — Track selected item type for placement<br>
boolean holdingSpeedPowerUp, holdingBombPowerUp — Track specific power-up types<br>
int gameState — Current game mode (0 = Start, 1 = Build, 2 = Play)<br>
int sidePanelWidth — Width of the build menu panel<br>
int selectedSize — Stores the chosen window size (1400 or 1100)<br>
int redScore, blueScore — Track each player’s score<br>
int winner — Determines which player won (1 = red, 2 = blue)<br>

**Parameters**<br>
(Used in setup and event functions rather than constructors.)

**Methods**<br>
settings() — Sets the window size for the game<br>
setup() — Initializes start/finish platforms and both players<br>
draw() — Main game loop; switches between Start, Build, and Play modes<br>
mousePressed() — Handles clicks for switching states and placing items<br>
keyPressed() — Handles keyboard input for switching modes and saving/loading levels<br>
keyReleased() — Updates key states when keys are released<br>
drawStartMenu() — Displays the start screen with selectable window sizes<br>
drawWinScreen() — Shows the winner and lets players restart<br>
mousePressed() — Handles clicks for starting the game, selecting window size, and placing items<br>
clearAllBuilds() — Removes all placed objects after a win for a fresh start<br>
