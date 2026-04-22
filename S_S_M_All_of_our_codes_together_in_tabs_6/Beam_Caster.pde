//Ziggy
class Caster {
  float x, y, shoot; // caster x and y position, shoots beam
  float beamX, beamY,beamW, beamH; // beam position && Width/Height
  float xSpeed,ySpeed;  // X axis speed and Y axis speed
  boolean active = false; // Tells beam when to shoot. Stays false til beam is ready to shoot
  ArrayList<Beam> beams;// creates list of multiple beams.
  int f, frameShot; // Tells when to shoot since background doesn't change

  Caster(float iX, float iY) {
    x = iX; //initial X
    y = iY; //inital Y
    beamX= x; //Beam x pos
    beamY= y; //beam y pos
    xSpeed= random(-5,5); //random X position speed
    ySpeed= random(-5,5); //Random Y position
    beams = new ArrayList<Beam>(); //Creates beam in instance
    frameShot=50; //Frames to wait to shoot next beam
    f=frameShot; //every how many frames beam is Shot
  }

 

  void display() {
    
    //Whem it'll draw beams and what to show
    if (active==true) {
  for (Beam b : beams) {
    b.display();
  }
  }
  
  //Caster
    fill(50); //color
    rect(x-15, y-15, 30, 30); //Caster's properties [x position,y position,width,height]
  }
  // Assigns active to true
  void activate() {
    active = true;
    beamX = x; //updates beams x
    beamY = y; //update beams y
  }

  // Sets when beam's are inactive
  void deactivate() {
    active = false;
    beamX = x; //stops beam x position
    beamY = y; //stops beam's y
    beams.clear(); //stops beams
  }
  
  void update(Player red, Player blue) {
        if (active==false) return; // Not to shoot til ready
         
         if(frameCount%f==0){ //frames it will be shot
          shoot(xSpeed, ySpeed);  // beams being shot
         }
 
    //Loops beams shot
 for (int i = beams.size() - 1; i >= 0; i--) {
    Beam b = beams.get(i); //beam = b, beam's position
    b.update(); //uses update to display new positions
    
    // if off-screen deletes beam
     if (b.isOffScreen()) {
            beams.remove(i); 
            continue;
}
 
    // Red players collision if hit reset
   if (beamX < red.x + red.w && b.x + beamW > red.x && b.y < red.y + red.h && b.y + b.h > red.y){
    red.x = red.startX; // x position for red
    red.y = red.startY; // y position for red
   }

    // Blue player's collisions, if hit reset
    if (b.x < blue.x + blue.w && b.x + b.w > blue.x && b.y < blue.y + blue.h &&b.y + b.h > blue.y){
      blue.x = blue.startX; // x position for blue
      blue.y = blue.startY; // y position for blue 
   }
 
    }
    }
    //Shoots beam with speed
  void shoot(float xSpeed, float ySpeed) {
    beams.add(new Beam(x, y, xSpeed, ySpeed, beamW, beamH)); // adds beam and sets parameters
  }

   
}
