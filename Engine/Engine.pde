// PLAYER CLASS
// Handles movement jumping gravity collisions and spike resets for each player
class Player {

  // Player position on screen
  float x, y;

// Player size (hitbox) used for collisions
  float w = 28, h = 42;
 
  // Player movement speed and falling speed
  float vx = 0;  
  float vy = 0; 

// Handles movement, jumping, and gravity for each player
// Keeps motion smooth and simple for testing
  float moveSpeed = 4;   // walking speed
  float jumpPower = -10; // jump strength
  float gravity = 0.5;   // falling speed


  
    // True when the player is standing on something
  boolean onGround = false;

  // Player color
  int col;

  // True if using arrow keys instead of WASD
  boolean arrowMode = false;

  // WASD keys for red player
  int redLeft, redRight, redJump;

 // Arrow key codes for blue player
  int blueLeft, blueRight, blueJump;

  // Starting position for respawning
  float startX, startY;

 // y level detector for player death
  int levelHeight;

  // Sets starting position, color, and control scheme
  Player(float sx, float sy, int c, int lH) {
    x = sx;
    y = sy;
  
  // Save start position
    startX = sx;
    startY = sy;

    col = c;
    
    this.levelHeight = lH;
    
// Red player uses WASD
    if (c == color(255, 0, 0)) {
      redLeft = 'a';
      redRight = 'd';
      redJump = 'w';
    }
  // Blue player uses arrow keys
    else {
      arrowMode = true;
      blueLeft = LEFT;
      blueRight = RIGHT;
      blueJump = UP;
    }
  }

 // UPDATE
  // Runs every frame such as input, physics, collisions, spikes
  void update() {
    handleInput(); // Checks which movement keys are pressed for this player
    applyPhysics(); // Adds gravity and moves the player based on speed
    verticalCollide(); // Stops the player from falling through platforms or blocks
    checkSpikeHit(); // If the player touches a spike, they return to the starting spot
    checkPowerUps(); // Checks if player has picked up a power up
    checkWorldVoid();// Checks if the player has gone below allowed Y level
  } 

 // HANDLE INPUT
  // Checks held keys and moves the player
  void handleInput() {
    boolean leftPressed, rightPressed, jumpPressed;
  
    // WASD controls
    if (!arrowMode) {
      leftPressed = keyDown[redLeft];
      rightPressed = keyDown[redRight];
      jumpPressed = keyDown[redJump];
    }
   
      // Arrow key controls
    else {
      leftPressed = keyDown[blueLeft];
      rightPressed = keyDown[blueRight];
      jumpPressed = keyDown[blueJump];
    }
   
    // Move left or right
    if (leftPressed) vx = -moveSpeed;
    else if (rightPressed) vx = moveSpeed;
    else vx = 0;

 // Jump only when on ground
    if (jumpPressed && onGround) {
      vy = jumpPower;
      onGround = false;
    }
  }

// APPLY PHYSICS
  // Adds gravity and moves player based on speed
  void applyPhysics() {
    vy += gravity; // falling
    x += vx;       // horizontal move
    y += vy;       // vertical move
  }

 // VERTICAL COLLISION
  // Stops player from falling through platforms or blocks
  // Only checks vertical collisions to keep things simple
  void verticalCollide() {
    onGround = false;

    // Start platform collision
    if (x + w > startPlatform.x && x < startPlatform.x + startPlatform.w) {
      if (vy > 0 && y + h >= startPlatform.y && y + h <= startPlatform.y + startPlatform.h) {
        y = startPlatform.y - h;
        vy = 0;
        onGround = true;
      }
    }
    // Finish platform collision
    if (x + w > finishPlatform.x && x < finishPlatform.x + finishPlatform.w) {
      if (vy > 0 && y + h >= finishPlatform.y && y + h <= finishPlatform.y + finishPlatform.h) {
        y = finishPlatform.y - h;
        vy = 0;
        onGround = true;
      }
    }
  for (Block b : onScreenBlocks) {
    
    // Check if player overlaps block
    if (x + w > b.x && x < b.x + b.w &&
        y + h > b.y && y < b.y + b.h) {
  
      // From top
      if (vy > 0 && y + h - vy <= b.y) {
        y = b.y - h;
        vy = 0;
        onGround = true;
      }
      // From bottom
      else if (vy < 0 && y - vy >= b.y + b.h) {
        y = b.y + b.h;
        vy = 0;
      }
      // From left
      else if (vx > 0 && x + w - vx <= b.x) {
        x = b.x - w;
        vx = 0;
      }
      // From right 
      else if (vx < 0 && x - vx >= b.x + b.w) {
        x = b.x + b.w;
        vx = 0;
      }
     }
    }
   }

    // SPIKE COLLISION
    // If the player touches a spike they return to the starting spot
  void checkSpikeHit() {
    for (SpikeBlock s : spikeBlocks) {
      if (x + w > s.x && x < s.x + s.w &&
          y + h > s.y && y < s.y + s.h) {
       
        // Reset to start
        x = startX;
        y = startY;
        vx = 0;
        vy = 0;
      }
    }
  }
  
   // checks for Y level where play-world ends and death happens
  void checkWorldVoid() {
    if (y > levelHeight) {
      death();
    }
  }
  // on player death
  void death(){
    x = startX;
    y = startY;
    vx = 0;
    vy = 0;
  }
  
 // POWERUPS
 // Detect collission and Apply Effect
  void checkPowerUps(){
    for (int i = powerUps.size()-1; i >= 0; i--) {
      PowerUp p = powerUps.get(i);
        
        if(x + w > p.x - p.size/2
          && x < p.x + p.size/2
          && y + h > p.y - p.size/2 
          && y <p.y + p.size/2) {
            //apply effect
            p.apply(this);
            //pickup & remove
            powerUps.remove(i);
          }
    }
  }

  // DRAW PLAYER
  // Draws the player as a simple rectangle
  void drawPlayer() {
    fill(col);
    rect(x, y, w, h);
  }
}

// PLAYER CLASS END 

// PLATFORM CLASS
// Simple platform used for start/finish areas or ground
// Draws a black rectangle for the ground or flag base
class Platform {
  
  // Position and size of the platform
  float x, y, w, h;

  // Constructor 
  // Sets up the platform's position and size
  Platform(float px, float py, float pw, float ph) {
    x = px;   // X position
    y = py;   // Y position
    w = pw;   // width
    h = ph;   // height
  }

// DRAW PLATFORM
  // Draws the platform as a black rectangle
  void drawPlatform() {
      fill(0);          // black color
    rect(x, y, w, h); // draw shape
  }
}

// PLATFORM CLASS END 

// BLOCK CLASS
// Used to create solid blocks that players can stand on or collide with.
// Each block has a position, size, and color. Blocks are placed in Build Mode
// and displayed during Play Mode for both players.

class Block {

  // Position of the block on screen
  float x, y;

  // Size of the block (width and height)
  float w = 50;
  float h = 50;

  // Color values for the block (RGB)
  int r, g, b;

  // Constructor
  // Sets up the blocks position and color
  Block(float x, float y, int r, int g, int b) {
    this.x = x;   // X position
    this.y = y;   // Y position
    this.r = r;   // Red color value
    this.g = g;   // Green color value
    this.b = b;   // Blue color value
  }

  // DISPLAY BLOCK
  // Draws the block as a colored rectangle on screen
  void display() {
    fill(r, g, b);   // Apply color
    rect(x, y, w, h); // Draw the block shape
  }
}

// BLOCK CLASS END 

//POWERUPS CLASS
//Handles abilites like speed, bombs to destroy blocks etc.
class PowerUp {
  float x, y;
  float size = 20;

  PowerUp(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    ellipse(x, y, size, size);
  }
 
  //this looks weird because it's empty, but it is here to auto-insert the needed child class
  void apply(Player player) {
  //start loopiing through child classes
  }
}

//POWERUP SUBCLASSES
//SPEEDBOOST
//when players step on it, it increases their speed for a short duration
class SpeedPowerUp extends PowerUp {
  SpeedPowerUp (float x, float y) {
    super (x,y);
  }
   
  void display(){
    fill (0,200,255);
    ellipse (x,y,size,size);
  }
  
  void apply(Player player) {
    player.moveSpeed += 2; //how fast the speed boost is
  }
}

//BOMB POWERUP CLASS
//When players step on it, it destroys all blocks in a certain radius around them
class BombPowerUp extends PowerUp {
  BombPowerUp (float x, float y) {
    super(x, y);
  }
  
  void display() {
    push();
    fill (134, 41, 27); // color of bomb: dark-red
    //stroke (232, 41, 242);
    ellipse (x, y, size, size);
    pop();
  }

  void apply(Player player) {
    float range = 100;
   
   //looping backwards through blocks, it removes all blocks within a radius around the player 
    for (int i = onScreenBlocks.size()-1; i >=0; i--) {
      Block b= onScreenBlocks.get(i);
      float centerX = b.x + b.w/2;
      float centerY = b.y + b.h/2;
      
      if (dist (player.x,player.y,centerX,centerY) < range) {
        onScreenBlocks.remove(i);
      }
    }  
  }
}

// POWERUPS CLASS END 

//SPIKE BLOCK CLASS
// Touching it resets the player
class SpikeBlock {

  // Spike position
  float x, y;

  // Spike size (same as block size)
  float w = 50;
  float h = 50;

  // Sets spike position
  SpikeBlock(float x, float y) {
    this.x = x;   // X position
    this.y = y;   // Y position
  }

 // Draws a red triangle to show danger clearly
// Used as a trap that resets the player when touched
  void display() {
    fill(200, 50, 50);  // red color

    // Triangle pointing upward
    triangle(
      x, y + h,   // left bottom
      x + w/2, y,       // top
      x + w, y + h    // right bottom
    );
  }
}

// SPIKE BLOCK CLASS END 

// START & FINISH SYSTEM
// This creates the start area, finish area, and the flags for both players
// Starting position for both players
float startX = 80;
float startY = 308;

// Finish flag position set after platform is made
float finishX;
float finishY;

// Platforms under the start and finish flags
Platform startPlatform;
Platform finishPlatform;

// SETUP START / FINISH
// Creates start and finish platforms with flags
// Moves finish platform depending on window size
void setupStartFinish() {

  // Platform under the start flag
  startPlatform = new Platform(50, 350, 150, 20);

  // Move finish platform based on selected window size
  if (selectedSize == 1100) {
    
    // Smaller window to shorter level
    finishPlatform = new Platform(startPlatform.x + 670, 350, 150, 20);
  } else {
    
    // Default (original 1400) window to longer level
    finishPlatform = new Platform(startPlatform.x + 970, 350, 150, 20);
  }

  // Finish flag centered above its platform
  finishX = finishPlatform.x + finishPlatform.w / 2;
  finishY = finishPlatform.y - 42;
}

// DRAW START / FINISH
// Draws both platforms and both flags in Build Mode and Play Mode
void drawStartFinish() {
    
  // Draw platforms first
  startPlatform.drawPlatform();
  finishPlatform.drawPlatform();

  // Start flag (green)
  fill(0, 200, 0);
  rect(startX - 10, startY - 40, 20, 40);

  // Finish flag (yellow)
  fill(255, 220, 0);
  rect(finishX - 10, finishY - 40, 20, 40);
}

// RESET PLAYERS TO START
// Sends both players back to the start area
void resetPlayersToStart() {
  
  // Red player reset
  redPlayer.x = startX;
  redPlayer.y = startY;
  
  // Blue player reset (slightly moved to the right)
  bluePlayer.x = startX + 40;
  bluePlayer.y = startY;
  
  // Stop movement for both red and blue
  redPlayer.vx = redPlayer.vy = 0;
  bluePlayer.vx = bluePlayer.vy = 0;
}

// CHECK IF PLAYER REACHED FINISH
// Checks if a player reached the finish box
// Adds points and shows win screen when someone reaches 4
void checkFinishReached() {
  
  // Red player check
  if (redPlayer.x + redPlayer.w > finishX - 20 &&
      redPlayer.x < finishX + 20 &&
      redPlayer.y + redPlayer.h > finishY - 40 &&
      redPlayer.y < finishY + 10) {
      redScore = min(redScore + 1, 4);   // add point up for Red to 4
      gameState = 1;                    // send them back to build mode 
      resetPlayersToStart();           // send them back to start platform 
  }

  // Blue player check
  if (bluePlayer.x + bluePlayer.w > finishX - 20 &&
      bluePlayer.x < finishX + 20 &&
      bluePlayer.y + bluePlayer.h > finishY - 40 &&
      bluePlayer.y < finishY + 10) {
      blueScore = min(blueScore + 1, 4);  // add point up for Blue to 4
      gameState = 1;                     // send them back to build mode 
      resetPlayersToStart();            // send them back to start platform 
  }

  // Check if Red player reached 4 points
  if (redScore >= 4) {
    winner = 1;          // takes them to the Red winner screen 
    gameState = 3;      // Win screen 
    clearAllBuilds();  // remove all placed items
    
    // Check if Blue player reached 4 points
  } else if (blueScore >= 4) {
    winner = 2;          //takes them to the Blue winner screen 
    gameState = 3;      // Win screen 
    clearAllBuilds();  // remove all placed items
  }
}

// CLEAR ALL BUILDS
// Removes all placed blocks, spikes, and powerups for a fresh start
void clearAllBuilds() {
  onScreenBlocks.clear();   // Removes all blocks 
  spikeBlocks.clear();     // Removes all Spikes 
  powerUps.clear();       // Removes all power ups 
}

// START & FINISH SYSTEM END

// BUILD MODE
// This screen is used for placing blocks and spikes before testing the level
void drawBuildMode() {

  background(220);

  fill(180);
  rect(0, 0, width - sidePanelWidth, worldHeight);

  fill(140);
  rect(width - sidePanelWidth, 0, sidePanelWidth, worldHeight);

  drawInventory();

  drawBlocks();
 
  // Draw start and finish platforms + flags
  drawStartFinish();
  
// Shows a see through preview of the block or spike
// This helps the player see where the item will go before placing it
  drawPlacementPreview();
  
  // Draw score boxes only in Build Mode
  drawScoreBoxes();

  fill(0);
  textAlign(CENTER);
  textSize(24); 
  text("Press P to Play", width - 100, 360);
  text("Press S to Save", width - 100, 390);
}

// SCORE BOXES
// Creates four empty boxes for each player at the top of the screen
// When a player reaches the finish, their boxes fill with color
// Red boxes fill for the red player and blue boxes fill for the blue player
// Once all four boxes are filled, it triggers the win screen
void drawScoreBoxes() {
  
  // Red side boxes (top left) can also set the amount by changing the 4
  for (int i = 0; i < 4; i++) {
    fill(255); // empty box
    rect(20 + i * 40, 20, 30, 30);
  }
  // Fill boxes for red players points
  for (int i = 0; i < redScore; i++) {
    fill(255, 0, 0);
    rect(20 + i * 40, 20, 30, 30);
  }

  // Blue side boxes (top right) can also set the amount by changing the 4
  for (int i = 0; i < 4; i++) {
    fill(255);
    rect(width - 160 + i * 40, 20, 30, 30);
  }
  // Fill boxes for blue players points
  for (int i = 0; i < blueScore; i++) {
    fill(0, 120, 255);
    rect(width - 160 + i * 40, 20, 30, 30);
  }
}


void drawInventory() {
  
  //block button
  fill(100, 200, 100);
  rect(width - 150, 100, 100, 50);

  fill(0);
  textSize(25);     
  text("Block", width - 100, 135);

  //spike button
  fill(200, 80, 80);
  rect(width - 150, 170, 100, 50);

  fill(0);
  textSize(25); 
  text("Spike", width - 100, 205);

  // Speed Button
    fill(0,200,255);
  circle(width - 100, 255, 30);
  
  fill (0);
  textSize(20); 
  text ("Speed", width - 100, 260);

  if (dist(mouseX, mouseY, width - 100, 255) < 15) {
   holdingPowerUp = true;
   holdingSpeedPowerUp = true;
   holdingBombPowerUp = false;
  }
 
  // Bomb Button
  fill(134, 41, 27);
  circle(width - 100, 310, 30);
  
  fill(0);
  textSize(20); 
  text ("Bomb", width - 100, 315);

  if (dist(mouseX, mouseY, width - 100, 310) < 15) {
    holdingPowerUp = true;
    holdingBombPowerUp = true;
    holdingSpeedPowerUp = false;
  }
}
 
// DRAW BLOCKS, SPIKES, POWERUPS
// Shows everything already placed in the world 
void drawBlocks() {

  // Normal blocks
  for (Block b : onScreenBlocks) {
    b.display();
  }
  // Spike blocks
  for (SpikeBlock s : spikeBlocks) {
    s.display();
  }

  // PowerUps
  for (PowerUp p : powerUps) {
    p.display();
  }
}

// DRAW PLACEMENT PREVIEW
// Shows a see through preview of blocks, spikes, and powerups
// Helps the player see where an item will go before placing it
void drawPlacementPreview() {

    // Only show preview in the world area
  if (mouseX < width - sidePanelWidth) {
   
    // Block preview
    if (holdingBlock) {
      fill(100, 200, 100, 120);  
      rect(mouseX, mouseY, 50, 50);
    }
   // Spike preview
    if (holdingSpike) {
      fill(200, 50, 50, 120);  
      triangle(
        mouseX, mouseY + 50,     
        mouseX + 25, mouseY,     
        mouseX + 50, mouseY + 50 
      );
    }

   // PowerUps preview
   // Speed PowerUp preview
    if (holdingSpeedPowerUp) {
       fill(0,200,255);
      ellipse(mouseX, mouseY, 20, 20);
    }
    
    // Bomb PowerUp preview
    if (holdingBombPowerUp) {
      fill(134, 41, 27, 120);  
      ellipse(mouseX, mouseY, 20, 20);

     //ellipse(300,200,255,80);
     //ellipse(mouseX, mouseY + 50, mouseX + 50, mouseY);
     }
    
  }
}

// BUILD MODE END

// PLAY MODE
// Runs the play mode where both players move and interact
// Shows blocks, spikes, powerups, and checks for finish contact
void drawPlayMode() {

  background(200);

  // Draws start and finish platforms and flags
  drawStartFinish();

  // Shows all blocks placed in the level
  for (Block b : onScreenBlocks) {
    b.display();
  }

   // Shows all spikes placed in the level
  for (SpikeBlock s : spikeBlocks) {
    s.display();
  }
   // Shows all powerups placed in the level
  for (PowerUp p : powerUps) {
    p.display();
  }

  // Updates both players with movement and gravity
  redPlayer.update();
  bluePlayer.update();

  // Draws both players on screen
  redPlayer.drawPlayer();
  bluePlayer.drawPlayer();

  // Checks if either player reached the finish box
  checkFinishReached();

  // Shows a small reminder to go back to build mode
  fill(0);
  textSize(30); 
  text("Press B to Build", 130, 40);
}

// PLAY MODE END 

// SAVE & LOAD SYSTEM
// Saves all blocks, spikes, and powerups into a file
// Helps keep the level setup for later testing
void saveLevel() {

  if (onScreenBlocks.size() == 0 && spikeBlocks.size() == 0) {
    println("No blocks to save.");
    return;
  }

  String[] data = new String[onScreenBlocks.size() + spikeBlocks.size() + powerUps.size()];

  int index = 0; 

  // Saves block positions
  for (Block b : onScreenBlocks) {
    data[index] = "B," + b.x + "," + b.y;
    index++;
  }

  // Saves spike positions
  for (SpikeBlock s : spikeBlocks) {
    data[index] = "S," + s.x + "," + s.y;
    index++;
  }

  // Saves powerups positions
  for (PowerUp p : powerUps) {
    data [index] = "P," + p.x + "," + p.y;
    index++;
  }

  String fullPath = dataPath("savedState.txt");

  saveStrings(fullPath, data);

  println("Saved " + data.length + " items");
  println("Saved to: " + fullPath);
}

// Loads saved blocks, spikes, and powerups from file
// Clears old ones and rebuilds them in the level
void loadLevel() {

  String fullPath = dataPath("savedState.txt");

  String[] data = loadStrings(fullPath);

  if (data == null) {
    println("No save file found.");
    return;
  }

  onScreenBlocks.clear();
  spikeBlocks.clear();
  powerUps.clear();

  for (String line : data) {

    if (line != null && line.length() > 0) {

      String[] parts = split(line, ",");

      if (parts[0].equals("B")) {
        float x = float(parts[1]);
        float y = float(parts[2]);
        onScreenBlocks.add(new Block(x, y, 100, 200, 100));
      }

      if (parts[0].equals("S")) {
        float x = float(parts[1]);
        float y = float(parts[2]);
        spikeBlocks.add(new SpikeBlock(x, y));
      }
      if (parts[0].equals("P")) {
        float x = float (parts[1]);
        float y = float(parts[2]);
        powerUps.add(new PowerUp(x,y));
        powerUps.add(new SpeedPowerUp(x,y));
        powerUps.add(new BombPowerUp(x,y));
      }
    }
  }

  println("Loaded " + data.length + " items");
  println("Loaded from: " + fullPath);
}

// SAVE & LOAD SYSTEM END
