   //SPIKE BLOCK
  // Touching it resets the player

class SpikeBlock {

  // Spike position
  float x, y;

  // Spike size (same as block size)
  float w = 50;
  float h = 50;

  // Sets spike position
  SpikeBlock(float x, float y) {
    this.x = x;   // X position
    this.y = y;   // Y position
  }

 // Draws a red triangle to show danger clearly
// Used as a trap that resets the player when touched
  void display() {
    fill(200, 50, 50);  // red color

    // Triangle pointing upward
    triangle(
      x, y + h,   // left bottom
      x + w/2, y,       // top
      x + w, y + h    // right bottom
    );
  }
}
