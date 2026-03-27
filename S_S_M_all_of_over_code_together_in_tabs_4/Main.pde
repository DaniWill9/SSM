// MAIN GAME FILE

// Tracks which keys are held down for both players to keep movement smoother
boolean[] keyDown = new boolean[512];

// Two players used in Play Mode
Player redPlayer;
Player bluePlayer;

// Size of the full level area so the level can be bigger than the window
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


int sidePanelWidth = 200;

//Window Size Settings
void settings() {
  size(1400, worldHeight);
}
// SETUP
// Runs once and creates the start and finish platforms and both players
void setup() {
  setupStartFinish();
  
  // Players start at the starting spot with different colors
  redPlayer = new Player(startX, startY, color(255, 0, 0));
  bluePlayer = new Player(startX + 40, startY, color(0, 120, 255));
  
  /*
  //Testing PowerUps
  powerUps.add(new PowerUp(200,200));
  powerUps.add(new SpeedPowerUp(200,200));
  powerUps.add(new BombPowerUp(350,200));
  */
}

void draw() {

  if (gameState == 0) {
    background(30);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("START SCREEN\nClick to Build", width/2, height/2);
  }

  else if (gameState == 1) {
    drawBuildMode();
  }

  else if (gameState == 2) {
    drawPlayMode();
  }
}

void mousePressed() {

  if (gameState == 0) {
    gameState = 1;  
    return;
  }

  if (gameState == 1) {
       // Block button
    if (mouseX > width - 150 && mouseX < width - 50 &&
        mouseY > 100 && mouseY < 150) {

      holdingBlock = true;
      holdingSpike = false;
      holdingPowerUp =  false;
    }
    // Spike button
    else if (mouseX > width - 150 && mouseX < width - 50 &&
             mouseY > 170 && mouseY < 220) {

      holdingSpike = true;
      holdingBlock = false;
      holdingPowerUp =  false;
    }
     // POWERUPS buttons"
     // for SpeedPowerUp
    else if (mouseX > width - 150  && mouseX < width - 50 &&
    mouseY > 190 && mouseY < 240) {
      holdingPowerUp = true;
      holdingSpeedPowerUp = true;
      holdingBlock = false;
      holdingSpike =  false;
    }
    //for BombPowerUp
    
    else if (mouseX > width - 150  && mouseX < width - 50 &&
    mouseY > 190 && mouseY < 240) {
      holdingPowerUp = true;
      holdingSpeedPowerUp = true;
      holdingBlock = false;
      holdingSpike =  false;
    }
    
    // Placing items in the world area
    else if (mouseX < width - sidePanelWidth) {

      //Platform X and Platform Y 
      float px = constrain(mouseX, 0, worldWidth - 50);
      float py = constrain(mouseY, 0, worldHeight - 50);
    
    // Place block
      if (holdingBlock) {
        onScreenBlocks.add(new Block(px, py, 100, 200, 100));
        holdingBlock = false;
      }
    
    // Place spike
      else if (holdingSpike) {
        spikeBlocks.add(new SpikeBlock(px, py));
        holdingSpike = false;
      }
    // Place powerup
      else if (holdingPowerUp) {
        powerUps.add(new PowerUp(px, py));
        holdingPowerUp = false;
      }
    }
  }
}

void keyPressed() {

  if (keyCode < 512) keyDown[keyCode] = true;
  if (key < 512) keyDown[key] = true;

  if (gameState == 1 && key == 'p') {
    gameState = 2;
  }

  if (gameState == 2 && key == 'b') {
    gameState = 1;
    resetPlayersToStart();
  }

  if (gameState == 1 && key == 's') saveLevel();
  if (gameState == 1 && key == 'l') loadLevel();
}


void keyReleased() {
  if (keyCode < 512) keyDown[keyCode] = false;
  if (key < 512) keyDown[key] = false;
}
