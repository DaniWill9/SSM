// BLOCK CLASS
// Used to create solid blocks that players can stand on or collide with.
// Each block has a position, size, and color. Blocks are placed in Build Mode
// and displayed during Play Mode for both players.

class Block {

  // Position of the block on screen
  float x, y;

  // Size of the block (width and height)
  float w = 50;
  float h = 50;

  // Color values for the block (RGB)
  int r, g, b;

  // Constructor
  // Sets up the block’s position and color
  Block(float x, float y, int r, int g, int b) {
    this.x = x;   // X position
    this.y = y;   // Y position
    this.r = r;   // Red color value
    this.g = g;   // Green color value
    this.b = b;   // Blue color value
  }

  // DISPLAY BLOCK
  // Draws the block as a colored rectangle on screen
  void display() {
    fill(r, g, b);   // Apply color
    rect(x, y, w, h); // Draw the block shape
  }
}
