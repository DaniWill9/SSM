// START & FINISH SYSTEM
// This creates the start area finish area and the flags for both players

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
// Makes the start platform and finish platform
// Also sets the flag positions
void setupStartFinish() {

  // Platform under the start flag
  startPlatform = new Platform(50, 350, 150, 20);

  // Finish platform placed far to the right for a long level
  finishPlatform = new Platform(startPlatform.x + 970, 350, 150, 20);

  // Finish flag centered above its platform
  finishX = finishPlatform.x + finishPlatform.w/2;
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
  redPlayer.vx = 0;
  redPlayer.vy = 0;

  bluePlayer.vx = 0;
  bluePlayer.vy = 0;
}

// CHECK IF PLAYER REACHED FINISH
// Checks if a player is touching the finish box
// If they touch it the game goes back to Build Mode
void checkFinishReached() {

  // Red player check
  if (redPlayer.x + redPlayer.w > finishX - 20 &&
      redPlayer.x < finishX + 20 &&
      redPlayer.y + redPlayer.h > finishY - 40 &&
      redPlayer.y < finishY + 10) {

    gameState = 1;
    resetPlayersToStart();
  }

  // Blue player check
  if (bluePlayer.x + bluePlayer.w > finishX - 20 &&
      bluePlayer.x < finishX + 20 &&
      bluePlayer.y + bluePlayer.h > finishY - 40 &&
      bluePlayer.y < finishY + 10) {

    gameState = 1;
    resetPlayersToStart();
  }
}
