//---------------------------------------------------

//---------------------------------------------------

// Main card class that handles card visuals, movement, combat, and interactions
class Card {
  //variables for our cards
  int cardValue = int(random(1, 10)), damage = cardValue; //random values
  boolean isHovering, isDraggingCard;
  boolean isDestroyed;
  boolean selectedCard;
  boolean isAttacking; //boolean to track whether a card is attacking
  boolean inZone; //boolean to track if a card is in a zone
  boolean isEnemy, isPlayer; 
  
  /* so we dont just have a bunch of random numbers and the card look stay's consistent
   edit these values to change how the card looks/position etc */
  int cardNumSize = 25;
  float cardWidth, cardHeight;
  float xPos, yPos;

  float startX, startY;
  int cardHealth; //int to track the cards health
  
  int tombstoneXPos = 25;
  int tombstoneYPos = height/2 - 150;

  int exPos = 700;
  int eyPos = 200;
  
  color cardColor;
  color cardStroke = color (0, 0, 0);
  Effect cardEffect;

  // constructor
  Card(float _xPos, float _yPos, float _cardWidth, float _cardHeight, color _cardColor, int _cardHealth, Effect _cardEffect) {
    xPos = _xPos;
    yPos = _yPos;
    
    startX = _xPos;
    startY = _yPos;
    
    cardWidth = _cardWidth;
    cardHeight = _cardHeight;
    cardColor = _cardColor;
    cardHealth = _cardHealth;
    cardEffect = _cardEffect;
  }
  
  void run() {
    mCollision();
    cCollision();
    display();
    goToTombstone();
    
    damage = cardValue;
  }
  
  // when dragging the card you selected it will use your mouse x and mouse y to update to that location
  void display() {
    if (this.isDraggingCard)
    {
      this.xPos = mouseX - cardWidth/2;
      this.yPos = mouseY - cardHeight/2;
    }
    else if (!inZone)
    {
      xPos = startX;
      yPos = startY;

      //selectedCard = this.;
    }
    //test card viewer
    stroke(cardStroke);
    fill(255, 255, 255);
    rect(xPos, yPos, cardWidth, cardHeight, 15);
    fill(123, 200, 123);
    
    //text stuff for cards
    textSize(cardNumSize);
    text(cardValue, xPos+25, yPos+30);
    textSize(15);
    text(cardEffect.effectName, xPos + cardWidth/2, yPos + cardHeight/2);
  }
  
  //sends the card to the tombstone and if the card is not a player card and not destroyed
  // or in short it handles destroyed cards and sends them to the graveyard area
  void goToTombstone() {
    if (cardValue <= 0 && !isEnemy && !this.isDestroyed) {
      player.playerHP -= 5;
      this.isDestroyed = true;
    }
    else if (cardValue <= 0 && isEnemy && !this.isDestroyed) {
      enemy.enemyHP -= 5;
      this.isDestroyed = true;
      
    }
    
    if (this.isDestroyed) {
      this.xPos = tombstoneXPos;
      this.yPos = tombstoneYPos;
      
      //this.inZone = false;
    }
    
    // RECOVERY PROMPT
if (gamble.showRecoveryPrompt) {
  fill(0, 0); // color background
  rect(0, 0, width, height); // size to fix the color background

  fill(255);
  textSize(40);
 text("Want to gain back health?", width/2, height/2 - 50 + y);

  // YES
  fill(0, 200, 0);
rect(width/2 - 200, height/2 + y, gamble.boxWidth, gamble.boxHeight);
  fill(255);
  text("YES", width/2 - 125, height/2 + 50 + y);

  // NO
  fill(200, 0, 0);
  rect(width/2 + 50, height/2 + y, gamble.boxWidth, gamble.boxHeight);
  fill(255);
  text("NO", width/2 + 125, height/2 + 50 + y);
}
    
    
  }
  
  void mousePressed() {
    
    // BLOCK GAME INPUT DURING MINI GAMES
if (gamble.showMiniGame || gamble.showDiceGame || gamble.showResultScreen) {
  ui.mousePressed();
  return;
}
    
     // RECOVERY PROMPT CLICK
  if (gamble.showRecoveryPrompt) {

   // player picks YES start RANDOM mini game
if (mouseX > width/2 - 200 && mouseX < width/2 - 200 + gamble.boxWidth &&
    mouseY > height/2 && mouseY < height/2 + gamble.boxHeight + y) {

  gamble.showRecoveryPrompt = false;

  // RANDOMLY PICK A MINI GAME 
  // int(random(2)) and 0 = space bar mini game and 1 = dice miningame 
  // Both have a 50/50 chance to pick one of the mini games
  gamble.selectedMiniGame = int(random(2));

  // =========================
  // SPACE BAR KEY MINI GAME
  // =========================
  if (gamble.selectedMiniGame == 0) {

    gamble.showMiniGame = true;

    gamble.miniGameProgress = 0;
    gamble.miniGameTimer = 0;
    gamble.spaceHeld = false;
  }

  // =========================
  // DICE MINI GAME
  // =========================
  else {

    gamble.showDiceGame = true;

    dice = new diceMG();
  }
}

    // player picks NO go back to game
    if (mouseX > width/2 + 50 && mouseX < width/2 + 50 + gamble.boxWidth &&
        mouseY > height/2 && mouseY < height/2 + gamble.boxHeight + y) {

      gamble.showRecoveryPrompt = false;
    }

    return; // stop other clicks
  }
    
    
      // first: if gamble is open, only allow gamble input
  if (gamble.showGamble) {
    gamble.mousePressed();
    return; // This stops everything else
  }
    //println("hardy har har");
    //checks if the card is hovering and if its in not in a zone already then it starts dragging
    if (this.isHovering && !inZone) {
      this.isDraggingCard = true;
    }
    
    //If selecting a player card when trying to attack
    if (this.isHovering && inZone && !ts.playerIsAttacking && ts.playerTurn && !isEnemy) {
      
      cardStroke = color (255, 0, 0);
      
      //this.isAttacking = true;
      this.selectedCard = true;
      ts.playerIsAttacking = true;
      for (Card currentCard : defaultCard) {
        if (currentCard.selectedCard) {
          ts.currentPlayerAttackingCard = currentCard;
        }
      }
      //ts.currentPlayerAttackingCard = get();
    }
    //Deselect a card to stop attacking
    else if (this.isHovering && inZone && ts.playerIsAttacking && ts.playerTurn && !isEnemy) {
    
      cardStroke = color (0, 0, 0);
      
      //this.isAttacking = false;
      this.selectedCard = false;
      ts.playerIsAttacking = false;
    }
    
    //If selecting a enemy card that you are trying to target
    if (this.isHovering && inZone && ts.playerIsAttacking && ts.playerTurn && this.isEnemy) {
      this.selectedCard = true;
      for (Card targetCard : enemyCards) {
        if (targetCard.selectedCard) {
          ts.currentEnemyTarget = targetCard;
        }
      }
    }
  }
  
  //releases the card by making isdraggingcard false
  // or in short it stops dragging cards when mouse is released
  void mouseReleased() {
    
    // Gamble system
if (gamble.showGamble || gamble.showRecoveryPrompt || gamble.showMiniGame || gamble.showDiceGame || gamble.showResultScreen) return; // block release actions
    
    
    
    if (this.isDraggingCard) {
      this.isDraggingCard = false;
    }
  }
  
  // Detects mouse hovering over cards
  void mCollision() {
    boolean mPlayerCol = collision.mouseCollision(mouseX, mouseY, this.xPos, this.yPos, this.cardWidth, this.cardHeight);
    
    if (mPlayerCol == true && !isDraggingCard && !isDestroyed) {
      this.isHovering = true;
      
      if ((xPos == startX && yPos == startY) || inZone) {
        
        if (cardEffect.effectDescription == "") {
          return;
        }
        else {
          fill(cardColor);
          rect(width * 0.17, height * 0.6, 300, 200, 15);
          fill(255);
          textSize(20);
          text(cardEffect.effectDescription, width * 0.17 + 150, height * 0.6 + 100, 40);
        }
      }
    }
    else {
      this.isHovering = false;
    }
    
  //  if (this.isHovering && isClicking && !inZone) {
  //    isDragging = true;
  //    holdingACard = true;
  //  }
  //  else if (!isClicking) {
  //    this.isDragging = false;
  //    holdingACard = false;
  //  }
    
  //  if (this.isDragging) {
  //    this.xPos = mouseX - cardWidth/2;
  //    this.yPos = mouseY - cardHeight/2;
  //  }
  //  else if (!this.inZone && !this.onZone) {
  //    xPos = startX;
  //    yPos = startY;
      
  //    //if(xPos >= startX) {
  //    //  xPos -= speed;
  //    //}   
  //    //if(xPos <= startX) {
  //    //  xPos += speed;
  //    //}
  //    //if(yPos >= startY) {
  //    //  yPos -= speed;
  //    //}
  //    //if(yPos <= startY) {
  //    //  yPos += speed;
  //    //}
  //    //if (xPos != startX && yPos != startY) {
  //    //  xPos = startX;
  //    //  yPos = startY;
  //    //}
  //  }
  }
  
  //Collision between cards
  // Detects collisions between cards and placement zones
  void cCollision() {
    
    //Card Collision for other Cards like enemy card (WIP)
    //for (int i = 0; i < enemyCards.length; i++) {
    //  boolean enemyCol = collision.rectCol(xPos, yPos, enemyCards[i].xPos, enemyCards[i].yPos, cardWidth, cardHeight, enemyCards[i].cardWidth, enemyCards[i].cardHeight);
      
    //  if (enemyCol) {
        
    //  }
    //}
    
    //Card Collision for zones
    for (int i = 0; i < zones.length; i++) {
      boolean pZoneCol = collision.rectCollision(this.xPos, this.yPos, zones[i].playerZoneX, zones[i].playerZoneY, cardWidth, cardHeight, zones[i].zoneWidth + 10, zones[i].zoneHeight + 10);
      
      if (pZoneCol) {
        if (!this.isDraggingCard && !this.inZone && zones[i].occupied == false) {
          this.xPos = zones[i].playerZoneX;
          this.yPos = zones[i].playerZoneY;
          this.inZone = true;
          zones[i].occupied = true;
        }
        else if (zones[i].playerZoneX != this.xPos && zones[i].playerZoneY != this.yPos && zones[i].occupied) {
          zones[i].occupied = false;
        }
      }
      
      //if (pZoneCol) {
      //  println("In zone.");
      //  this.onZone = true;
        
      //  //if (isClicking && !this.inZone) {
      //  //  this.inZone = false;
      //  //}
        
      //  if (!isClicking && this.onZone && zones[i].isOccupied == false) {
      //    this.xPos = zones[i].playerZoneX;
      //    this.yPos = zones[i].playerZoneY;
      //    this.inZone = true;
      //    zones[i].isOccupied = true;
      //  }
      //  //else {
      //  //  println("Not in zone.");
      //  //  this.onZone = false;
      //  //  this.inZone = false;
      //  //}
      //}
    }
  }
}

//----------------------------------------------------

// Utility class for collision detection
class Collision {
//Credit to Manny for showing us his Collision class from his Platformer Demo game he made in Processing
//Link: https://madmanapoints.itch.io/platformer-demo
/*We repurposed Manny's collision class to be able to work to have cards 
interact with each other, and have the mouse interact with cards. */
  Collision(){}
  
  boolean mouseCollision(float mX, float mY, float objX, float objY, float objW, float objH) {
    if (mX > objX && 
    mX < objX + objW && 
    mY > objY && 
    mY < objY + objH) {
      return true;
    }
    else {
      return false;
    }
  }
  
  boolean rectCollision(float obj1X, float obj1Y, float obj2X, float obj2Y, float obj1W, float obj1H, float obj2W, float obj2H)
  {
    if(obj1X + obj1W > obj2X &&
       obj1X < obj2X + obj2W &&
       obj1Y + obj1H > obj2Y &&
       obj1Y < obj2Y + obj2H)
     {
       return true;
     } 
     else
     {
       return false;
     }
  }
  
  //Might be something we can use later. 
  //Credit to Manny for showing this from his Collision class from his Platformer Demo game he made in Processing
  //Link: https://madmanapoints.itch.io/platformer-demo
  boolean circleCollision(PVector player, PVector obj, float playerR, float objR)
  {
    if(dist(player.x, player.y, obj.x, obj.y) < playerR + objR)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

//----------------------------------------------------

// Handles deck drawing, card generation, and redraw system
class Deck {

  float deckXPos = 1050;
  float deckYPos = 300;
  float deckWidth = 100;
  float deckHeight = 150;
  int deckColorR;
  int deckColorG;
  int deckColorB;
  boolean isEnemy;
  //  int deckXPos = 1000; //The deck's X Position
  //  int deckYPos = 400; // The deck's Y Position
  //int deckWidth = 150; //The deck's width size to be displayed on the "play area"
  //int deckHeight = 250; //The deck's height size to be displayed on the "play area"

  //Deck(int mx, int my)
  Deck() {
  }
  //deckXPos = mx;
  //deckYPos = my;
  int cardXOffset = 0;

  Deck(int mx, int my, int dColorR, int dColorG, int dColorB) {
    deckXPos = mx;
    deckYPos = my;

    deckColorR = dColorR;
    deckColorG = dColorG;
    deckColorB = dColorB;
  }
  //if the deck is pressed based on the amount in the main file, you will get x amount of cards and each will have a different effect
  void mousePressed() {

    if (mouseX > deckXPos && mouseX < deckXPos + deckWidth && mouseY > deckYPos && mouseY < deckYPos + deckHeight) {
      if (ts.canRedraw) {
        for (int i = defaultCard.size() - 1; i >= 0; i--) {
          defaultCard.remove(i);
        }

        //Deal Card, creating a new instance of a card object to be placed on the player's side of "play area"
        for (int i = 0; i < baseCardTotal; i++) {
          if (i == 0) {
            cardXOffset = 0;
          }
          Effect e = cardEffects.get(int(random(0, cardEffects.size())));
          //Card deCard = defaultCard.get(i);

          cardXOffset += 100;
          defaultCard.add(new Card(width/2 - 200 + cardXOffset, height/2 + 75, 100, 150, color (123, 200, 123), 2, e));
          //defaultCard[i] = new Card(width/2 - 200 + cardXOffset, height/2 + 75, 100, 150, color (123, 200, 123), 2, e);
          //defaultCard[i].originalX

          ts.canRedraw = false;
        }
      } 
      /*else {
        //Deal Card, creating a new instance of a card object to be placed on the player's side of "play area"
        for (int i = 0; i < baseCardTotal; i++) {
          if (i == 0) {
            cardXOffset = 0;
          }
          println("Trying...");
          Effect e = cardEffects.get(int(random(0, cardEffects.size())));
          //Card deCard = defaultCard.get(i);

          cardXOffset += 100;
          defaultCard.add(new Card(width/2 - 200 + cardXOffset, height/2 + 75, 100, 150, color (123, 200, 123), 2, e));
          //defaultCard[i] = new Card(width/2 - 200 + cardXOffset, height/2 + 75, 100, 150, color (123, 200, 123), 2, e);
          //defaultCard[i].originalX

          ts.canRedraw = false;
        }
      }*/

      //player.updatePlayerCard(dcard.cardValue);
    }
  }

  //Draws player cards; in the beginning of game 5 cards are automatically put
  //in the player's 'hand'. The player can click the deck once in the beginning
  //of the game to 'redraw' cards
  void playerDraw() {
    //Deal Card, creating a new instance of a card object to be placed on the player's side of "play area"
    for (int i = 0; i < baseCardTotal; i++) {
      if (i == 0) {
        cardXOffset = 0;
      }
      Effect e = cardEffects.get(int(random(0, cardEffects.size())));
      //Card deCard = defaultCard.get(i);

      cardXOffset += 100;
      defaultCard.add(new Card(width/2 - 200 + cardXOffset, height/2 + 75, 100, 150, color (123, 200, 123), 2, e));
      //defaultCard[i] = new Card(width/2 - 200 + cardXOffset, height/2 + 75, 100, 150, color (123, 200, 123), 2, e);
      //defaultCard[i].originalX
    }
  }
  //draws enemy cards, typically happens after you press end turn when you have placed your cards down on the zone
  void enemyDraw() {
    //for (int i = 0; i < enemyCard.length; i++) {
    //  if (i == 0) {
    //    cardXOffset = 0;
    //  }
    //  Effect e = cardEffects.get(int(random(0, cardEffects.size())));

    //  cardXOffset += 100;
    //  enemyCard[i] = new Card(width/2 - 200 + cardXOffset, height/2 - 500, 100, 150, color (123, 200, 123), 2, e);
    //  enemyCard[i].isEnemy = true;
    //  //defaultCard[i].originalX
    //}
    //ts.endTurn();

    //Deal Card, creating a new instance of a card object to be placed on the player's side of "play area"
    for (int i = 0; i < baseCardTotal; i++) {
      if (i == 0) {
        cardXOffset = 0;
      }
      Effect e = cardEffects.get(int(random(0, cardEffects.size())));

      cardXOffset += 100;
      enemyCards.add(new Card(width/2 - 200 + cardXOffset, height/2 - 500, 100, 150, color (123, 200, 123), 2, e));
    }
    //ts.endTurn();
  }

  //A function to Visualize the Deck. Something similar to Display from the Card class
  void showDeck() {
    if (ts.canRedraw && !isEnemy) {
      stroke(0);
      fill(deckColorR, deckColorG, deckColorB);
      rect(deckXPos, deckYPos, deckWidth, deckHeight);
      fill(0);
      textSize(20);
      text("Deck", deckXPos + 50, deckYPos+25);

      fill(0);
      textSize(20);
      text("Redraw\n Cards?", deckXPos + 50, deckYPos + 75);
    } else {
      stroke(0);
      fill(deckColorR, deckColorG, deckColorB);
      rect(deckXPos, deckYPos, deckWidth, deckHeight);
      fill(0);
      textSize(20);
      text("Deck", deckXPos + 50, deckYPos+25);
    }
  }
}

//----------------------------------------------------

//For special/unqiue cards
//Mainly trying to make usable for anyone that wants to use it
// Stores special effects and descriptions for cards
class Effect {
  
  int cardChance = int(random(1,2));
  int specialCardValue = int(random(11,15));
  int specialCard;
  //find a way to make these the options for the card chance
  int heal = int(random(1,3));
  int damage = int(random(1,3));
  int normalCardValue = 1;
  boolean isNormal;
  
  String effectName;
  String effectDescription;
  int effectValue;
  
  Effect(String _effectName, String _effectDescription, int _effectValue) {
    
    effectName = _effectName;
    effectDescription = _effectDescription;
    effectValue = _effectValue;
    
    //if ()
  }
  
  // i dont believe this is being used atm
  // Decides if a card becomes normal or special
  void cardStatus() {
    
    if (cardChance == 1) {
      isNormal = true;
    }
    else if (cardChance == 2) {
      isNormal = false;
    }
    
    if (isNormal) {
      normalCard();
    }
    else {
      specialCard();
    }
  }
  
  // Placeholder logic for special card effects
  void specialCard() {
    //I want this to choose at random if the special card damages or heals
    if  (specialCard == specialCardValue ) {
      if (specialCardValue >+ normalCardValue ) {
    
        
      }
    }
  
  }
  
  // Placeholder logic for normal card behavior
  void normalCard() {
    //Have fucntionality where the card has attack damage values
  }
}

//-----------------------------------------------------

ArrayList<Effect> cardEffects;
//to add different effects to our cards
void addEffects() {
  cardEffects = new ArrayList<Effect>();
  
  cardEffects.add(new Effect("", "", 1));
  cardEffects.add(new Effect("Crying \nOutrage", "This card cries...", 4));
  cardEffects.add(new Effect("Careless", "This card doesn't care...", 1));
}

//To create the logic of the effects you created in "addEffects"
void run() {

}

//----------------------------------------------------

//Base class for Player-Based entities
// Stores player stats and card values
class Player {

  int playerHP = defaultHP;
  int currentCardValue = 0;
  //constructor
  Player() {
  }

  void updatePlayerCard(int cardValue) {
    currentCardValue = cardValue;
  }
}

//Base for Enemies
// Stores enemy stats and enemy turn behavior
class Enemy {
  int enemyHP = defaultHP;
  int currentCardValue = 0;
  //constructor
  Enemy() {
  }
  void updateEnemyCard(int cardValue) {
    currentCardValue = cardValue;
  }

// Controls enemy actions during enemy turn
  void updateTurn() {
    if (!ts.playerTurn) {
      //Enemy Draws card
      //enemyDeck.enemyDraw();

      //for (int i = 0; i < zones.length; i++) {
      //  enemyCard[i].xPos = zones[i].enemyZoneX;
      //  enemyCard[i].yPos = zones[i].enemyZoneY;
      //  enemyCard[i].inZone = true;
      //}
      //for (Card eCards : enemyCards) {
      //  //if (currentCard.selectedCard) {
      //  //  ts.currentPlayerAttackingCard = currentCard;
      //  //}
      //  eCards.xPos = zones
      //}
      for (int i = 0; i < zones.length; i++) {
        Card eC = enemyCards.get(i);
        if (!eC.isDestroyed) {
          eC.run();
          eC.xPos = zones[i].enemyZoneX;
          eC.yPos = zones[i].enemyZoneY;
          eC.inZone = true;
        }
        else if (eC.isDestroyed){
          eC.run();
          eC.xPos = eC.tombstoneXPos;
          eC.yPos = eC.tombstoneYPos;
          //eC.inZone = false;
        }
      }
      ts.endTurn();
    }
  }
}

//------------------------------------------------

//Timer, currently not being used
// Simple timer system for turn timing
class Timer {
  int currentTime = 0;
  int ellapsedMillis = 1000;
  int previousTime = 0;
  int timeLimit = 50; //Max 50 Seconds
 
 // Updates timer every second
  void calcTime(){
    if (currentTime < timeLimit){  
      if (millis() - previousTime >= ellapsedMillis) {
          previousTime = millis();
          currentTime += 1;
          //println("Current Time: " + currentTime);
         }
      } else {
        //println("Turn End");
    }
  }
}

//----------------------------------------------------

//possibly use enum
int turnsPlayed;
// Controls turn flow, attacks, and win/loss conditions
class TurnSystem {

  boolean playerTurn = true;
  boolean playerIsAttacking;
  boolean startOfGame = true, canRedraw;
  String gameOverText = "";
  color gameOverColor = color (0, 0, 0);
  Card currentPlayerAttackingCard;
  Card currentEnemyTarget;

  TurnSystem() {
  }

// Displays game over text on screen
  void gameOverDisplay() {
    textSize(200);
    stroke(0);
    fill(gameOverColor);
    text(gameOverText, width/2, height/2, 100);
  }

// Switches between player and enemy turns
  void endTurn() {
    //playerTurn = !playerTurn;

    if (playerTurn == true) {
      playerTurn = false;
    } else {
      playerTurn = true;
    }
    calcWinner();
  }

  //if any player or enemy reaches zero it will tell you if you won or not
  void isGameOver() {
   if (player.playerHP <= 0) {
  gameState = STATE_LOSE;
}
if (enemy.enemyHP <= 0) {
  gameState = STATE_WIN;
}

    if (startOfGame) {
      playerDeck.playerDraw();
      enemyDeck.enemyDraw();
      canRedraw = true;
      startOfGame = false;
    }
  }
  //Calculates which card wins when they are attacking each other
  void calcWinner() {
    if (playerIsAttacking && !playerTurn && currentEnemyTarget != null) {
      currentPlayerAttackingCard.cardValue -= currentEnemyTarget.damage;
      currentEnemyTarget.cardValue -= currentPlayerAttackingCard.damage;
      // Gamble system calcWinner()
      gamble.trigger();
      playerIsAttacking = false;

      for (Card currentCard : defaultCard) {
        if (currentCard.selectedCard) {
          currentPlayerAttackingCard.selectedCard = false;
          currentPlayerAttackingCard = null;
        }
      }

      for (Card targetCard : enemyCards) {
        if (targetCard.selectedCard) {
          currentEnemyTarget.selectedCard = false;
          currentEnemyTarget = null;
        }
      }
    }

    for (int i = 0; i < defaultCard.size(); i++) {
      Card dCard = defaultCard.get(i);
      dCard.cardStroke = color (0, 0, 0);

      dCard.isAttacking = false;
      dCard.selectedCard = false;
      playerIsAttacking = false;
    }

    turnsPlayed += 1;
    //ts.endTurn();
  }
}

//---------------------------------------------------

// Handles all user interface elements and buttons
class UI {
  PVector endTurnButton;
  float buttonRadius = 75;
  boolean insideButton;
  color c = color(0, 0, 0);
  int sw = 5;
  String turnTextStatus;
  //constructor
  UI(PVector pos)
  {
    endTurnButton = pos;
  }
 
  //runs all the methods inside for the UI
  void run() {
    display();
    collision();
  }

// Draws the card and updates drag movement
  void display() {

    // RESULT SCREEN
if (gamble.showResultScreen) {

 if (gamble.miniGameWon) {
    background(0, 200, 0); // green = win
    textSize(40);
    text("GOOD JOB! +5 HP", width/2, height/2);
  } else {
    background(200, 0, 0); // red = lose
    textSize(40);
    text("FAILED! -5 HP", width/2, height/2);
      fill(0);
  text("Use the mouse to click on the box", width/2, height/2 + 250);
  }

// button to return
  fill(255);
  rect(width/2 - 200, height/2 + 100, 400, 80);
  fill(0);
  text("Back to Game", width/2, height/2 + 150);
  fill(0);
  text("Use the mouse to click on the box", width/2, height/2 + 250);
}
    
    
    // MINI GAME FOR SPACE BAR SPAM
if (gamble.showMiniGame) {

  background(50);

  fill(255);
  textSize(30);
  text("SPAM Space Bar key to rise bar!", width/2, 100);

  // empty bar
  fill(100);
  rect(width/2 - 200, height/2, 400, 40);

// filled bar (progress increases when pressing space)
  fill(0, 255, 0);
  rect(width/2 - 200, height/2, gamble.miniGameProgress * 4, 40);


// instantly win if bar becomes full
if (gamble.miniGameProgress >= gamble.miniGameGoal) {

  gamble.showMiniGame = false;
  gamble.showResultScreen = true;

  gamble.miniGameWon = true;

  player.playerHP += 5;
}

  // timer countdown
  fill(255);
  text("Time: " + (gamble.miniGameTimeLimit - gamble.miniGameTimer) / 60, width/2, 200);

  gamble.miniGameTimer++;

  // when time runs out it decide result 
  if (gamble.miniGameTimer >= gamble.miniGameTimeLimit) {
    
    gamble.showMiniGame = false;
    gamble.showResultScreen = true;

    if (gamble.miniGameProgress >= gamble.miniGameGoal) {
      gamble.miniGameWon = true;
      player.playerHP += 5; // reward if player wins the minigame
    } else {
      gamble.miniGameWon = false;
      player.playerHP -= 5; // penalty if player loses the minigame
    }
  }
}
    
// =========================
// DICE MINI GAME
// =========================
if (gamble.showDiceGame) {

  dice.display();

 // Keeps player inside of dice screen
if (dice.finished) {

  // WIN
  if (dice.playerRoll > dice.enemyRoll) {

    gamble.miniGameWon = true;
  }

  // LOSE
  else if (dice.playerRoll < dice.enemyRoll) {

    gamble.miniGameWon = false;
  }

  // DRAW
  else {

    gamble.miniGameWon = false;
  }
}
} 
    
    stroke(c);
    strokeWeight(sw);
    
    //End Turn Button
    fill(200, 255, 200);
    ellipse(endTurnButton.x, endTurnButton.y, buttonRadius*2, buttonRadius*2);
    fill(0);
    textSize(25);
    
    strokeWeight(5);
    stroke(0);
    
    //once turn is ended the counter will go up by one
    text("End Turn", endTurnButton.x, endTurnButton.y);
    fill(200, 255, 200);
    text("Player HP:"+player.playerHP, width*.06, height*.7);
    text("Enemy HP:"+enemy.enemyHP, width*.06, height*.1);
    
    fill(0);
  }

// Detects mouse hovering over the end turn button
  void collision() {
    if (dist(mouseX, mouseY, endTurnButton.x, endTurnButton.y) < buttonRadius) {
      insideButton = true;
    } else {
      insideButton = false;
      c = color(0, 0, 0);
      sw = 5;
    }
  }

// Handles end turn button clicks
  void mouseClicked() {
    // for the end turn button
    if (insideButton == true)
    {
      ts.canRedraw = false;
      ts.endTurn();
      c = color(0, 0, 0);
      sw = 5;
    }
  }

// Handles menu buttons, replay buttons, and result screens
  void mousePressed()
  {
   if (gamble.showResultScreen) {
  if (mouseX > width/2 - 200 && mouseX < width/2 + 200 &&
      mouseY > height/2 + 100 && mouseY < height/2 + 180) {

    gamble.showResultScreen = false;
  }
}
    
    
   // MENU CLICK
if (gameState == STATE_MENU) {
  if (mouseX > width/2 - 150 && mouseX < width/2 + 150 &&
      mouseY > height/2 && mouseY < height/2 + 100) {

    resetGame();
    gameState = STATE_PLAY;
  }
  return;
}

// WIN / LOSE CLICK (Replay)
if (gameState == STATE_WIN || gameState == STATE_LOSE) {
  if (mouseX > width/2 - 150 && mouseX < width/2 + 150 &&
      mouseY > height/2 && mouseY < height/2 + 100) {

    resetGame();
    gameState = STATE_MENU;
  }
  return;
} 
    
    
    if (insideButton == true)
    {
      c = color(255, 0, 0);
      sw = 15;
      ts.endTurn();
    }
  }
}

// Resets the full game state back to default
void resetGame() {
  player = new Player();
  enemy = new Enemy();

  defaultCard.clear();
  enemyCards.clear();

  ts = new TurnSystem();

  // reset zones
  for (int i = 0; i < zones.length; i++) {
    zones[i].occupied = false;
  }
   // Gamble system
  gamble = new GambleSystem(); // FULL reset of gamble UI
}


//--------------------------------------------------

// Handles player and enemy card placement zones
class Zone {
  //player zone variables
  int playerZoneX, playerZoneY;
  //enemy zone variables
  int enemyZoneX, enemyZoneY;
  //shared zone variables
  int zoneWidth, zoneHeight;
  int zoneSpacing, originalZSpacing = zoneSpacing;
  int zoneSpots;
  boolean occupied;
  
  Zone(int x, int y, int zW, int zH, int zSpacing, int zSpots){
    playerZoneX = x;
    playerZoneY = y;
    
    enemyZoneX = x;
    enemyZoneY = y - 250;
    
    zoneWidth = zW;
    zoneHeight = zH;
    zoneSpacing = zSpacing;
    zoneSpots = zSpots;
  }
  
//Method to be used in void setup(). 
//Call both createPlayerZones() and createEnemyZones() to consolidate referencing in the main file
 // Creates both player and enemy zones
  void createZones() {
    createPlayerZones();
    createEnemyZones();
  }
  
  // Draws all placement zones
  void zonesDisplay() {
    //displayed both zones in one method to reduce the number of referencing in the main file
    playerZoneDisplay();
    enemyZoneDisplay();
  }
//displays zone for the player
// Draws player card zones
  void playerZoneDisplay() {
    stroke(0);
    fill(0);
    rect(playerZoneX, playerZoneY, zoneWidth, zoneHeight);
  }

//Method to create player zones to be called in void createZones()
  void createPlayerZones() {
    for (int i = 0; i < zoneSpots; i++) {
      if (i == 0) {
        zoneSpacing = 0;
      }
      else {
        zoneSpacing = originalZSpacing;
      }
      
      zoneSpacing += zoneSpacing;
      zones[i] = new Zone(playerZoneX + zoneSpacing, playerZoneY, zoneWidth, zoneHeight, zoneSpacing, zoneSpots);
    }
  }
  
//displays zone for the enemy
// Draws enemy card zones
  void enemyZoneDisplay() {
    stroke(0);
    fill(0);
    rect(enemyZoneX, enemyZoneY, zoneWidth, zoneHeight);
  }
  
//Method to create enemy zones to be called in void createZones()  
  void createEnemyZones() {
    for (int i = 0; i < zoneSpots; i++) {
      if (i == 0) {
        zoneSpacing = 0;
      }
      
      zoneSpacing += 200;
      zones[i] = new Zone(enemyZoneX + zoneSpacing, enemyZoneY, zoneWidth, zoneHeight, zoneSpacing, zoneSpots);
    }
  }
}

//---------------------------------------------------
