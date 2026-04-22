// void inside of build 
//
// You can press Ctrl + F and type down the void to find them
// 
// void drawPlayMode()




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

// void drawPlayMode() End 
