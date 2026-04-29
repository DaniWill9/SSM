//Calling objects
UI ui;
TurnSystem ts;

// Gamble System
GambleSystem gamble;

// game states to make things run smootly
int gameState;

final int STATE_MENU = 0;
final int STATE_PLAY = 1;
final int STATE_WIN = 2;
final int STATE_LOSE = 3;

Card[] enemyCard = new Card[5];
ArrayList<Card> enemyCards = new ArrayList<Card>();
ArrayList<Card> defaultCard = new ArrayList<Card>();
//Card selectedCard;
Zone[] zones = new Zone[5];
//Zone zones;
//Card pCard = new Array();
Deck playerDeck;
Deck enemyDeck;
Player player;
Enemy enemy;
Timer gameTimer;

Collision collision;

int defaultHP = 20, baseCardTotal = 5;

int enemyCardValue = 0;

void setup() {
 
  // Gamble system for setup
  gamble = new GambleSystem();
  
  pixelDensity(1);
  size(1500,1000);
  //fullScreen();
  //rectMode(CENTER);
  textAlign(CENTER);
  
  addEffects();
  collision = new Collision();
  
  gameTimer = new Timer();
  //dcard = new Card(100, 600);
  
  //pCard1 = new Card (width/2, height/2);
  //Calls decks onto the main file
  enemyDeck = new Deck(width/2 + 500, height/2 - 300, 155, 55, 55);
  enemyDeck.isEnemy = true;
  playerDeck = new Deck(width/2 + 500, height/2 + 100, 123, 200, 123);
  
  //Calls the cards but for an array
  for (int i = 0; i < enemyCard.length; i++) {
    Effect e = cardEffects.get(int(random(0, 3)));
    enemyCard[i] = new Card(width/2 + 2500, height/2 - 2300, 100, 150, color (123, 200, 123), 2, e);
    enemyCard[i].isEnemy = true;
  }
  
  //for (int i = 0; i < defaultCard.size(); i++) {
  //  Effect e = cardEffects.get(int(random(0, 3)));
  //  Card dC = defaultCard.get(i);
  //  dC = new Card(width/2 + 1000, height/2 + 400, 100, 150, color (123, 200, 123), 2, e);
  //  dC.isPlayer = true;
  //  //defaultCard[i] = new Card(width/2 + 1000, height/2 + 400, 100, 150, color (123, 200, 123), 2, e);
  //  //defaultCard[i].isPlayer = true;
  //}
  
  for (int i = 0; i < zones.length; i++) {
    zones[i] = new Zone(width/2 - 750, height/2 + 150, 100, 150, 200, 5);
    zones[i].createZones();
  }
  
  ts = new TurnSystem();
  ui = new UI(new PVector (width/2 + 550, height/2));
  player = new Player();
  enemy = new Enemy();
  
  //collisions = new Collisions();
  
  gameState = STATE_MENU;
}

void drawGame() {
  background(100);
  
  if (gameState == STATE_MENU) {
    drawMenu();
    return;
  }
  else if (gameState == STATE_PLAY) {
    // DO NOTHING HERE (this is the actual game rendering below)
  }
  else if (gameState == STATE_WIN) {
    drawWin();
    return;
  }
  else if (gameState == STATE_LOSE) {
    drawLose();
    return;
  }

  // --- GAME RUNS ONLY IN PLAY STATE ---

  for (int i = 0; i < zones.length; i++){
    zones[i].zonesDisplay();
  }

  for (int i = 0; i < enemyCard.length; i++) {
    enemyCard[i].run();
  }

  for (int i = 0; i < defaultCard.size(); i++){
    Card dC = defaultCard.get(i);
    dC.run();
  }

  for (int i = 0; i < enemyCards.size(); i++){
    Card eC = enemyCards.get(i);
    eC.isEnemy = true;
    eC.run();
  }

  enemyDeck.showDeck();
  playerDeck.showDeck();
  ui.run();
  enemy.updateTurn();
  ts.gameOverDisplay();
  ts.isGameOver();

  gamble.display();
}

void drawMenu() {
  background(50);

  fill(255);
  textSize(60);
  text("Card Game", width/2, height/3);

  fill(0, 200, 0);
  rect(width/2 - 150, height/2, 300, 100);

  fill(255);
  textSize(30);
  text("Press to Play", width/2, height/2 + 60);
}

void drawWin() {
  background(0, 150, 255);

  fill(255);
  textSize(60);
  text("YOU WIN", width/2, height/3);

  fill(0, 200, 0);
  rect(width/2 - 150, height/2, 300, 100);

  fill(255);
  textSize(25);
  text("Replay", width/2, height/2 + 60);
}

void drawLose() {
  background(150, 0, 0);

  fill(255);
  textSize(60);
  text("YOU LOSE", width/2, height/3);

  fill(0, 200, 0);
  rect(width/2 - 150, height/2, 300, 100);

  fill(255);
  textSize(25);
  text("Replay", width/2, height/2 + 60);
}

void draw() {
  drawGame();

}

void mousePressed() {
  //allows the deck to be pressed
  playerDeck.mousePressed();
  //pCard1.mousePressed();
  
  //allows the cards to be pressed and hovered on the mousex and mousey
  ui.mousePressed();
  for (int i = 0; i < defaultCard.size(); i++) {
    Card dC = defaultCard.get(i);
    dC.run();
    dC.mousePressed();
    //defaultCard[i].run();
    //defaultCard[i].mousePressed();
  }
  //allows the cards to be pressed and hovered on the mouseX and mouseY
  for (int i = 0; i < enemyCards.size(); i++) {
    Card eC = enemyCards.get(i);
    eC.run();
    eC.mousePressed();
    //defaultCard[i].run();
    //defaultCard[i].mousePressed();
  }
  //im not sure what this does exactly - kobe (to be edited)
  for (int i = 0; i < enemyCard.length; i++) {
    enemyCard[i].mousePressed();
  }
}
//allows the end turn button to be clicked
void mouseClicked() {
  ui.mouseClicked();
}
// turns the card you are holding to not be dragged anymore
void mouseReleased(){
  
  //collisions.mouseReleased();
  
 for (int i = 0; i < defaultCard.size(); i++){
   Card dC = defaultCard.get(i);
   dC.mouseReleased();
   //defaultCard[i].mouseReleased();
  } 
}

void mouseDragged() {
  

}
void keyPressed(){

  for (int i = 0; i < defaultCard.size(); i++){
    //Card dC = defaultCard.get(i);
    //dC.keyPressed();
    //defaultCard[i].keyPressed();
  }
}
