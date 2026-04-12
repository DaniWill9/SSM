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

// Players movement settings such as speed, jump strength, and gravity
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

  // Sets starting position, color, and control scheme
  Player(float sx, float sy, int c) {
    x = sx;
    y = sy;
  
  // Save start position
    startX = sx;
    startY = sy;

    col = c;
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
  // Adds gravity and moves the player based on speed 
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
     
      // FULL BLOCK COLLISION (solid block)
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
