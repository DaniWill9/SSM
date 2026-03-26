class PowerUp {
  float x, y;
  float size = 20;

  PowerUp(float x, float y) {
    this.x = x;
    this.y = y;
  }//end of Powerup params

  void displayPowerUp() {
    fill (240, 197, 24); //yellow
    ellipse (x, y, size, size);
  }
  
  void apply(Player player){
  //start loopiing through child classes
   }
}//end class PowerUp

class SpeedPowerUp extends PowerUp {
  SpeedPowerUp (float x, float y){
    super (x,y);
   }
   
  void displayPowerUp(){
    fill (0,200,255);
    ellipse (x,y,size,size);
  }
  
  void apply(Player player){
    player.moveSpeed += 2;
  }
}

class BombPowerUp extends PowerUp {
  BombPowerUp (float x, float y) {
    super(x, y);
  }
  
  void displayPowerUp() {
    fill (134, 41, 27); //dark-red
    ellipse (x, y, size, size);
  }
  void apply(Player player) {
    float range = 100;
   
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
