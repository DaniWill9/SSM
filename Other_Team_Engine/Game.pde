//Calling objects
UI ui;
TurnSystem ts;

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
}

void draw() {
  background(100);
  
  //Draws the zones to the screen using the method in the Zone class
  for (int i = 0; i < zones.length; i++){
      zones[i].zonesDisplay();
  }
  //Displays enemy cards and handles other methods of enemy cards
  for (int i = 0; i < enemyCard.length; i++) {
        enemyCard[i].run();
  }
  //Displays player cards and handles other methods of player cards
  for (int i = 0; i < defaultCard.size(); i++){
    Card dC = defaultCard.get(i);
    dC.run();
    //defaultCard[i].run();
  }
  //Displays enemy cards and handles other methods of enemy cards
  for (int i = 0; i < enemyCards.size(); i++){
    Card eC = enemyCards.get(i);
    eC.isEnemy = true;
    eC.run();
    //defaultCard[i].run();
  }
  
  // Shows both decks, runs the ui methods and ends the turn for the player when done
  enemyDeck.showDeck();
  playerDeck.showDeck();
  ui.run();
  enemy.updateTurn();
  ts.gameOverDisplay();
  ts.isGameOver();
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
