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
  stroke (0, 0, 0);
  rect(startX - 10, startY - 40, 20, 40);

  // Finish flag (yellow)
  fill(255, 220, 0);
  stroke (0, 0, 0);
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
