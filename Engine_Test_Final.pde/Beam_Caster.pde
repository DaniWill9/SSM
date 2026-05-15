//Ziggy
class Caster {
  float x, y; // caster position
  float beamX, beamY,beamW, beamH; // beam position && Width/Height
  float speed; 
  boolean active = false;
  
  Caster(float iX, float iY) {
    x = iX; //initial X
    y = iY; //inital Y
    beamX= x; //Beam x pos
    beamY= y; //beam y pos
    speed=5; //speed
  }

 

  void display() {
    //Caster
    fill(50);
    stroke (0, 0, 0);
    rect(x-15, y-15, 30, 30); 

    // Draw beam only in play mode
    if (active==true) {
      rect(beamX, y, 10, 10);
    }
  }

  // Call this when switching to play mode
  void activate() {
    active = true;
    beamX = x;
    beamY = y;
  }

  // Call this when switching back to build mode
  void deactivate() {
    active = false;
    beamX = x;
    beamY = y;
  }
  
  void update(Player red, Player blue) {
        if (active==false) return; // not to shoot in build mode
    
    beamX+= speed;
    

    // Reset beam if off-screen
    if (beamX > width) {
      beamX= x;
    }
  

    // Red player collision if hit reset
   if (beamX < red.x + red.w &&
    beamX + beamW > red.x && beamY < red.y + red.h && beamY + beamH > red.y){
    red.x = red.startX;
    red.y = red.startY;
    red.vx = 0;
    red.vy = 0;
}

    // BluePlayer Collision, if hit reset
    if (beamX < blue.x + blue.w && beamX + beamW > blue.x && beamY < blue.y + blue.h &&beamY + beamH > blue.y){
      blue.x = blue.startX;
      blue.y = blue.startY;
      blue.vx = 0;
      blue.vy = 0;
    }
    }
  }
