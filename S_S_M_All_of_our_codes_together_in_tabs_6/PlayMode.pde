
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
  
  for (PowerUp p : powerUps) {
    p.displayPowerUp();
  }

// activates caster, shows beams and resets players if hit
  for(Caster c: casters){
  c.activate();
  c.update(redPlayer,bluePlayer);
  c.display();
}
  
  redPlayer.update();

  bluePlayer.update();

  redPlayer.drawPlayer();

  bluePlayer.drawPlayer();

  checkFinishReached();

  fill(0);
  text("Press B to Build", 100, 20);
}
