//Ziggy
class Beam {
  float x, y; // beams x and y position
  float xSpeed, ySpeed; // horizontal speed, vertical speed
  float w,h; //width, height

  Beam(float iX, float iY, float hSpeed, float vSpeed, float beamW, float beamH) {
    x = iX; //Inital starting points for beams X axis
    y = iY; //starting points for beams Y axis
    xSpeed = hSpeed; //Horizontal Speed
    ySpeed = vSpeed;//Vertical speed
    beamW=5; //Beam's width
    beamH=3;// Beam's height
    w = beamW;//substitute for beam widths
    h = beamH;// substitute for beam height
  }

//Moves beam
  void update() {
    x += xSpeed; // left and  right speeds
    y += ySpeed; //up and down speeds
  }

//shows beam 
  void display() {
    fill(0); //color for beam
    rect(x, y, w,h); //beam
  }

//checks if offscreen
  boolean isOffScreen() {
    return (x < 0 || x > width || y < 0 || y > height); // when is it offScreen
  }
}
