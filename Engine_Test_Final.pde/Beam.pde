//Ziggy
class Beam {
  float x, y;
  float xSpeed, ySpeed;

  Beam(float iX, float iY, float hSpeed, float vSpeed) {
    x = iX; //Inital starting points for beams X axis
    y = iY; //starting points for beams Y axis
    xSpeed = hSpeed; //horizontal Speed
    ySpeed = vSpeed;//Vertical speed
  }

//Moves beam
  void update() {
    x += xSpeed; // left and  right
    y += ySpeed; //up and down
  }

//shows beam 
  void display() {
    fill(0);
    rect(x, y, 10, 10); //beam
  }

//checks if offscreen and resets
  boolean isOffScreen() {
    return (x < 0 || x > width || y < 0 || y > height);
  }
}
