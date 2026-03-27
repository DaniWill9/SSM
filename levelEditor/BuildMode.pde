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

  fill(0);
  textAlign(CENTER);
  text("Press P to Play", width - 100, 360);
  text("Press S to Save", width - 100, 390);
}

void drawInventory() {

  fill(100, 200, 100);
  rect(width - 150, 100, 100, 50);

  fill(0);
  textAlign(CENTER, CENTER);
  text("Block", width - 100, 125);

  fill(200, 80, 80);
  rect(width - 150, 170, 100, 50);

  fill(0);
  text("Spike", width - 100, 195);
  
  fill(0);
  text ("Speed", width - 100, 255);
  
  fill(0);
  text ("Bomb", width - 100, 310);
  
}

// DRAW BLOCKS + SPIKES
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
  for (PowerUp p : powerUps) {
    p.displayPowerUp();
    //p.displaySpeedPowerUp();
   // p.displayBombPowerUp();
  }
}

// DRAW PLACEMENT PREVIEW
// Shows a transparent preview of the selected item
// Follows the mouse inside the world area
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
   
     if (holdingPowerUp) {
       if (holdingSpeedPowerUp){
         fill (240, 197, 24);
         ellipse (mouseX,mouseY,10,10);
       }
       if (holdingBombPowerUp){
         fill (134, 41, 27);
         ellipse (mouseX,mouseY,10,10);
       }
     //ellipse(300,200,255,80);
     //ellipse(mouseX, mouseY + 50, mouseX + 50, mouseY);
     }
    
  }
}
