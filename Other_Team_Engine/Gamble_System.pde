class GambleSystem {

  boolean showGamble = false;
  boolean gambleResolved = false;

  int boxWidth = 150;
  int boxHeight = 80;

  void trigger() {
    showGamble = true;
    gambleResolved = false;
  }

  void display() {
    if (!showGamble) return;

    // Background overlay
    fill(0, 150);
    rect(0, 0, width, height);

    // Text
    fill(255);
    textSize(40);
    text("Want to take a gamble?", width/2, height/2 - 100);

    // YES (Green)
    fill(0, 200, 0);
    rect(width/2 - 200, height/2, boxWidth, boxHeight);

    fill(255);
    textSize(25);
    text("YES", width/2 - 125, height/2 + 45);

    // NO (Red)
    fill(200, 0, 0);
    rect(width/2 + 50, height/2, boxWidth, boxHeight);

    fill(255);
    text("NO", width/2 + 125, height/2 + 45);
  }

  void mousePressed() {
    if (!showGamble) return;

    // YES CLICK
    if (mouseX > width/2 - 200 && mouseX < width/2 - 200 + boxWidth &&
        mouseY > height/2 && mouseY < height/2 + boxHeight) {

      resolveGamble();
    }

    // NO CLICK
    if (mouseX > width/2 + 50 && mouseX < width/2 + 50 + boxWidth &&
        mouseY > height/2 && mouseY < height/2 + boxHeight) {

      showGamble = false;
    }
  }

  void resolveGamble() {
    int chance = int(random(0, 2)); // 50/50

    if (chance == 0) {
      player.playerHP -= 5; // BAD
    } else {
      enemy.enemyHP -= 5; // GOOD
    }

    showGamble = false;
    gambleResolved = true;
  }
}
