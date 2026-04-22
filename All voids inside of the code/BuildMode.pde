// void inside of build 
//
// You can press Ctrl + F and type down the void to find them
//
// void drawBuildMode()
// void drawScoreBoxes()
// void drawInventory() 
// void drawBlocks()
// void drawPlacementPreview() 


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

// void drawBuildMode () end  

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

// drawScoreBoxes() end 

// Side Panel list inventory 
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
 
 // void drawInventory() End 
 
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

// void drawBlocks() End 

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

// void drawPlacementPreview() End 

//BUILD MODE end 
