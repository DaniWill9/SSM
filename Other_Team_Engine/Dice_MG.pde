// Dice rolling mini game
class diceMG {

  int playerRoll;
  int enemyRoll;

  boolean rolled = false;
  boolean finished = false;

  diceMG() {

  }

// Draws dice mini game UI
  void display() {

    background(40, 40, 80);

    fill(255);
    textSize(50);
    text("DICE MINI GAME", width/2, 120);

    textSize(30);
    text("Press SPACE to roll dice", width/2, 220);

    // Player dice
    fill(0, 200, 0);
    rect(width/2 - 300, height/2 - 100, 200, 200);

    fill(255);
    textSize(80);

    if (rolled) {
      text(playerRoll, width/2 - 200, height/2 + 30);
    }
    else {
      text("?", width/2 - 200, height/2 + 30);
    }

    // Enemy dice
    fill(200, 0, 0);
    rect(width/2 + 100, height/2 - 100, 200, 200);

    fill(255);

    if (rolled) {
      text(enemyRoll, width/2 + 200, height/2 + 30);
    }
    else {
      text("?", width/2 + 200, height/2 + 30);
    }

    // Result text
    if (finished) {

     textSize(40);

// =========================
// PLAYER WINS
// =========================
if (playerRoll > enemyRoll) {

  fill(0, 255, 0);

  text("You got lucky now have +5 HP", width/2, height/2 + 250);

  fill(0);

  textSize(25);

  text("Press SPACE BAR to go back to play", width/2, height/2 + 320);
}

// =========================
// PLAYER LOSES
// =========================
else if (playerRoll < enemyRoll) {

  fill(255, 0, 0);

  text("Dam you suck you lose -5 HP", width/2, height/2 + 250);

  fill(0);

  textSize(25);

  text("Press SPACE BAR to go back to play", width/2, height/2 + 320);
}

// =========================
// DRAW
// =========================
else {

  fill(255);

  text("It's a Draw nothing happens what else do you expect?", width/2, height/2 + 250);

  fill(0);

  textSize(25);

  text("Press SPACE BAR to go back to play", width/2, height/2 + 320);
}
      
    }
  }

// Handles rolling dice and exiting mini game
  void keyPressed() {

  // =========================
  // FIRST SPACE BAR PRESS = ROLL
  // =========================
  if (key == ' ' && !rolled) {

    // Dice rolls from 1 to 6
    // WIN CHANCE: 15 / 36 outcomes = 41.67% 
    // LOSE CHANCE: 15 / 36 outcomes = 41.67%
    // DRAW CHANCE: 6 / 36 outcomes = 16.67%
    // Each dice number has: 16.67% chance to appear
    
    playerRoll = int(random(1, 7));
    enemyRoll = int(random(1, 7));

    rolled = true;
    finished = true;

    // PLAYER WINS
    if (playerRoll > enemyRoll) {

      player.playerHP += 5;
    }

    // PLAYER LOSES
    else if (playerRoll < enemyRoll) {

      player.playerHP -= 5;
    }

    return;
  }

  // =========================
  // SECOND SPACE BAR PRESS = EXIT
  // =========================
  if (key == ' ' && finished) {

    gamble.showDiceGame = false;

    rolled = false;
    finished = false;
  }
}



  void mousePressed() {

  }
}
