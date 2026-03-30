// PLAY MODE

void drawPlayMode() {

  background(200);

  drawStartFinish();

  for (Block b : onScreenBlocks) {
    b.display();
  }

  for (SpikeBlock s : spikeBlocks) {
    s.display();
  }

  
  redPlayer.update();

  bluePlayer.update();

  redPlayer.drawPlayer();

  bluePlayer.drawPlayer();

  checkFinishReached();

  fill(0);
  text("Press B to Build", 100, 20);
}
