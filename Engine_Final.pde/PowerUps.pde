//POWERUPS CLASS
//Handles abilites like speed, bombs to destroy blocks etc.
class PowerUp {
  float x, y;
  float size = 20;

  PowerUp(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    ellipse(x, y, size, size);
  }
 
  //this looks weird because it's empty, but it is here to auto-insert the needed child class
  void apply(Player player) {
  //start loopiing through child classes
  }
}

//POWERUP SUBCLASSES
//SPEEDBOOST
//when players step on it, it increases their speed for a short duration
class SpeedPowerUp extends PowerUp {
  SpeedPowerUp (float x, float y) {
    super (x,y);
  }
   
  void display(){
    fill (0,200,255);
    ellipse (x,y,size,size);
  }
  
  void apply(Player player) {
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
    push();
    fill (134, 41, 27); // color of bomb: dark-red
    //stroke (232, 41, 242);
    ellipse (x, y, size, size);
    pop();
  }

  void apply(Player player) {
    float range = 100;
   
   //looping backwards through blocks, it removes all blocks within a radius around the player 
    for (int i = onScreenBlocks.size()-1; i >=0; i--) {
      Block b= onScreenBlocks.get(i);
      float centerX = b.x + b.w/2;
      float centerY = b.y + b.h/2;
      
      if (dist (player.x,player.y,centerX,centerY) < range) {
        onScreenBlocks.remove(i);
      }
    }  
  }
}
