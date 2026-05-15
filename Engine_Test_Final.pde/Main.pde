// MAIN GAME FILE

// Tracks which keys are held down for both players to keep movement smoother
boolean[] keyDown = new boolean[512];

// Creates both players and sets up their starting spots
Player redPlayer;
Player bluePlayer;

// Size of the full level area so the level can be bigger than the window
// Makes the level area bigger than the window
int worldWidth = 2700;
int worldHeight = 520;

// Lists for all placed blocks and spikes
ArrayList<Block> onScreenBlocks = new ArrayList<Block>();
ArrayList<SpikeBlock> spikeBlocks = new ArrayList<SpikeBlock>();

// Lists for all PowerUps
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();

// What item is currently selected for placing
boolean holdingBlock = false;
boolean holdingSpike = false;
boolean holdingPowerUp = false;
boolean holdingSpeedPowerUp = false;
boolean holdingBombPowerUp = false;

int gameState = 0; // 0 = Start, 1 = Build, 2 = Play

// The side panel on the right side of the window
int sidePanelWidth = 200;

// Lets the player pick between two window sizes
int selectedSize = 1400;  // default window size

// Keeps track of points and who wins
// Player scores
int redScore = 0;
int blueScore = 0;

int winner = 0; // 0 = none, 1 = red wins, 2 = blue wins

//Window Size Settings
void settings() {
  size(1400, worldHeight);
}

// SETUP
// Runs once and creates the start and finish platforms and both players
void setup() {
  setupStartFinish();
  
  // Red and blue players start next to each other on the platform
  redPlayer = new Player(startX, startY, color(255, 0, 0), worldHeight);
  bluePlayer = new Player(startX + 40, startY, color(0, 120, 255), worldHeight);

  
  /*
  //To Test PowerUps Functionality
  powerUps.add(new PowerUp(200,200));
  powerUps.add(new SpeedPowerUp(200,200));
  powerUps.add(new BombPowerUp(350,200));
  */
}

// DRAW LOOP
void draw() {
  if (gameState == 0) {
    background(30);
    textAlign(CENTER, CENTER);
    textSize(28);
    fill(255);
    text("Start Game Screen", width/2, 100);

    // Draw boxes for Start and sizes
    drawStartMenu();
  }
  // Build mode screen state to show give the option to build and place stuff 
  else if (gameState == 1) {
    drawBuildMode();
  }
  // Play mode screen state to show the player moving and play on what they built
  else if (gameState == 2) {
    drawPlayMode();
  }  
   // Win mode screen state to show who won
   else if (gameState == 3) {
    drawWinScreen();
  }
}

// Draws the start menu with size options and start button
void drawStartMenu() {
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(20);

  // Start Game box
  fill(100, 200, 100);
  rect(width/2, 220, 200, 50);
  fill(0);
  text("Start Game", width/2, 220);

  // Original size box
  fill(selectedSize == 1400 ? color(200, 0, 0) : color(180));
  rect(width/2, 300, 200, 50);
  fill(0);
  text("1400 (Original)", width/2, 300);

  // Smaller size box
  fill(selectedSize == 1100 ? color(200, 0, 0) : color(180));
  rect(width/2, 380, 200, 50);
  fill(0);
  text("1100 (Smaller)", width/2, 380);

  // Instruction text
  fill(255);
  textSize(18);
  text("Click a size to select (red = chosen)\nThen click Start Game", width/2, 460);

  // Reset modes so Build/Play dont inherit CENTER
  rectMode(CORNER);
  textAlign(LEFT, BASELINE);
}

// MOUSE PRESSED
void mousePressed() {
  // Start Screen
  if (gameState == 0) {
    // Start Game box
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 &&
        mouseY > 195 && mouseY < 245) {
      // Apply chosen size, then go to Build
      surface.setSize(selectedSize, worldHeight);
      gameState = 1;
      return;
    }

    // 1400 box
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 &&
    mouseY > 275 && mouseY < 325) {
    selectedSize = 1400;
    // Rebuild start and finish platforms for the oringal size
    setupStartFinish();
    }

    // 1100 box
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 &&
    mouseY > 355 && mouseY < 405) {
    selectedSize = 1100;
    // Rebuild start and finish platforms for the smaller size
    setupStartFinish();
  }


    return;
  }
// Win Screen click
if (gameState == 3) {
  // Replay box area
  if (mouseX > width/2 - 150 && mouseX < width/2 + 150 &&
      mouseY > 200 && mouseY < 260) {
    // Reset everything for a fresh new gameplay
    redScore = 0;
    blueScore = 0;
    winner = 0;
    gameState = 0;
  }
  return;
}

  // Build Mode clicks 
  if (gameState == 1) {
    // Block button
    if (mouseX > width - 150 && mouseX < width - 50 &&
        mouseY > 100 && mouseY < 150) {

      holdingBlock = true;
      holdingSpike = false;
      holdingPowerUp = false;
      holdingSpeedPowerUp = false;
      holdingBombPowerUp = false;
    }
    // Spike button
    else if (mouseX > width - 150 && mouseX < width - 50 &&
             mouseY > 170 && mouseY < 220) {

      holdingSpike = true;
      holdingBlock = false;
      holdingPowerUp = false;
      holdingSpeedPowerUp = false;
      holdingBombPowerUp = false;
    }
    // Speed PowerUp (matches circle at y=260)
    else if (mouseX > width - 150 && mouseX < width - 50 &&
             mouseY > 240 && mouseY < 270) {
      holdingPowerUp = true;
      holdingSpeedPowerUp = true;
      holdingBombPowerUp = false;
      holdingBlock = false;
      holdingSpike = false;
    }
    // Bomb PowerUp (matches circle at y=315)
    else if (mouseX > width - 150 && mouseX < width - 50 &&
             mouseY > 295 && mouseY < 325) {
      holdingPowerUp = true;
      holdingBombPowerUp = true;
      holdingSpeedPowerUp = false;
      holdingBlock = false;
      holdingSpike = false;
    }
    // Placing items in the world area 
    else if (mouseX < width - sidePanelWidth) {

      float px = constrain(mouseX, 0, worldWidth - 50);
      float py = constrain(mouseY, 0, worldHeight - 50);
    
      // Place block placement
      if (holdingBlock) {
        onScreenBlocks.add(new Block(px, py, 100, 200, 100));
        holdingBlock = false;
      }
      // Place spike placement
      else if (holdingSpike) {
        spikeBlocks.add(new SpikeBlock(px, py));
        holdingSpike = false;
      }
      // Place powerup placement bomb/speed
      else if (holdingPowerUp) {
        if (holdingSpeedPowerUp) {
          powerUps.add(new SpeedPowerUp(px, py));
        } else if (holdingBombPowerUp) {
          powerUps.add(new BombPowerUp(px, py));
        }
        holdingPowerUp = false;
        holdingBombPowerUp = false;
        holdingSpeedPowerUp = false;
      }
    }
  }
}

// KEY PRESSED
void keyPressed() {
  if (keyCode < 512) keyDown[keyCode] = true;
  if (key < 512) keyDown[key] = true;

  //checks if p key is being pressed and sends them into play mode
  if (gameState == 1 && key == 'p') {
    gameState = 2;          // play mode
  }

  //checks if b key is being pressed and sends them into build mode
  if (gameState == 2 && key == 'b') {
    gameState = 1;          // build mode
    resetPlayersToStart();  // send them back to the start platform once b key is pressed
  }

  // checks if s or l is being pressed in build mode 
  if (gameState == 1 && key == 's') saveLevel();
  if (gameState == 1 && key == 'l') loadLevel();
}

// KEY RELEASED
void keyReleased() {
  if (keyCode < 512) keyDown[keyCode] = false;
  if (key < 512) keyDown[key] = false;
}

// WIN SCREEN
// Shows who won and lets players restart
void drawWinScreen() {
  background(220);

  // Winner text color
  if (winner == 1) fill(255, 0, 0);
  else if (winner == 2) fill(0, 120, 255);
  else fill(0);

  textAlign(CENTER, CENTER);
  textSize(40);
  text(winner == 1 ? "RED PLAYER WINS!" : "BLUE PLAYER WINS!", width/2, 150);
  
  // Black box under winner text
  fill(0);
  stroke (0, 0, 0);
  rect(width/2 - 150, 200, 300, 60);

  fill(255);
  textSize(24);
  text("Play again", width/2, 230);
}
