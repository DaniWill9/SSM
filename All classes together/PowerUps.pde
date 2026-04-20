//POWERUPS CLASS
//Handles abilites like speed, bombs to destroy blocks etc
// PowerUp base class used for items that give effects
// Keeps things simple so new types can be added easily
class PowerUp {
  float x, y;
  float size = 20;

  PowerUp(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  // Draws the powerup as a small circle
  void display() {
    fill(240, 197, 24); // color of powerup: yellow
    ellipse(x, y, size, size);
  }
 
  //this looks weird because it's empty, but it is here to auto-insert the needed child class
  void apply(Player player){
// Base powerup does nothing yet, player is passed for child classes
   }
}

//POWERUP SUBCLASSES
//SPEEDBOOST
//when players step on it, it increases their speed for a short duration
class SpeedPowerUp extends PowerUp {
  //timer set to 10s
  int duration = 600; // if 60 fps = 600 frames
  int speedTimer = duration; //sets the timer to the duration when applied
  
  SpeedPowerUp (float x, float y){
    super (x,y);
   }
   
  void display(){
    fill (0,200,255);
    ellipse (x,y,size,size);
  }
  
  void apply(Player player){
    player.moveSpeed += 2; //how fast the speed boost is
  }
}

//BOMB POWERUP
//When players step on it, it destroys all blocks in a certain radius around them
class BombPowerUp extends PowerUp {
  BombPowerUp (float x, float y) {
    super(x, y);
  }
  
  void display() {
    fill (134, 41, 27); // color of bomb: dark-red
    stroke (255,0,0);
    ellipse (x, y, size, size);
  }

  void apply(Player player) {
    float range = 100;
   
   //looping backwards through blocks, it removes all blocks within a radius around the player 
    for (int i = onScreenBlocks.size()-1; i >=0; i--) {
      Block b= onScreenBlocks.get(i);
      float centerX = b.x + b.w/2;
      float centerY = b.y + b.h/2;
      
      if (dist (player.x,player.y,centerX,centerY) < range){
        onScreenBlocks.remove(i);
      }
    }  
  }
}
