class Block {

  float x, y;
  float w = 50;
  float h = 50;
  int r, g, b;

  Block(float x, float y, int r, int g, int b) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
  }

  void display() {
    fill(r, g, b);
    rect(x, y, w, h);
  }
}
