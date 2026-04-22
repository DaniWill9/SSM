// PLATFORM CLASS
// Simple platform used for start/finish areas or ground
// Draws a black rectangle for the ground or flag base
class Platform {
  
  // Position and size of the platform
  float x, y, w, h;

  // Constructor 
  // Sets up the platform's position and size
  Platform(float px, float py, float pw, float ph) {
    x = px;   // X position
    y = py;   // Y position
    w = pw;   // width
    h = ph;   // height
  }

// DRAW PLATFORM
  // Draws the platform as a black rectangle
  void drawPlatform() {
      fill(0);          // black color
    rect(x, y, w, h); // draw shape
  }
}
