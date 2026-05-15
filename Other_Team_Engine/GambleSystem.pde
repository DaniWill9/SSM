   int yOffset = 250; // change this number to move it up/down for gamble screen 
int recoveryYOffset = 150; // change this number to move it up/down for mini game screen 
int y = recoveryYOffset;

// gamble system
class GambleSystem {

  boolean showGamble = false;  // controls gamble YES/NO screen
  boolean gambleResolved = false; 

  int boxWidth = 150;
  int boxHeight = 80;
  
   // UI STATES (only one should be active at a time)
  boolean showRecoveryPrompt = false;  // asks player if they want to recover HP
  boolean showMiniGame = false;        // shows spam spacebar minigame
  boolean showResultScreen = false;    // shows win/lose result

 // MINI GAME VALUES
int miniGameProgress = 0; // how full the bar is
int miniGameGoal = 100;   // goal to win

int miniGameTimer = 0;
int miniGameTimeLimit = 10 * 60; // time limit for bar/ 10 seconds (60 FPS)

  boolean miniGameWon = false; // result of mini game

  // called when battle happens
  void trigger() {
    showGamble = true;  // open gamble screen
    gambleResolved = false;
  }

  void display() {
    if (!showGamble) return; // don't draw if not active

    // Background overlay
    fill(0, 0); // color backgorund 
    rect(0, 0, width, height); // size for the color background 

    // Text
    fill(255);
    textSize(40);
    text("Want to take a gamble? You or UI could lose a health ", width/2, height/2 - 100 + yOffset);

    // YES (Green) gamble screen
    fill(0, 200, 0);
    rect(width/2 - 200, height/2 + yOffset, boxWidth, boxHeight);
    
    fill(255);
    textSize(25);
   text("YES", width/2 - 125, height/2 + 45 + yOffset);
   
    // NO (Red) gamble screen
    fill(200, 0, 0);
    rect(width/2 + 50, height/2 + yOffset, boxWidth, boxHeight);


    fill(255);
    text("NO", width/2 + 125, height/2 + 45 + yOffset);
  }

  void mousePressed() {
    if (!showGamble) return;

    // YES CLICK GAMBLE SYSTEM // checks if mouse is in the zone
    if (mouseX > width/2 - 200 && mouseX < width/2 - 200 + boxWidth &&
        mouseY > height/2 + yOffset && mouseY < height/2 + boxHeight + yOffset) {

      resolveGamble();
    }

    // NO CLICK GAMBLE SYSTEM // checks if mouse is in the zone
    if (mouseX > width/2 + 50 && mouseX < width/2 + 50 + boxWidth &&
        mouseY > height/2 + yOffset && mouseY < height/2 + boxHeight + yOffset) {

      showGamble = false;
    }
  }

  void resolveGamble() {
    int chance = int(random(0, 2)); // 50/50 outcome

    if (chance == 0) {
      player.playerHP -= 5; // BAD/ player loses HP
    } else {
      enemy.enemyHP -= 5;   // GOOD/ enemy loses HP
    }

    showGamble = false;         // close gamble
    showRecoveryPrompt = true;  // open recovery screen
  }
}
